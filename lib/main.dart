import 'package:ecom_admin/pages/category_page.dart';
import 'package:ecom_admin/pages/dashbord_page.dart';
import 'package:ecom_admin/pages/launcher_page.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/pages/order_page.dart';
import 'package:ecom_admin/pages/product_page.dart';

import 'package:ecom_admin/pages/report_page.dart';
import 'package:ecom_admin/pages/settings_page.dart';
import 'package:ecom_admin/pages/user_page.dart';
import 'package:ecom_admin/providers/order_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProductProvider(),),
    ChangeNotifierProvider(create: (context) => OrderProvider(),),
    ChangeNotifierProvider(create: (context) => UserProvider(),),
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      builder: EasyLoading.init(),
      routes: {
        LauncherPage.routeName : (context) => LauncherPage(),
        DashbordPage.routeName : (context) => DashbordPage(),
        LoginPage.routeName : (context) => LoginPage(),
        ProductPage.routeName : (context) => ProductPage(),
        CategoryPage.routeName : (context) => CategoryPage(),
        OrderPage.routeName : (context) => OrderPage(),
        UserPage.routeName : (context) => UserPage(),
        SettingsPage.routeName : (context) => SettingsPage(),
        ReportPage.routeName : (context) => ReportPage(),
      },
    );
  }
}

