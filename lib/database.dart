import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DataBase {
  static List<Map> data = [];

  static DatabaseReference db = FirebaseDatabase.instance.ref('employees');
  // static CollectionReference fireStore =
  //     FirebaseFirestore.instance.collection('employees');

  static Future insertData(String email, String pass,String imageURL) async {
    String key = db
        .push()
        .key!;

    db.child(key).set({
      'email': email,
      'pass': pass,
      'image':imageURL,
      'key': key,

    });

    // fireStore.add({
    //   'email': email,
    //   'pass': pass,
    // }).then((value) {
    //   selectData();
    // });
  }

  static Future updateDate(String email, String pass, String key) async {
    db.child(key).update({
      'email': email,
      'pass': pass,
      'key': key,
    }).then((value) {
      selectData();
    });

    // fireStore.add({
    //   'email': email,
    //   'pass': pass,
    // }).then((value) {
    //   selectData();
    // });

  }

  static deleteData(String key) {
    db.child(key).remove();
    // fireStore.doc(key).delete();
  }

  static Future selectData() async {
    Map temp = {};
    db.once().then((value) {
      temp = value.snapshot.value as Map;
      data.clear();
      temp.forEach((key, value) {
        data.add(value);
      });
    });

    // fireStore.get().then((value) {
    // });
    
    
  }
}
