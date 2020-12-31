class UserModel {
  String fName;
  String lName;
  String email;
  int mobile;
  String userrole;
  String userid;
  String password;

  UserModel({this.fName, this.lName, this.email,this.mobile,this.userrole,this.userid,this.password});

  Map<String, dynamic> toMap() {
    var mapData = new Map<String, dynamic>();
    mapData['firstname'] = fName;
    mapData['lastname'] = lName;
    mapData['email'] = email;
    mapData['mobnum'] = mobile;
    mapData['userrole'] = userrole;
    mapData['userid'] = userid;
    mapData['password'] = password;
    return mapData;
  }
}
