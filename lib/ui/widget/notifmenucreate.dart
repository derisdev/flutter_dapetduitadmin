import 'package:dapetduit_admin/service/fetchdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotifMenuCreate extends StatefulWidget {
  @override
  NotifMenuCreateState createState() => NotifMenuCreateState();
}

class NotifMenuCreateState extends State<NotifMenuCreate> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();



  Future saveNotif(String title, String des) async {

    setState(() {
     _isLoading = true; 
    });

    FetchData fetchData = FetchData();
    await fetchData.createNotif(title, des).then((result){
      if(result) {
        Fluttertoast.showToast(
          msg: 'Data ditambahan',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG
        );
      }
      else {
        Fluttertoast.showToast(
          msg: 'Gagal menambahkan data',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG
        );
      }
    });


    setState(() {
     _isLoading = false; 
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/background.jpeg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height * 7 / 8 + 1,
              padding: EdgeInsets.only(top: 30),
              decoration: new BoxDecoration(
                  color: Color(0xffefeff4),
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: TextFormField(
                          style: TextStyle(color: Colors.black, height: 2),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: titleController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Title harus diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.question_answer),
                              labelText: 'Title',
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber))),
                        ),
                      ),
                      SingleChildScrollView(
                        child: TextFormField(
                          style: TextStyle(color: Colors.black, height: 2),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: desController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Deskripsi harus diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.question_answer),
                              labelText: 'Deskripsi',
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber))),
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
                                  child: Text('Simpan'),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      saveNotif(titleController.text, desController.text);
                                    }
                                  }),
                            ),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
