import 'package:ecom_admin/providers/user_provider.dart';
import 'package:ecom_admin/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  static const String routeName = '/user';
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All User'),),
      body: Consumer<UserProvider>(
          builder: (context, provider, child) =>
        ListView.builder(
          itemCount: provider.userList.length,
          itemBuilder: (context, index) {
            final user = provider.userList[index];
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text(user.name ?? 'UnKnown'),
                trailing: Text('Registered on ${getFormattedDataTime(user.userCreationTime.toDate(), 'MMM dd, yyyy')}'),
                subtitle: user.address != null?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user.address!.city),
                    Text(user.address!.area ?? 'UnKnown'),
                    Text(user.address!.streetAddress ?? 'UnKnown'),
                    Text(user.address!.zipCode ?? 'UnKnown'),
                  ],
                ):null,
              ),
            );
          },
        )
        ,),
    );
  }
}
