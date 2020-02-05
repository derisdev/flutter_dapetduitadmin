import 'package:dapetduit_admin/ui/detailuser.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final List<dynamic> data;
  Search({Key key, @required this.data}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController editingController = TextEditingController();
  
  List<dynamic> data = List<dynamic>();


  @override
  void initState() { 
    super.initState();
    this.data.clear();
  }

  void filterSearchResult(String query) async {
    query = query.toLowerCase();

    if (query.isNotEmpty) {
      List<dynamic> listData = List<dynamic>();

      widget.data.forEach((item) {
        if(item['phone']['phone']==null){item['phone']['phone'] = 'belum diverifikasi';}
        if (item['name'].toLowerCase().contains(query) ||
            item['phone']['phone'].toLowerCase().contains(query)) {
          listData.add(item);
        }
      });
        setState(() {
          data.clear();
          data.addAll(listData);
        });
      return;
    } else {
        setState(() {
          data.clear();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
                width: 280,
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.greenAccent,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  controller: editingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.7)))),
                  onChanged: (value) {
                    filterSearchResult(value);
                  },
                ),
              ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index){
      return ListTile(
        title: Text(data[index]['name']),
        subtitle: Text(data[index]['phone']['phone'] == null? 'Belum diverifikasi' : data[index]['phone']['phone']),
        trailing: Text(data[index]['rewards']['rewards']==null? 'Belum ada Rewards' : data[index]['rewards']['rewards']),
         onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => UserDetail(data: data[index],)
          ));
        },
      );
    },
      ),
    );
  }
}
