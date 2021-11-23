import 'package:cloud_firestore/cloud_firestore.dart';

class WeCareUser {
  String? uid;
  String? avatarUrl;
  String? name;
  int? age;
  DateTime? birthDay;
  bool? gender;
  double? height;
  double? weight;
  String? email;

  WeCareUser({
    this.uid,
    this.name,
    this.age,
    this.birthDay,
    this.gender,
    this.height,
    this.weight,
    this.email,
    this.avatarUrl,
  });

  //data from server
  factory WeCareUser.fromMap(map) {
    Timestamp timestamp = map['birthDay'];
    DateTime dateTime = timestamp.toDate();
    return WeCareUser(
      uid: map['uid'],
      name: map['name'],
      age: map['age'],
      birthDay: dateTime,
      gender: map['gender'],
      height: map['height'],
      weight: map['weight'],
      email: map['email'],
      avatarUrl: map['avatarUrl'],
    );
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "age": age,
      "birthDay": birthDay,
      "gender": gender,
      "height": height,
      "weight": weight,
      "email": email,
      "avatarUrl": avatarUrl,
    };
  }
}
