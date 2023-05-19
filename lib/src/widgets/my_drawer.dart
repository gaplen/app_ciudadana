import 'package:app_ciudadana/src/home_page.dart';
import 'package:app_ciudadana/src/pages/login/login_page.dart';
import 'package:app_ciudadana/src/pages/modulos/calendario/bitacora_page.dart';
import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/ver_page.dart';
import 'package:app_ciudadana/src/pages/perfil/catalagos_page.dart';
import 'package:app_ciudadana/src/pages/perfil/config_page.dart';
import 'package:app_ciudadana/src/pages/perfil/page_bitacora.dart';
import 'package:app_ciudadana/src/pages/perfil/perfil_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff59554e),
            ),
            accountName: Text(_displayName),
            accountEmail: Text(_email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.blueGrey,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              // Acción a realizar cuando se presiona la opción "Perfil"
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              // Acción a realizar cuando se presiona la opción "Perfil"
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.apps),
          //   title: const Text('Catálogo'),
          //   onTap: () {
          //     // Acción a realizar cuando se presiona la opción "Catálogo"
          //     Navigator.of(context).push(
          //       MaterialPageRoute(builder: (_) => CatalogPage()),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.visibility),
            title: Text('Ver'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => VerEscuelasPage()),
              );
              // Acción cuando se selecciona "Ver"
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.calendar_month),
          //   title: Text('Bitácora'),
          //   onTap: () {
          //     // Acción cuando se selecciona "Bitácora"
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (_) => const PageBitacora(),
          //       ),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.label_important),
          //   title: Text('Especiales'),
          //   onTap: () {
          //     // Acción cuando se selecciona "Especiales"
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              // Acción a realizar cuando se presiona la opción "Configuración"
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ConfiguracionPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Salir'),
            onTap: () async {
              // Acción a realizar cuando se presiona la opción "Salir"
              final googleSignIn = GoogleSignIn();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              await FirebaseAuth.instance.signOut();

              await googleSignIn.signOut();
              await FacebookAuth.instance.logOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(
                          userID: '',
                        )),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
