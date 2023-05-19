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
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción del botón
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CalendarioPage(
                                idEscuela: idEscuela,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Agendar evento',
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff59554e),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción del botón
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FichaTecnicaPage(
                                idEscuela: widget.idEscuela,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Ficha técnica del inmueble',
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff59554e),
                          ),
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
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción del botón
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ComiteEjecucionPage(
                                idEscuela: idEscuela,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Comité de ejecución',
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff59554e),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción del botón

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ComiteVigilanciaPage(
                                idEscuela: idEscuela,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Comité de vigilancia',
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff59554e),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 150,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción del botón
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ComiteBienestarPage(
                            idEscuela: idEscuela,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Comité de bienestar',
                      textAlign: TextAlign.center,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xff59554e),
                      ),
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
