import 'package:dapetduit_admin/service/fetchdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HistoryRewards extends StatefulWidget {
  final int id;
  HistoryRewards({Key key, @required this.id}) : super(key:key);
  @override
  _HistoryRewardsState createState() => _HistoryRewardsState();
}

class _HistoryRewardsState extends State<HistoryRewards> {
  


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

    await fetchData.getHistoryRewards(widget.id).then((data){
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
        title: Text('History Rewards'),
      ),
      body: isLoading? 
      SpinKitThreeBounce(
        size: 30,
        color: Colors.green,
      )
      : data['user'].isEmpty? Center(
        child: Text('Belum ada data'),
      ) : ListView.builder(
        itemCount: data['user'].length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(data['user'][index]['from']),
            subtitle: Text(data['user'][index]['created_at']),
            trailing: Text('+${data['user'][index]['rewards']}', style: TextStyle(color: Colors.amber, fontSize: 20),),
          );
        },
      ),
    );
  }
}