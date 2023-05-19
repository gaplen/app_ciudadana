import 'package:app_ciudadana/src/pages/modulos/calendario/calendario_page.dart';
import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_bienestar_page.dart';
import 'package:app_ciudadana/src/pages/modulos/comite%20vigilancia/comite_vigilancia_page.dart';
import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/ficha_tecnica_del_inmueble.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/registro_escuelas.dart';
import 'package:flutter/material.dart';

import '../calendario/add_event.dart';
import '../modulo comite ejecucion/comote_ejecucion_page.dart';

class ModulosScreen extends StatefulWidget {
  String idEscuela;
  ModulosScreen({super.key, required this.idEscuela});

  @override
  State<ModulosScreen> createState() =>
      _ModulosScreenState(idEscuela: idEscuela);
}

class _ModulosScreenState extends State<ModulosScreen> {
  String idEscuela;
  _ModulosScreenState({required this.idEscuela});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: const Text('Módulos'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CalendarioPage(
                              idEscuela: idEscuela,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 151, 103, 26),
                              Color.fromARGB(255, 2, 161, 116)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  'assets/calendar.png',
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              'Agendar evento',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => FichaTecnicaPage(
                              idEscuela: widget.idEscuela,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 151, 103, 26),
                              Color.fromARGB(255, 2, 161, 116)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  'assets/inmueble.png',
                                  height: 90,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              'Ficha técnica del inmueble',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ComiteEjecucionPage(
                              idEscuela: idEscuela,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 151, 103, 26),
                              Color.fromARGB(255, 2, 161, 116)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  'assets/ejecucion.png',
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              'Comité de ejecución',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ComiteVigilanciaPage(
                              idEscuela: idEscuela,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 151, 103, 26),
                              Color.fromARGB(255, 2, 161, 116)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  'assets/vigilancia.png',
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              'Comité de vigilancia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ComiteBienestarPage(
                          idEscuela: idEscuela,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 151, 103, 26),
                          Color.fromARGB(255, 2, 161, 116)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/bienestar.png',
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          'Comité de bienestar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
