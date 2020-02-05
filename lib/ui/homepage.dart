import 'package:dapetduit_admin/helper/dbhelperPayment.dart';
import 'package:dapetduit_admin/service/fetchdata.dart';
import 'package:dapetduit_admin/ui/akuisisi.dart';
import 'package:dapetduit_admin/ui/detailpayment.dart';
import 'package:dapetduit_admin/ui/widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  bool isLoadingUpdate = false;

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    FetchData fetchData = FetchData();
    await fetchData.readPayment();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  updatePayment(int id) async {
    setState(() {
      isLoadingUpdate = true;
    });
    FetchData fetchData = FetchData();
    await fetchData.updatePayment(id).then((msg) {
      if (msg) {
        _loadFromApi();
        showDialog(
            context: context, builder: (context) => _onPaymentSuccess(context));
      }
    });
    setState(() {
      isLoadingUpdate = false;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await _loadFromApi();
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
          title: Text('Admin'),
          actions: <Widget>[
            Icon(Icons.person),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Aquisition()));
                },
              ),
            )
          ],
        ),
        drawer: DrawerHome(),
        body: isLoadingUpdate
            ? SpinKitThreeBounce(size: 40.0, color: Color(0xff24bd64))
            : isLoading
                ? SpinKitThreeBounce(
                    size: 40.0,
                    color: Color(0xff24bd64),
                  )
                : FutureBuilder(
                    future: DBHelperPayment.db.getAllPayment(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SmartRefresher(
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
                                body = Text("Tarik kebawah untuk memperbarui");
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
                          child: Center(
                            child: Text(
                              'Belum ada history.\nTarik kebawah untuk memperbarui',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        return SmartRefresher(
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
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                String icon;
                                if (snapshot.data[index]['via'] == 'DANA') {
                                  icon = 'dana';
                                } else if (snapshot.data[index]['via'] == 'OVO') {
                                  icon = 'ovo';
                                } else {
                                  icon = 'gopay';
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Card(
                                    elevation: 3,
                                    child: ListTile(
                                      leading: ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(8.0),
                                          child: Image.asset(
                                              'images/icon/$icon.jpeg')),
                                      title: InkWell(
                                        onLongPress: () {
                                          Clipboard.setData(ClipboardData(
                                              text:
                                                  '${snapshot.data[index].phone}'));
                                          Scaffold.of(context).showSnackBar(
                                            const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'Nomor Telpon disalin')),
                                          );
                                        },
                                        child: Text(
                                          '${snapshot.data[index].phone}',
                                          style: TextStyle(),
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${snapshot.data[index].amount}, ${snapshot.data[index].via}',
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index].status,
                                            style: TextStyle(
                                                color: snapshot.data[index]
                                                            .status ==
                                                        'Berhasil'
                                                    ? Colors.amber
                                                    : Colors.red),
                                          ),
                                          snapshot.data[index].status ==
                                                  'Berhasil'
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.green,
                                                  ),
                                                )
                                              : Container(
                                                  child: IconButton(
                                                    icon: Icon(Icons.update,
                                                        color: Colors.green),
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              _onCHangeStatus(
                                                                  context,
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .id));
                                                    },
                                                  ),
                                                )
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentDetail(
                                                        data: snapshot
                                                            .data[index])));
                                      },
                                    ),
                                  ),
                                );
                              },
                            ));
                      }
                    },
                  ));
  }

  _onCHangeStatus(BuildContext context, int id) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width - 30,
          height: MediaQuery.of(context).size.height * 1 / 2,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                      height: 140,
                      width: 140,
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.announcement,
                          size: 70,
                        ),
                        onPressed: () {},
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Yakin?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Dengan ini pembayaran dianggap selesai',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Lanjut',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      updatePayment(id);
                    },
                  )
                ],
              ))),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 20,
            margin: EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              child: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      )
    ]);
  }

  _onPaymentSuccess(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width - 30,
          height: MediaQuery.of(context).size.height * 1 / 2,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                      height: 140,
                      width: 140,
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.check,
                          size: 70,
                        ),
                        onPressed: () {},
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Berhasil',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Status pembayaran telah di update',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ))),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 20,
            margin: EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              child: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      )
    ]);
  }
}
