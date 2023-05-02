// import 'package:app_ciudadana/src/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});

//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final _formKey = GlobalKey<FormState>();

//   String? email;
//   String? password;
//   String? name;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Registro'),
//       ),
//       body:

//       Column(
//         children: <Widget>[
//           TextField(
//             keyboardType: TextInputType.emailAddress,
//             onChanged: (value) {
//               email = value;
//             },
//             decoration: const InputDecoration(
//               hintText: 'Introduzca su correo electrónico',
//             ),
//           ),
//           TextField(
//             onChanged: (value) {
//               name = value;
//             },
//             decoration: const InputDecoration(
//               hintText: 'Introduzca su nombre',
//             ),
//           ),
//           TextField(
//             obscureText: true,
//             onChanged: (value) {
//               password = value;
//             },
//             decoration: const InputDecoration(
//               hintText: 'Introduzca su contraseña',
//             ),
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               try {
//                 final newUser = await _auth.createUserWithEmailAndPassword(
//                     email: email!, password: password!);
//                 if (newUser != null) {
//                   final userUid = newUser.user!.uid;
//                   await _firestore.collection('usuarios').doc(userUid).set({
//                     'nombre': name,
//                     'correo': email,
//                     // 'contraseña': password,
//                     // 'datos': [],
//                   });
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Usuario registrado correctamente'),
//                     ),
//                   );
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (_) => HomeScreen()),
//                   );
//                 }
//               } catch (e) {
//                 print(e);
//               }
//             },
//             child: const Text('Registrar Usuario'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:app_ciudadana/src/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce tu correo electrónico';
                }
                return null;
              },
              onChanged: (value) {
                email = value;
              },
              decoration: const InputDecoration(
                hintText: 'Introduzca su correo electrónico',
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce tu nombre';
                }
                return null;
              },
              onChanged: (value) {
                name = value;
              },
              decoration: const InputDecoration(
                hintText: 'Introduzca su nombre',
              ),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce tu contraseña';
                }
                return null;
              },
              onChanged: (value) {
                password = value;
              },
              decoration: const InputDecoration(
                hintText: 'Introduzca su contraseña',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);
                    if (newUser != null) {
                      final userUid = newUser.user!.uid;
                      await _firestore.collection('usuarios').doc(userUid).set({
                        'nombre': name,
                        'correo': email,
                        'contraseña': password,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuario registrado correctamente'),
                        ),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: const Text('Registrar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
