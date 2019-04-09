import 'package:firebase_database/firebase_database.dart';

class Event {
  String key;
  String title;
  String description;
  int createTime;
  String thumbnail;

  Event(this.title, this.description) {
    this.createTime = DateTime.now().millisecondsSinceEpoch;
  }

  Event.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        description = snapshot.value["description"],
        createTime = snapshot.value["createTime"],
        thumbnail = snapshot.value["thumbnail"];

  toJson() {
    return {
      "title": title,
      "description": description,
      "createTime": createTime,
      "thumbnail": thumbnail,
    };
  }
}
