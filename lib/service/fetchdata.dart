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

  
  Future updateRewards(String rewards) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String rewardsId = prefs.getString('rewards_id');
    String refferalCodeRefferer = prefs.getString('refferal_code_refferer');

    if(refferalCodeRefferer == '') {
      refferalCodeRefferer = 'norefferer';
    }

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/rewards/$rewardsId?token=$token";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {'rewards': rewards, 'refferal': refferalCodeRefferer,'_method': 'PATCH'});
    if (response.statusCode == 200) {
      print('rewards updated');
    }
    print(response.statusCode);
    print(response.body);
  }

  

  Future readRewards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rewardsId = prefs.getString('rewards_id');
    int currentCoin = prefs.getInt('coin');
    int fromRefferal = prefs.getInt('fromrefferal');

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/rewards/$rewardsId";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      String newRewardsFromRefferal = jsonData['rewards']['fromrefferal'];
      int newRewardFromRefferal = int.parse(newRewardsFromRefferal);
      if(newRewardFromRefferal > fromRefferal) {
      prefs.setInt('coin', currentCoin+=newRewardFromRefferal);
      prefs.setInt('fromrefferal', newRewardFromRefferal);


  print('object created');
      }
    }
    print(response.statusCode);
    print(response.body);
  }

  


  
 
  Future updatePayment(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

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
    print(response.statusCode);
    print(response.body);
  }
  Future readPayment() async {

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/payment";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"},);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['payment'] as List).map((payment) {
      print('Inserting $payment');
      DBHelperPayment.db.createPayment(Payment.fromJson(payment));
    }).toList();
    }
    print(response.statusCode);
    print(response.body);
  }


  Future readNotif() async {

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/notif";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"},);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['notif'] as List).map((notif) {
      print('Inserting $notif');
      DBHelperNotif.db.createNotif(Notif.fromJson(notif));
    }).toList();
    }
    print(response.statusCode);
    print(response.body);
  }

  Future readFeedback() async {

    String baseUrl =
        "https://duitrest.000webhostapp.com/api/v1/feedback";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"},);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['feedback'] as List).map((feedback) {
      print('Inserting $feedback');
      DBHelperFeedback.db.createFeedback(FeedbackModel.fromJson(feedback));
    }).toList();
    }
    print(response.statusCode);
    print(response.body);
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
    print(response.statusCode);
    print(response.body);
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
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    }
     else {
       return false;
     }
  
}

  

}
