import 'package:dapetduit_admin/ui/detailuser.dart';
import 'package:flutter/material.dart';

class ListUser extends StatefulWidget {
  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar User'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return ListTile(
            title: Text('Name'),
            subtitle: Text('8285719632945'),
            trailing: Text('3000 koin'),
             onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => UserDetail()
              ));
            },
          );
        },
      ),
    );
  }
}