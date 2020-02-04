import 'package:dapetduit_admin/ui/widget/feedbackmenu.dart';
import 'package:dapetduit_admin/ui/widget/notifmenu.dart';
import 'package:flutter/material.dart';

class DrawerHome extends StatefulWidget {
  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  @override
  Widget build(BuildContext context) {
    return  Container(
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white
            ),
            child: Drawer(
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                      color: Colors.green,
                      child: Icon(Icons.drafts, color: Colors.white, size: 70,),
                    )
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.black),
                    title: Text('Notif', style: TextStyle(color: Colors.black),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NotifMenu()
                    ));
                    },
                  ),
                  Divider(color: Colors.grey.withOpacity(0.2)),
                  ListTile(
                    leading: Icon(Icons.repeat, color: Colors.black),
                    title: Text('Feedback', style: TextStyle(color: Colors.black),),
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FeedbackMenu()
                    ));
                    },
                  ),
                  Divider(color: Colors.grey.withOpacity(0.2)),
                  
                ],
              ),
            ),
          ),
        );
  }
  
}
