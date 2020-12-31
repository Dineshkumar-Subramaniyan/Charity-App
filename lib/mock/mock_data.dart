import 'package:charity_app/model/usermodel.dart';
import 'package:charity_app/services/dbHelper.dart';

class MockData {
  DataBaseHelper dataBaseHelper = new DataBaseHelper();
  createUserData() async {
    await dataBaseHelper.insert(UserModel(
            fName: "Michael",
            lName: "Lawson",
            email: "michaellawson@charity.com",
            mobile: 9655524315,
            password: "lawson",
            userid: "mlawson",
            userrole: "CLIENT")
        .toMap());
    await dataBaseHelper.insert(UserModel(
            fName: "Administrator",
            email: "admin@charity.com",
            mobile: 9051545415,
            password: "password",
            userid: "admin",
            userrole: "ADMIN")
        .toMap());

    return null;
  }
}
