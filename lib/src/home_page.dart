import 'dart:async';

import 'package:app_ciudadana/src/pages/login/login_page.dart';
import 'package:app_ciudadana/src/pages/modulos/calendario/calendario_page.dart';
import 'package:app_ciudadana/src/pages/modulos/contactos/contactos_page.dart';
import 'package:app_ciudadana/src/pages/modulos/escuelas_page.dart';
import 'package:app_ciudadana/src/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool _hasInternetConnection = true;

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    // _checkInternetConnection().then(
    //   (value) {
    //     setState(() {
    //       _hasInternetConnection = value;
    //       if (!_hasInternetConnection) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             backgroundColor: Colors.red,
    //             content: Text('No hay conexión a internet.'),
    //           ),
    //         );
    //       } else {
    //         _hasInternetConnection = value;
    //         if (_hasInternetConnection) {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               backgroundColor: Colors.green,
    //               content: Text('Tienes conexion a internet.'),
    //             ),
    //           );
    //         }
    //       }
    //     });
    //   },
    // );
    super.initState();
    _checkInternetConnection().then((value) {
      setState(() {
        _hasInternetConnection = value;
        if (!_hasInternetConnection) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('No hay conexión a internet.'),
            ),
          );
        } else {
          _hasInternetConnection = value;
          if (_hasInternetConnection) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Tienes conexion a internet.'),
              ),
            );
          }
        }
      });
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   _checkInternetConnection().then((value) {
  //     setState(() {
  //       _hasInternetConnection = value;
  //       if (!_hasInternetConnection) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             backgroundColor: Colors.red,
  //             content: Text('No hay conexión a internet.'),
  //           ),
  //         );
  //       } else {
  //         if (_hasInternetConnection) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               backgroundColor: Colors.green,
  //               content: Text('Tienes conexion a internet.'),
  //             ),
  //           );
  //         }
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: const Text('Inicio'),
        actions: [],
      ),
      drawer: const MyDrawer(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffa1c1be), Color(0xff9ec4bb), Color(0xffeed7c5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Center(
                //   child:
                //       Text('Has internet connection: $_hasInternetConnection'),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implementar la funcionalidad del botón "Escuelas"
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const EscuelasScreen()),
                            );
                          },
                          child: const Text('Escuelas'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff59554e),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implementar la funcionalidad del botón "Calendario"
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CaledarioPage(),
                              ),
                            );
                          },
                          child: const Text('Calendario'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff59554e),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implementar la funcionalidad del botón "Contactos"
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ContactosPage(),
                              ),
                            );
                          },
                          child: const Text('Contactos'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff59554e),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implementar la funcionalidad del botón "Reportes"
                          },
                          child: const Text('Reportes'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff59554e),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
