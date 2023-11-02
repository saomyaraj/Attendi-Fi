import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';
import 'firstscreen_selectuser.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: Studentmain(),
  ));
}
class Studentmain extends StatefulWidget {
  Studentmain();

  @override
  State<Studentmain> createState() => _StudentmainState();
}

class _StudentmainState extends State<Studentmain> {
  String deviceIp = '...';
  String routerIp = '...';

  @override
  void initState() {
    super.initState();
    updateWifiInfo();
  }

  Future<void> updateWifiInfo() async {
    try {
      final wifiInfo = await WifiInfoPlugin.wifiDetails;
      setState(() {
        deviceIp = wifiInfo?.ipAddress ?? '...';
        routerIp = wifiInfo?.routerIp ?? '...';
      });
    } catch (e) {
      print("Error fetching WiFi info: $e");
    }

    // Schedule the next update
    Timer(Duration(seconds: 5), updateWifiInfo);
    print("Router IP:"+routerIp+"     IP:"+deviceIp);
  }
  final user=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(30, 100, 30, 0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffa58fd2), Color(0xffddc3fc)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
              ),
              height: size.height*0.5,
              width: size.width,
              child: Text(
                "Hello User,",
                style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              ),
              margin: EdgeInsetsDirectional.fromSTEB(0, size.height*0.25, 0, 0),
              padding: EdgeInsetsDirectional.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  TextFormField(
                      controller: user,
                      decoration: InputDecoration(
                        hintText: "  Enter session Id",
                        hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
                        contentPadding: EdgeInsets.only(top: 15, bottom: 15),
                        border: OutlineInputBorder(  // Use OutlineInputBorder for a border
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), // Customize the border radius
                          borderSide: BorderSide(color: Colors.grey),  // Specify the border color
                        ),
                      )
                  ),
                  TextButton(onPressed: startattendance,
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
                            "Mark Attendance",
                            style: GoogleFonts.robotoSlab(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),),

                ],
              ),
              height: size.height*0.75,
              width: size.width,
            )
          ],
        ),
      ),
    );
  }
}
void startattendance(){
  print("object");
}

