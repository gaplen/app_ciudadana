import 'package:app_ciudadana/src/pages/perfil/editar_perfil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String _displayName = '';
  String _email = '';
  String _city = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    try {
      final currentUser = _auth.currentUser;
      final userDoc =
          await _firestore.collection('usuarios').doc(currentUser!.uid).get();
      final userData = userDoc.data() as Map<String, dynamic>;

      setState(() {
        _displayName = userData['nombre'];
        _email = userData['correo'];
        // _telefono = userData['telefono'];
      });
    } catch (error) {
      print('Error getting user info: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Aquí puedes agregar la imagen de perfil del usuario
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              _displayName,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              _email,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // const Text(
            //   'Ciudad',
            //   style: TextStyle(
            //     fontSize: 18.0,
            //   ),
            // ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => EditProfilePerfil()),
                );
              },
              child: const Text('Editar perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
