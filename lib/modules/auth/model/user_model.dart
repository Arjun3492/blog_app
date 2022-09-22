import 'dart:convert';

class UserModel {
  String? username;
  String? email;
  String? uid;
  UserModel({
    this.username,
    this.email,
    this.uid,
  });

//maps the object to a json/map
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (username != null) {
      result.addAll({'username': username});
    }
    if (email != null) {
      result.addAll({'email': email});
    }

    if (uid != null) {
      result.addAll({'uid': uid});
    }

    return result;
  }

// creates an object from a json/map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
