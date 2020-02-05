import 'package:dapetduit_admin/ui/detailhistorypayment.dart';
import 'package:flutter/services.dart';
import 'package:dapetduit_admin/service/fetchdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HistoryPayments extends StatefulWidget {
  final String phone;
  HistoryPayments({Key key, @required this.phone}) : super(key:key);
  @override
  _HistoryPaymentsState createState() => _HistoryPaymentsState();
}

class _HistoryPaymentsState extends State<HistoryPayments> {
  


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

    await fetchData.getHistoryPayment(widget.phone).then((data){
      if(data!=null) {
        if(mounted){
          setState(() {
           this.data = data; 
          });
        }
      }
      else {
        if(mounted) {
          setState(() {
         this.data = []; 
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
        title: Text('History Payment'),
      ),
      body: isLoading? 
      SpinKitThreeBounce(
        size: 30,
        color: Colors.green,
      )
      : widget.phone == 'nophone'? Center(
        child: Text('User Belum verifikasi nomor'))   
        :
        data['user'].isEmpty? Center(
        child: Text('Belum ada data')) 
        : ListView.builder(
                              itemCount: data['user'].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Card(
                                    elevation: 3,
                                    child: ListTile(
                                      leading: Container(
                                        decoration: BoxDecoration(
                                        color: Colors.amber,
                                          borderRadius: BorderRadius.circular(40)
                                        ),
                                        width: 50,
                                        height: 50,
                                        child: Center(child: Text('6', style: TextStyle(color: Colors.white),)),
                                      ),
                                      title: InkWell(
                                        onLongPress: () {
                                          Clipboard.setData(ClipboardData(
                                              text:
                                                  '${data['user'][index]['phone']}'));
                                          Scaffold.of(context).showSnackBar(
                                            const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'Nomor Telpon disalin')),
                                          );
                                        },
                                        child: Text(
                                            '${data['user'][index]['phone']}', style: TextStyle(),),
                                      ),
                                      subtitle: Text(
                                        '${data['user'][index]['amount']}, ${data['user'][index]['via']}',
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            data['user'][index]['status'],
                                            style:
                                                TextStyle(color: data['user'][index]['status'] == 'Berhasil'? Colors.amber: Colors.red),
                                          ),
                                          data['user'][index]['status'] == 'Berhasil'? 
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Icon(Icons.check, color: Colors.green,),
                                          )
                                          : Container(
                                            child: IconButton(
                                              icon: Icon(Icons.update,
                                                  color: Colors.green),
                                              onPressed: () {
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => HistoryPaymentDetail(data: data['user'][index])
                                        ));
                                      },
                                    ),
                                  ),
                                );
                              },
                            )
    );
  }
  
}