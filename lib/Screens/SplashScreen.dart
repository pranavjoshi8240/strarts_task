import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Main_Home_Screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      goToNext();
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> goToNext() async {
    Get.off(()=>const MainListScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: FlutterLogo(size: 200,)),
        ),
      ),
    );
  }
}
