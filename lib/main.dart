import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job/page/intro/intro_page.dart';
import 'package:job/page/seeker/connect_seeker.dart';
import 'package:job/page/seeker/cv_profile_seeker.dart';
import 'package:job/page/seeker/dashboard_seeker.dart';
import 'package:job/page/seeker/home_seeker.dart';
import 'package:job/page/seeker/profile_seeker.dart';
import 'package:job/page/user/login.dart';
import 'package:job/page/user/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemPurple,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}