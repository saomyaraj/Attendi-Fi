import 'package:flutter/material.dart';
import 'package:server_app/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(MaterialApp(
    home: firstscreen(),
  ));
}

class firstscreen extends StatefulWidget {
  @override
  State<firstscreen> createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen> {

  bool iffaculty=false;

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(iffaculty),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: DrawClip2(),
                  child: Container(
                    width: size.width,
                    height: size.height * 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffa58fd2), Color(0xffddc3fc)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.bottomRight),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: DrawClip(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffddc3fc), Color(0xff91c5fc)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Welcome",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              iffaculty = true; // Set to true for faculty login
                            });
                            navigateToLoginScreen(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff6a74ce),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Login as Faculty",
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              iffaculty = false; // Set to false for student login
                            });
                            navigateToLoginScreen(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff6a74ce),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Login as Student",
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 100,)
                      ],
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.8);
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