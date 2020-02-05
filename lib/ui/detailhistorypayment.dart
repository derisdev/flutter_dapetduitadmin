import 'package:flutter/material.dart';

class HistoryPaymentDetail extends StatefulWidget {
  final data;
  HistoryPaymentDetail({Key key, @required this.data}) : super(key : key);
  @override
  _HistoryPaymentDetailState createState() => _HistoryPaymentDetailState();
}

class _HistoryPaymentDetailState extends State<HistoryPaymentDetail> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                    height: 45,
                  ),
                  Container(
                    height: 140,
                    width: 140,
                    child: FloatingActionButton(
                      backgroundColor: Colors.amber,
                      elevation: 0.0,
                      child: Icon(Icons.payment, size: 70,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Payment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 25),
                      alignment: Alignment.centerLeft,
                      child: Text('Payment Detail',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 1,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    ),
                    child: Slider(
                      activeColor: Colors.amber,
                      inactiveColor: Colors.grey,
                      value: 37,
                      min: 0,
                      max: 100,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 58),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Nomor Telpon',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(data['phone'], style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Tanggal Withdraw',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(data['time'], style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 130),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Via',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(data['via'], style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 102),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Jumlah',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(data['amount'], style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 108),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Status',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(data['status'], style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}