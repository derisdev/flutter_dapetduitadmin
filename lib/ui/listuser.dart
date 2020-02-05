import 'package:dapetduit_admin/service/fetchdata.dart';
import 'package:dapetduit_admin/ui/detailuser.dart';
import 'package:dapetduit_admin/ui/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListUser extends StatefulWidget {
  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  


  bool isLoading = false;
  FetchData fetchData = FetchData();
  dynamic data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    setState(() {
     isLoading = true; 
    });

    await fetchData.readUser().then((data){
      if(data!=null) {
        if(mounted){
          setState(() {
           this.data = data; 
          });
        }
      }
    });

      setState(() {
     isLoading = false; 
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar User'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Search(data: data['user'])
              ));
            },
          )
        ],
      ),
      body: isLoading? 
      SpinKitThreeBounce(
        size: 30,
        color: Colors.green,
      )
      : ListView.builder(
        itemCount: data['user'].length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(data['user'][index]['name']),
            subtitle: Text(data['user'][index]['phone']['phone'] == null? 'Belum diverifikasi' : data['user'][index]['phone']['phone']),
            trailing: Text(data['user'][index]['rewards']['rewards']==null? 'Belum ada Rewards' : data['user'][index]['rewards']['rewards']),
             onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => UserDetail(data: data['user'][index],)
              ));
            },
          );
        },
      ),
    );
  }
}