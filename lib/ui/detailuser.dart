import 'package:dapetduit_admin/ui/historypayments.dart';
import 'package:dapetduit_admin/ui/historyrewards.dart';
import 'package:dapetduit_admin/ui/giftkoin.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  final dynamic data;
  UserDetail({Key key, @required this.data}) : super(key : key);
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                title: Text(data['name']),
                subtitle: Text('bergabung pada: ${data['created_at']}'),
              ),
              ListTile(
                title: Text('Total Koin'),
                trailing: Text(data['rewards']['rewards'] == null? '0' : data['rewards']['rewards']),
              ),
              ListTile(
                title: Text('Total Koin dari refferal'),
                trailing: Text(data['rewards']['fromrefferal'] == null? '0' : data['rewards']['fromrefferal']),
              ),
              ListTile(
                title: Text('Total Koin dari misi lainnya'),
                trailing: Text(data['rewards']['fromanother'] == null? '0' : data['rewards']['fromanother']),
              ),
              ListTile(
                title: Text('Kode Refferal'),
                trailing: Text(data['refferal']['refferal'] == null? 'Tidak ada data' : data['refferal']['refferal']),
              ),
              ListTile(
                title: Text('Total Invite'),
                trailing: Text(data['refferal']['invited'] == null? '0' : data['refferal']['invited']),
              ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                title: Text('History Rewards'),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HistoryRewards(id: data['id'],)
                  ));
                }
              ),
              Divider(),
              ListTile(
                title: Text('History Payment'),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HistoryPayments(phone: data['phone']['phone'] == null? 'nophone' : data['phone']['phone'],)
                  ));
                }
                ),
              Divider(),
              ListTile(
                title: Text('Tambahkan Koin'),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GiftCoin(id: data['id'],)
                  ));
                }
                ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}