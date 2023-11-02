import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';
import 'firstscreen_selectuser.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: Facultymain(),
  ));
}
class Facultymain extends StatefulWidget {
  Facultymain();

  @override
  State<Facultymain> createState() => _FacultymainState();
}

class _FacultymainState extends State<Facultymain> {
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
                        "Start Attendance",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),),
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
                            "Stop Attendance",
                            style: GoogleFonts.robotoSlab(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),),
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
                            "Export to Excel",
                            style: GoogleFonts.robotoSlab(
                              color: Colors.white,
                              fontSize: 17.5,
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