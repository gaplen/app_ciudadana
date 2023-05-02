import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;

  User(this.name, this.email);
}

class UserRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) async {
    try {
      // Agregar el registro de usuario
      DocumentReference userDocRef = await _usersCollection.add({
        'name': user.name,
        'email': user.email,
      });

      // Agregar la subcolección dentro del registro de usuario
      CollectionReference subCollectionRef =
          userDocRef.collection('subcollection');
      await subCollectionRef.add({
        'field1': 'value1',
        'field2': 'value2',
      });
    } catch (e) {
      print('Error al guardar el usuario: $e');
    }
  }
}
