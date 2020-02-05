import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dapetduit_admin/service/fetchdata.dart';
import 'package:dapetduit_admin/ui/listuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Aquisition extends StatefulWidget {
  @override
  AquisitionState createState() => AquisitionState();
}

class AquisitionState extends State<Aquisition> {

  bool isLoading = false;
  FetchData fetchData = FetchData();
  String total;

  @override
  void initState() {
    super.initState();
    getCurrentTotal();
  }

  Future getCurrentTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String total = prefs.getString('totaluser');
    if(total != null) {
      setState(() {
     this.total = total; 
    });
    }
    else {
      setState(() {
       this.total = '0'; 
      });
    }
  }

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     isLoading = true; 
    });

    await fetchData.getTotal().then((total){
      if(total!=null) {
        if(mounted) {
          setState(() {
         this.total = total; 
        });
        }
    prefs.setString('totaluser', total);        
      }
    });

      setState(() {
     isLoading = false; 
    });

  }
  
    RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await getData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akuisisi Pengguna'),
      ),
      body: isLoading? SpinKitThreeBounce(
        size: 40,
        color: Colors.green
      ) : SmartRefresher(
         enablePullDown: true,
                            enablePullUp: false,
                            header: WaterDropMaterialHeader(),
                            footer: CustomFooter(
                              builder: (BuildContext context, LoadStatus mode) {
                                Widget body;
                                if (mode == LoadStatus.idle) {
                                  body = Text("Sudah mencapai batas");
                                } else if (mode == LoadStatus.loading) {
                                  body = CupertinoActivityIndicator();
                                } else if (mode == LoadStatus.failed) {
                                  body = Text("Gagal Memuat");
                                } else if (mode == LoadStatus.canLoading) {
                                  body =
                                      Text("Tarik kebawah untuk memperbarui");
                                } else {
                                  body = Text("Tidak ada data lagi");
                                }
                                return Container(
                                  height: 55.0,
                                  child: Center(child: body),
                                );
                              },
                            ),
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            onLoading: _onLoading,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Hari ini'),
              subtitle: Text('500'),
            ),
            Divider(),
            ListTile(
              title: Text('Total Keseluruhan'),
              subtitle: Text(total==null? 'loading' : total),
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
      ),
    );
  }
}