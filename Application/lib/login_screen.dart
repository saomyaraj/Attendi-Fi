import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:server_app/faculty_main.dart';
import 'package:server_app/firstscreen_selectuser.dart';
import 'package:server_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:server_app/student_main.dart';

class HomePage extends StatelessWidget {
  bool isFaculty=false;
  HomePage(bool Facultyornot){
    isFaculty=Facultyornot;
  }
  var userid=TextEditingController();
  var pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: DrawClip2(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffa58fd2), Color(0xffddc3fc)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: DrawClip(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffddc3fc), Color(0xff91c5fc)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(onPressed:(){ Backtofirst(context);},
                        icon: Icon(Icons.arrow_back_sharp),
                    iconSize: 25,
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.topLeft, // Align to the left
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "      Login",
                    style: GoogleFonts.ubuntu(
                      color: Color(0xff6a74ce),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Center(
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 4,
                            offset: Offset(0,1.5),
                          )
                        ]
                      ),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadiusDirectional.circular(10),
                      //   border:Border.all(color:Color(0xff6a74ce),
                      //   )
                      // ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: userid,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(top: 15, bottom: 15),
                                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                                  )
                              ),
                            ),
                          Container(
                            height: 0.5,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[100],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: pass,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(top: 15, bottom: 15),
                                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                                  )
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      width: 300,
                      child: TextButton(
                        onPressed: () async {
                          if (userid.text.isNotEmpty && pass.text.isNotEmpty) {
                            if (isFaculty == true) {
                              final response = await http.post(
                                Uri.parse("http://192.168.0.114:5000/loginasfaculty"),
                                body: json.encode({'user': userid.text, 'pass': pass.text}),
                              );
                              if (response.statusCode == 200) {
                                final decoded = json.decode(response.body) as Map<String, dynamic>;
                                if (decoded['status'] == 'success') {
                                  Navigatetomainfaculty(context);
                                } else {
                                  // Show an error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(child: Text('Login failed. Please check your credentials.')),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            }
                            else{
                              final response = await http.post(
                                Uri.parse("http://10.0.2.2:5000/loginasstudent"),
                                body: json.encode({'user': userid.text, 'pass': pass.text}),
                              );
                              if (response.statusCode == 200) {
                                print("Inside student status 200");
                                final decoded = json.decode(response.body) as Map<String, dynamic>;
                                print("+++++++ "+decoded['status']);
                                if (decoded['status'] == 'success') {
                                  print("Status:"+decoded['status']);
                                  Navigatetomainstudent(context);
                                } else {
                                  // Show an error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(child: Text('Login failed. Please check your credentials.')),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            }
                          }

                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff6a74ce),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            height: 50,
                            child: Center(
                              child: Text(
                                "Login",
                                style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Forgot your password?",
                      style: GoogleFonts.ubuntu(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void Navigatetomainfaculty(context){
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => Facultymain())
  );
}

void Navigatetomainstudent(context){
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Studentmain())
  );
}
void Backtofirst(context){
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => firstscreen())
  );
}
class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.50);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 3, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}