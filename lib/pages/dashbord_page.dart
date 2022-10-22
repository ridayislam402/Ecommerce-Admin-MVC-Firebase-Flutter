import 'package:ecom_admin/customwidgets/dashboard_item_view.dart';
import 'package:ecom_admin/pages/category_page.dart';
import 'package:ecom_admin/pages/order_page.dart';
import 'package:ecom_admin/pages/product_page.dart';
import 'package:ecom_admin/pages/report_page.dart';
import 'package:ecom_admin/pages/settings_page.dart';
import 'package:ecom_admin/pages/user_page.dart';
import 'package:flutter/material.dart';
import '../models/dashbord_item.dart';

class DashbordPage extends StatelessWidget {
  static const String routeName = '/dashbord';

  const DashbordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashbord'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: dashbordItems.length,
        itemBuilder: (context, index) => DashboardItemView(
          item: dashbordItems[index],
          onPressed: (value) {
            final route = navigate(value);
            Navigator.pushNamed(context, route);
          },
        ),
      ),
    );
  }

String navigate(String value) {
    String route = '';
    switch(value) {
      case DashboardItem.product:
        route = ProductPage.routeName;
        break;
      case DashboardItem.category:
        route = CategoryPage.routeName;
        break;
      case DashboardItem.order:
      route = OrderPage.routeName;
        break;
      case DashboardItem.user:
        route = UserPage.routeName;
        break;
      case DashboardItem.settings:
      route = SettingsPage.routeName;
        break;
      case DashboardItem.report:
      route = ReportPage.routeName;
        break;
    }
    return route;
}
}
