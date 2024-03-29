import 'package:ecom_admin/pages/dashbord_page.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName='/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(AuthService.user == null) {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, DashbordPage.routeName);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();

  }
}
