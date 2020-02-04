import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
              ListTile(
                title: Text('Name'),
                subtitle: Text('bergabung pada: 21 Oktober 2020'),
              ),
              
              SizedBox(height: 20,),
              ListTile(
                title: Text('Total Koin'),
                trailing: Text('5600'),
              ),
              SizedBox(height: 20,),
              ListTile(
                title: Text('Kode Refferal'),
                trailing: Text('ZER321'),
              ),
              SizedBox(height: 20,),
              ListTile(
                title: Text('Total Invite'),
                trailing: Text('21'),
              ),
              Divider(),
              ListTile(
                title: Text('History Rewards'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(),
              ListTile(
                title: Text('History Payment'),
                trailing: Icon(Icons.chevron_right),
                ),
              Divider(),
              ListTile(
                title: Text('Tambahkan Koin'),
                trailing: Icon(Icons.chevron_right),
                ),
          ],
        ),
      ),
    );
  }
}