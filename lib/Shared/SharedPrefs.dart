import 'package:shared_preferences/shared_preferences.dart';

setLogin(String login) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('login', login);
}

removeLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('login');
}

setName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', name);
}

removeName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('name');
}

setAddress(String address) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('address', address);
}

removeAddress() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('address');
}

setPhone(String phone) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('phone', phone);
}

removePhone() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('phone');
}

setEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
}

removeEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('email');
}

setFb(String fb) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('fb', fb);
}

removeFb() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('fb');
}

setJwt(String jwt) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('jwt', jwt);
}

removeJwt() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('jwt');
}

void setCurrency(String code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('currency', code);
}

void setCountry(String code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('country', code);
}

void setGender(String gender) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('gender', gender);
}

removeGender() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('gender');
}
