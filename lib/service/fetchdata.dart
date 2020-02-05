import 'dart:convert';
import 'package:dapetduit_admin/helper/dbhelperFeedback.dart';
import 'package:dapetduit_admin/helper/dbhelperNotif.dart';
import 'package:dapetduit_admin/helper/dbhelperPayment.dart';
import 'package:dapetduit_admin/model/feedbackModel.dart';
import 'package:dapetduit_admin/model/notifModel.dart';
import 'package:dapetduit_admin/model/paymentModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchData {

  
  Future updatePayment(int id) async {

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/payment/$id";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {"_method" : "PATCH", "status" : "Berhasil"});
    if (response.statusCode == 200) {
      return true;
    }
    else {
      Fluttertoast.showToast(
        msg: 'Terjadi kesalahan. Gagal melakukan perubahan',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
  Future readPayment() async {

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/payment";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"},);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['payment'] as List).map((payment) {
      DBHelperPayment.db.createPayment(Payment.fromJson(payment));
    }).toList();
    }
  }


  Future readNotif() async {

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/notif";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"},);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['notif'] as List).map((notif) {
      DBHelperNotif.db.createNotif(Notif.fromJson(notif));
    }).toList();
    }
  }

  Future readFeedback() async {

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/feedback";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"},);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['feedback'] as List).map((feedback) {
      DBHelperFeedback.db.createFeedback(FeedbackModel.fromJson(feedback));
    }).toList();
    }
  }

Future createFeedback(String question, String answer) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  
    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/feedback?token=$token";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {"question" : question, "answer" : answer}
        );
    if (response.statusCode == 201) {
      return true;
    }
     else {
       return false;
     }
  
}

Future createNotif(String title, String des) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  DateTime now = DateTime.now();
  String formattedDate = DateFormat('EEE, d MMM yyyy').format(now);
  
    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/notif?token=$token";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {"title" : title, "description" : des, "time" : formattedDate}
        );
    if (response.statusCode == 201) {
      return true;
    }
     else {
       return false;
     }
  
}

Future readUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
   String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/user/index?token=$token";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"}
        );
    if (response.statusCode == 200) {

      var data = json.decode(response.body);
      return data;
    }
     else {
       Fluttertoast.showToast(
         msg: 'gagal mengambil data',
         gravity: ToastGravity.BOTTOM
       );
     }
     return null;

}


Future getHistoryRewards(int userId) async {

  String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/user/historyRewards/$userId";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"}
        );
    if (response.statusCode == 200) {

      var data = json.decode(response.body);
      return data;
    }
     else {
       Fluttertoast.showToast(
         msg: 'gagal mengambil data',
         gravity: ToastGravity.BOTTOM
       );
       return null;
     }

}


Future getHistoryPayment(String phone) async {

  String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/user/historyPayment/$phone";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"}
        );
    if (response.statusCode == 200) {

      var data = json.decode(response.body);
      return data;
    }
     else {
       Fluttertoast.showToast(
         msg: 'gagal mengambil data',
         gravity: ToastGravity.BOTTOM

       );
     }
     return null;

}



Future getTotal() async {

  String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/user/total";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"}
        );
    if (response.statusCode == 200) {

      var data = json.decode(response.body);
      String total = data['usertotal']['total'];
      return total;
    }
     else {
       Fluttertoast.showToast(
         msg: 'gagal mengambil data',
         gravity: ToastGravity.BOTTOM

       );
     }
     return null;

}


Future addCoin(String coin, int id) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  
    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/user/giftCoin/$id/$coin?token=$token";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        );
    if (response.statusCode == 200) {
      return true;
    }
     else {
       return false;
     }
  
}




  

}
