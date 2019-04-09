import 'package:firebase_database/firebase_database.dart';

class Message {
  String key;
  Author author;
  String text;
  int createTime;

  Message(this.author, this.text) {
    this.createTime = DateTime.now().millisecondsSinceEpoch;
  }

  Message.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        author = snapshot.value["author"],
        text = snapshot.value["text"],
        createTime = snapshot.value["createTime"];

  toJson() {
    return {
      "author": author.toJson(),
      "text": text,
      "createTime": createTime,
    };
  }
}

class Author {
  String uid;
  String name;
  String photoUrl;

  Author(this.uid, this.name, {String photoUrl});

  toJson() {
    return {
      "uid": uid,
      "name": name,
      "photoUrl": photoUrl,
    };
  }
}
