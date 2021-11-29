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

  static double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  //data from server
  WeCareUser.fromMap(map) {
    Timestamp timestamp = map['birthDay'];
    DateTime dateTime = timestamp.toDate();

    uid = map['uid'];
    name = map['name'];
    age = map['age'];
    birthDay = dateTime;
    gender = map['gender'];
    height = checkDouble(map['height']);
    weight = checkDouble(map['weight']);
    email = map['email'];
    avatarUrl = map['avatarUrl'];
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
