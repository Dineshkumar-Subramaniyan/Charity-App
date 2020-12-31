import 'package:charity_app/mock/mock_data.dart';
import 'package:charity_app/services/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String admin = "ADMIN";
  String nonadmin = "CLIENT";
  bool pswdObscureFlag = true;
  bool isLoginPerform = false;

  GlobalKey<ScaffoldState> scaffoldkey =
      new GlobalKey<ScaffoldState>(debugLabel: "LoginPage");
  FocusNode userNameFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();
  SharedPreferences sharedPreferences;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwrdController = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    DataBaseHelper().db;
    MockData().createUserData();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwrdController.dispose();
    super.dispose();
  }

  TextStyle labelFieldStyle =
      TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600);

  TextStyle fieldStyle = new TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);

  loginAction() async {
    if (usernameController.text.isNotEmpty &&
        passwrdController.text.isNotEmpty) {
      isLoginPerform = false;

      await DataBaseHelper()
          .fetchUserData(
              loginid: usernameController.text.trim(),
              pswd: passwrdController.text.trim())
          .then((value) async {
            
        sharedPreferences = await SharedPreferences.getInstance();
        if (value != null && value.isNotEmpty) {
          if (value[0]['userrole'] != null && value[0]['userrole'].isNotEmpty) {
            sharedPreferences.setInt('tuserid', value[0]['tuserid']);
            if (value[0]['userrole'].toString().toUpperCase() == admin) {
              Navigator.pushNamed(context, '/listpage');
            } else if (value[0]['userrole'].toString().toUpperCase() ==
                nonadmin) {
              Navigator.pushNamed(context, '/userInfo');
            }
          } else {
            scaffoldKey.currentState
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: new Text('User has no role access')));
          }
        } else {
          scaffoldKey.currentState
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: new Text('Invalid user credential')));
        }
      });
    } else {
      isLoginPerform = false;

      scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: new Text('Please enter the credential')));
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.purple.shade500,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: maxHeight * 0.15),
                  new Container(
                    child: FlutterLogo(
                      size: 100,
                    ),
                    alignment: Alignment.center,
                  ),
                  new SizedBox(height: maxHeight * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: new TextFormField(
                      controller: usernameController,
                      style: fieldStyle,
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 1.5),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: "Username",
                          labelStyle: labelFieldStyle),
                      focusNode: userNameFocus,
                      onFieldSubmitted: (String focusName) {
                        userNameFocus.unfocus();
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                    ),
                  ),
                  new SizedBox(height: maxHeight * 0.025),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: new TextFormField(
                      controller: passwrdController,
                      obscureText: pswdObscureFlag,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 1.5),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: labelFieldStyle,
                          labelText: "Password",
                          suffixIcon: new IconButton(
                            icon: Icon(pswdObscureFlag
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              pswdObscureFlag = !pswdObscureFlag;
                              if (mounted) setState(() {});
                            },
                          )),
                      style: fieldStyle,
                      focusNode: passwordFocus,
                      onFieldSubmitted: (String passFocus) {
                        passwordFocus.unfocus();
                        isLoginPerform = true;
                        if (mounted) setState(() {});
                        loginAction();
                      },
                    ),
                  ),
                  SizedBox(height: maxHeight * 0.08),
                  InkWell(
                    onTap: () {
                      isLoginPerform = true;
                      if (mounted) setState(() {});
                      loginAction();
                    },
                    child: new Container(
                      width: maxWidth * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.orange[300],
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: new Text(
                        'LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          isLoginPerform
              ? new Center(child: new CircularProgressIndicator())
              : new Container()
        ],
      ),
    );
  }
}
