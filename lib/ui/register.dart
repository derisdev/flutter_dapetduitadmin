import 'dart:convert';
import 'package:dapetduit_admin/service/fetchdata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dapetduit_admin/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController refferalController = TextEditingController();


  FetchData fetchData = new FetchData();


@override
void dispose() { 
  usernameController.dispose();
  refferalController.dispose();
  super.dispose();
}


  Future saveUser() async {
    setState(() {
      _isLoading = true;
    });

    String refferalOwner = randomAlphaNumeric(6);

    String baseUrl = "https://duitrest.000webhostapp.com/api/v1/user/register";
    var response = await http.post(baseUrl, headers: {
      "Accept": "application/json"
    }, body: {
      'name': '${usernameController.text}',
      'refferal': '${refferalController.text}',
      'email': refferalOwner,
      'password': refferalOwner,
    });
    if (response.statusCode == 201) {
      print('refferal controller ${refferalController.text}');
      final jsonData = json.decode(response.body);
      String token = jsonData['token'];
      String name = jsonData['user']['name'];
      int userId = jsonData['user']['id'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setBool('login', true);
      prefs.setString('name', name);
      prefs.setInt('user_id', userId);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (response.statusCode == 500) {
      showToast('Username sudah ada yang menggunakan');
    } else if (response.statusCode == 504) {
      showToast('Server sedang ada gangguan. Coba lagi nanti');
    } else if (response.statusCode == 404) {
      showToast('kode Refferal tidak valid');
    } else {
      showToast('Gagal terhubung ke server');
    }
    setState(() {
      print(response.statusCode);
      print(response.body);
      _isLoading = false;
    });
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 14.0,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 250.0,
                color: Color(0xff24bd64),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        color: Colors.yellow,
                        size: 50.0,
                      ),
                      Text(
                        'Dapet Duit Admin',
                        style: TextStyle(color: Colors.white, fontSize: 50.0), textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Nama harus diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(12.0),
                              icon: Icon(Icons.person),
                              labelText: 'Nama Pengguna',
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.yellow))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: TextField(
                          onChanged: (String value) {
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                          controller: refferalController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(12.0),
                              icon: Icon(Icons.card_giftcard),
                              labelText: 'Kode Refferal (Opsional)',
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.yellow))),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      _isLoading
                          ? SpinKitThreeBounce(
                              color: Color(0xff24bd64),
                              size: 50.0,
                            )
                          : Container(
                              height: 50,
                              child: RaisedButton(
                                  focusColor: Colors.grey,
                                  splashColor: Colors.grey,
                                  color: Color(0xff24bd64),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text('Mulai'),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      saveUser();
                                    }
                                  }),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
