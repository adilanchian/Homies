import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:homies/models/user.dart';

class FirestoreActions {
  final Firestore firestore;

  FirestoreActions(this.firestore);

  void createUser(User user) {
    CollectionReference usersCollection = firestore.collection('users');
    usersCollection.document(user.id).setData(user.toJson());
  }
}
