import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserData {
  String name;
  String id;
  String photoUrl;
  String email;
  GeoPoint location;
  String phoneNumber;

  String get getName => name;

  set setName(String name) => this.name = name;

  String get getId => id;

  set setId(String id) => this.id = id;

  String get getPhotoUrl => photoUrl;

  set setPhotoUrl(String photoUrl) => this.photoUrl = photoUrl;

  String get getEmail => email;

  set setEmail(String email) => this.email = email;

  GeoPoint get getLocation => location;

  set setLocation(GeoPoint location) => this.location = location;

  String get getPhoneNumber => phoneNumber;

  set setPhoneNumber(String phoneNumber) => this.phoneNumber = phoneNumber;

  UserData(
      {this.id,
      this.name,
      this.photoUrl,
      this.email,
      this.location,
      this.phoneNumber});

      @override
  String toString() {
    // TODO: implement toString
    return 'id:$id \n name:$name \n photo:$photoUrl \n email:$email \n location:$location \n phone:$phoneNumber';
  }
}

class User with ChangeNotifier {
  UserData _userData = UserData();

  

  String get getName => _userData.name;
  String get getId => _userData.id;
  String get getPhotoUrl => _userData.photoUrl;
  String get getEmail => _userData.email;
  GeoPoint get getLocation => _userData.location;
  String get getPhoneNumber => _userData.phoneNumber;
  UserData get getUserData => _userData;
  

  void setUser(UserData userData){
    _userData = userData;
    notifyListeners();
  }

  void setId(String id) {
    _userData.setId = id;
    notifyListeners();
  }

  void setName(String name) {
    _userData.setName = name;
    notifyListeners();
  }

  void setPhotoUrl(String photoUrl) {
    _userData.photoUrl = photoUrl;
    notifyListeners();
  }

  void setEmail(String email) {
    _userData.setEmail = email;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _userData.setPhoneNumber = phoneNumber;
    notifyListeners();
  }

  void setLocation(GeoPoint location) {
    _userData.setLocation = location;
    notifyListeners();
  }
}
