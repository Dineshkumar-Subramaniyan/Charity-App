import 'package:charity_app/services/dbHelper.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => new _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  DataBaseHelper dataBaseHelper = new DataBaseHelper();
  List userList = new List();

  showDialogWidget(Map userDataMap, BuildContext _context) {
    String fName =
        userDataMap['firstname'] != null && userDataMap['firstname'].isNotEmpty
            ? userDataMap['firstname'].toString()
            : "";
    String lName =
        userDataMap['lastname'] != null && userDataMap['lastname'].isNotEmpty
            ? userDataMap['lastname'].toString()
            : "";
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Center(
              child: new Text(
                "UserName",
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            content: userDataMap['firstname'] != null &&
                    userDataMap['firstname'].isNotEmpty
                ? new Text(fName.toString() + " " + lName.toString())
                : new Container(),
            actions: <Widget>[
              new Center(
                child: FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  Widget userField(String fieldname, fieldval) {
    return new Row(
      children: [
        SizedBox(
          width: 100,
          child: new Text(
            fieldname,
            style: TextStyle(
              color: Colors.purple,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        new Text(
          fieldval,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget userDataWidget(String index, BuildContext ctxt) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              userField('First Name : ', 'firstname_$index'),
              SizedBox(height: 5),
              userField('Last Name : ', 'lastname_$index'),
              SizedBox(height: 5),
              userField('Email : ', 'User_$index@charity.com'),
              SizedBox(height: 5),
              userField('Mobile : ', '951541446$index')
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.purple.shade500,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: new Text(
            "Admin Screen",
            style: new TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        leading: new IconButton(
            tooltip: "Logout",
            icon: new Icon(Icons.exit_to_app),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login')),
      ),
      body: new Container(
        child: new ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext ctxt, int index) {
              return userDataWidget(index.toString(), context);
            }),
      ),
    );
  }
}
