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
  DateTime? sleepTime;
  DateTime? wakeupTime;

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
    this.sleepTime,
    this.wakeupTime,
  });

  static double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  //data from server
  factory WeCareUser.fromMap(map) {
    Timestamp timestamp = map['birthDay'];
    DateTime? birthDay = timestamp.toDate();

    Timestamp sleepTimestamp = map['sleepTime'];
    DateTime sleepDateTime = sleepTimestamp.toDate();

    Timestamp wakeupTimestamp = map['wakeupTime'];
    DateTime? wakeupDateTime = wakeupTimestamp.toDate();

    return WeCareUser(
      uid: map['uid'],
      name: map['name'],
      age: map['age'],
      birthDay: birthDay,
      gender: map['gender'],
      height: checkDouble(map['height']),
      weight: checkDouble(map['weight']),
      email: map['email'],
      avatarUrl: map['avatarUrl'],
      sleepTime: sleepDateTime,
      wakeupTime: wakeupDateTime,
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
      "sleepTime": sleepTime,
      "wakeupTime": wakeupTime,
    };
  }
}
