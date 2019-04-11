import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

class Message {
  String key;
  Author author;
  String text;
  int time;

  Message(this.author, this.text) {
    this.time = DateTime.now().millisecondsSinceEpoch;
  }

  Message.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        author = Author(uid: snapshot.value["author"]["uid"], name: snapshot.value["author"]["name"]),
        text = snapshot.value["text"],
        time = snapshot.value["time"];

  toJson() {
    return {
      "author": author.toJson(),
      "text": text,
      "time": time,
    };
  }
}

class Author {
  final String uid;
  final String name;
  String photoUrl;

  Author({@required this.uid, @required this.name, String photoUrl});

  toJson() {
    return {
      "uid": uid,
      "name": name,
      "photoUrl": photoUrl,
    };
  }
}
