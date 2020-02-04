import 'package:dapetduit_admin/ui/listuser.dart';
import 'package:flutter/material.dart';

class Aquisition extends StatefulWidget {
  @override
  AquisitionState createState() => AquisitionState();
}

class AquisitionState extends State<Aquisition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akuisisi Pengguna'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Hari ini'),
            subtitle: Text('500'),
          ),
          Divider(),
          ListTile(
            title: Text('Total Keseluruhan'),
            subtitle: Text('50.000'),
          ),
          Divider(),
          ListTile(
            title: Text('Daftar Pengguna'),
            trailing: Icon(Icons.chevron_right
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ListUser()
              ));
            },
          )
        ],
      ),
    );
  }
}