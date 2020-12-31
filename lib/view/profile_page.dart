import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/services/dbHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersInfoList extends StatefulWidget {
  @override
  _UsersInfoListState createState() => new _UsersInfoListState();
}

class _UsersInfoListState extends State<UsersInfoList> {
  DataBaseHelper dbHelper = new DataBaseHelper();
  List userData = new List();

  @override
  void initState() {
    fetchUserInfoList();
    super.initState();
  }

  fetchUserInfoList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int tuserid = await sharedPreferences.get('tuserid');
    userData = await DataBaseHelper().fetchUserDetail(tuserid.toString());

    setState(() {});
  }

  Widget userInfo(IconData iconname, String userdata) {
    return Padding(
        padding: const EdgeInsets.only(left: 13, top: 10, right: 7),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(iconname),
            SizedBox(width: 8),
            Expanded(child: new Text(userdata)),
          ],
        ));
  }

  validationForData(dynamic data) {
    if (data != null &&
        data.toString().trim().isNotEmpty &&
        data.toString() != "null" &&
        data.toString() != "NULL" &&
        data.toString().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget userDataCard(int index) {
    return new Container(
        margin: EdgeInsets.fromLTRB(8, 7, 8, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 3,
                spreadRadius: 0,
                color: Color(0X592c4154))
          ],
        ),
        child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          validationForData(userData[index]['firstname'])
              ? userInfo(Icons.person, userData[index]['firstname'].toString())
              : new Container(),

               validationForData(userData[index]['lastname'])
              ? userInfo(Icons.person, userData[index]['lastname'].toString())
              : new Container(),
          validationForData(userData[index]['email'])
              ? userInfo(Icons.email, userData[index]['email'].toString())
              : new Container(),
          validationForData(userData[index]['mobnum'].toString())
              ? userInfo(Icons.phone, userData[index]['mobnum'].toString())
              : new Container(),
          SizedBox(height: 10)
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: const Color(0xFFf3f3f3),
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: Colors.purple.shade500,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: new Text(
            "Client Screen",
            style: new TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        leading: new IconButton(
            tooltip: "Logout",
            icon: new Icon(Icons.exit_to_app),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login')),
      ),
      body: new Container(
        child: userData != null && userData.length > 0
            ? new ListView.builder(
                itemCount: userData.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return userDataCard(index);
                },
              )
            : new Container(
                child: Center(
                  child: Text(
                    'No Record Found',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
      ),
    );
  }
}
