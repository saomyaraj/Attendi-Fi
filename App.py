import json
import random

from flask import Flask, request, jsonify
import pymysql
import yaml

app = Flask(__name__)
app.secret_key = 'kushop007'

# Configure db
db = yaml.safe_load(open('db.yaml'))
mysql_host = db['mysql_host']
mysql_user = db['mysql_user']
mysql_password = db['mysql_password']
mysql_db = db['mysql_db']

def get_connection():
    return pymysql.connect(host=mysql_host, user=mysql_user, password=mysql_password, db=mysql_db)

@app.route('/loginasfaculty', methods=['POST'])
def login_as_faculty():
    msg = ''
    connection = get_connection()
    cursor = connection.cursor()

    if request.method == 'POST':
        try:
            data = request.data  # Access the raw text data from the request body
            data_dict = json.loads(data.decode('utf-8'))  # Parse the text as YAML if it's in YAML format
            if data_dict is not None and 'user' in data_dict and 'pass' in data_dict:
                ID = data_dict['user']
                Pass = data_dict['pass']
                print(ID, Pass)
                cursor.execute('SELECT * FROM facultyauthentication WHERE FacultyID=%s AND Password=%s', (ID, Pass))
                record = cursor.fetchone()
                if record:
                    return jsonify({'status': 'success', 'message': 'Login successful'})
                else:
                    return jsonify({'status': 'fail', 'message': 'Incorrect username or password'})
            else:
                return jsonify({'status': 'fail', 'message': 'Invalid data format'})
        except Exception as e:
            return jsonify({'status': 'error', 'message': str(e)})
        finally:
            cursor.close()
            connection.close()

@app.route('/loginasstudent', methods=['POST'])
def login_as_student():
    msg = ''
    connection = get_connection()
    cursor = connection.cursor()

    if request.method == 'POST':
        try:
            data = request.data  # Access the raw text data from the request body
            data_dict = json.loads(data.decode('utf-8'))  # Parse the text as YAML if it's in YAML format
            if data_dict is not None and 'user' in data_dict and 'pass' in data_dict:
                ID = data_dict['user']
                Pass = data_dict['pass']
                print(ID, Pass)
                cursor.execute('SELECT * FROM studentauthentication WHERE Roll_number=%s AND Stu_Password=%s', (ID, Pass))
                record = cursor.fetchone()
                if record:
                    return jsonify({'status': 'success', 'message': 'Login successful'})
                else:
                    return jsonify({'status': 'fail', 'message': 'Incorrect username or password'})
            else:
                return jsonify({'status': 'fail', 'message': 'Invalid data format'})
        except Exception as e:
            return jsonify({'status': 'error', 'message': str(e)})
        finally:
            cursor.close()
            connection.close()

@app.route('/start_session', methods=['POST'])
def start_session():
    connection = get_connection()
    cursor = connection.cursor()
    if request.method == 'POST':
        data = request.data  # Access the raw text data from the request body
        data_dict = json.loads(data.decode('utf-8'))
        IP_address = data_dict['ip_address']
        Faculty_ID = data_dict['faculty_id']
        Date_time = data_dict['date_time']
        print(IP_address,Date_time,Faculty_ID)
        Session_ID = random.randint(100000, 999999)
        Session_ID_Str='S'+str(Session_ID)
        cursor.execute('INSERT INTO sessionauthentication (IP_address, Session_ID) VALUES (%s, %s)',(IP_address, Session_ID_Str))
        cursor.execute('INSERT INTO sessionDetails (Session_ID, Faculty_ID, Date_time) VALUES (%s, %s, %s)',(Session_ID_Str, Faculty_ID, Date_time))
        # creating a new roll number table
        try:
            cursor.execute("CREATE TABLE `{}` (Roll_number varchar(12) primary key)".format(Session_ID_Str))
            return jsonify({'status': 'table created successfully'})
        except Exception as e:
            return jsonify({"error": f"Error: {e}"})

    return jsonify({'message': 'Session has started.'})

@app.route('/mark_attendance',methods = ['POST'])
def mark_attendance():
    connection = get_connection()
    cursor = connection.cursor()
    if request.method == 'POST':
        try:
            data = request.data  # Access the raw text data from the request body
            data_dict = json.loads(data.decode('utf-8'))
            #app sending data
            IP_address = data_dict['ip_address']
            Session_ID = data_dict['session_id']
            Session_ID='S'+str(Session_ID)
            Roll_number = data_dict['roll_number']
            print(IP_address,Session_ID,Roll_number)
            cursor.execute('SELECT * FROM sessionauthentication where Session_ID = %s AND IP_address = %s',(Session_ID,IP_address))
            record = cursor.fetchone()
            if record:
                # Use placeholders to insert data into the table and avoid SQL injection
                insert_query = f'INSERT INTO {Session_ID} (Roll_number) VALUES (%s)'
                cursor.execute(insert_query, (Roll_number,))
                connection.commit()
                return jsonify({'status': 'attendance marked'})
            else:
                return jsonify({'message': 'database does not exist'})

        except Exception as e:
            return jsonify({'error':f'{e}'})

@app.route('/add_attendance',methods = ['POST'])
def edit_attendance():
    connection = get_connection()
    cursor = connection.cursor()
    if request.method == 'POST':
        data = request.data  # Access the raw text data from the request body
        data_dict = json.loads(data.decode('utf-8'))
        Roll_number = data_dict['roll_number']
        Session_ID = data_dict['session_id']
        Session_ID='S'+str(Session_ID)
        try:
            # Use placeholders to insert data into the table and avoid SQL injection
            insert_query = f'INSERT INTO {Session_ID} (Roll_number) VALUES (%s)'
            cursor.execute(insert_query, (Roll_number,))
            connection.commit()
            return jsonify({'status': 'attendance marked'})
        except Exception as e:
            return jsonify({'message':f'{e}'})

@app.route('/remove_attendance',methods = ['POST'])
def remove_attendance():
    connection = get_connection()
    cursor = connection.cursor()
    if request.method == 'POST':
        data = request.data  # Access the raw text data from the request body
        data_dict = json.loads(data.decode('utf-8'))
        Roll_number = data_dict['roll_number']
        Session_ID = data_dict['session_id']
        Session_ID = 'S' + str(Session_ID)
        try:
            # Use a placeholder for the condition in the DELETE statement
            delete_query = f'DELETE FROM {Session_ID} WHERE Roll_number = %s'
            cursor.execute(delete_query, (Roll_number,))
            connection.commit()
            return jsonify({'status': 'attendance removed'})
        except Exception as e:
            return jsonify({'message': f'{e}'})


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
