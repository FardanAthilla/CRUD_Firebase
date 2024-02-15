import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String? title;
  String? description;
  Timestamp? createdAt;

  TodoModel({this.id, this.title, this.description, this.createdAt});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    createdAt = json["createdAt"] as Timestamp;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["createdAt"] = createdAt;
    return data;
  }
}