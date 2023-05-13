import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePerfil extends StatefulWidget {
  const EditProfilePerfil({Key? key}) : super(key: key);

  @override
  State<EditProfilePerfil> createState() => _EditProfilePerfilState();
}

class _EditProfilePerfilState extends State<EditProfilePerfil> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;

  String _displayName = '';
  String _email = '';
  String _city = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _cityController = TextEditingController();
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
        // _city = userData['ciudad'] ?? '';
        _nameController.text = _displayName;
        _emailController.text = _email;
        _cityController.text = _city;
      });
    } catch (error) {
      print('Error getting user info: $error');
    }
  }

  Future<void> _updateUserInfo() async {
    try {
      final currentUser = _auth.currentUser;
      await _firestore.collection('usuarios').doc(currentUser!.uid).update({
        'nombre': _nameController.text,
        'correo': _emailController.text,
        // 'ciudad': _cityController.text,
      });
      setState(() {
        _displayName = _nameController.text;
        _email = _emailController.text;
        _city = _cityController.text;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Perfil actualizado'),
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al actualizar el perfil: $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese su nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese su correo electrónico';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // TextFormField(
                  //   controller: _cityController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Ciudad',
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showChangePasswordDialog();
                    },
                    child: const Text('Cambiar contraseña'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateUserInfo();
                      }
                    },
                    child: const Text('Guardar Cambios'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showChangePasswordDialog() async {
    final currentUser = _auth.currentUser;

    if (currentUser == null ||
        !currentUser.providerData.any((provider) =>
            provider.providerId == EmailAuthProvider.PROVIDER_ID)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'El usuario no se creó con correo electrónico y contraseña.'),
        ),
      );
      return;
    }

    String? currentPassword;
    String? newPassword;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cambiar contraseña'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña actual',
              ),
              onChanged: (value) {
                currentPassword = value;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nueva contraseña',
              ),
              onChanged: (value) {
                newPassword = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (currentPassword != null && newPassword != null) {
                try {
                  final user = _auth.currentUser!;
                  final credential = EmailAuthProvider.credential(
                    email: user.email!,
                    password: currentPassword!,
                  );
                  await user.reauthenticateWithCredential(credential);
                  await user.updatePassword(newPassword!);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Contraseña actualizada'),
                    ),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al cambiar la contraseña: $error'),
                    ),
                  );
                }
              }
            },
            child: const Text('Cambiar'),
          ),
        ],
      ),
    );
  }
}
