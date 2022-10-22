import 'package:ecom_admin/models/dashbord_item.dart';
import 'package:flutter/material.dart';

class DashboardItemView extends StatelessWidget {
  final DashboardItem item;
  final Function(String) onPressed;

  const DashboardItemView(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(item.title);
      },
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              item.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
