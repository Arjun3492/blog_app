import 'dart:convert';

class PostModel {
  String? title;
  String? desc;
  String? id;
  String? createdBy;
  PostModel({
    this.title,
    this.desc,
    this.id,
    this.createdBy,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null) {
      result.addAll({'title': title});
    }
    if (desc != null) {
      result.addAll({'desc': desc});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }

    return result;
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      title: map['title'],
      desc: map['desc'],
      id: map['id'],
      createdBy: map['createdBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));
}
