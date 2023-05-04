import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/registro_bienestar_beca.dart';
import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/registro_CTT.dart';
import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/registro_mejor_escuela.dart';
import 'package:flutter/material.dart';

class FichaOptionsPage extends StatefulWidget {
  const FichaOptionsPage({super.key});

  @override
  State<FichaOptionsPage> createState() => _FichaOptionsPageState();
}

class _FichaOptionsPageState extends State<FichaOptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ficha page'),
        backgroundColor: Color(0xff59554e),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implementar la funcionalidad del botón "Calendario"
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => FichaTecnicaRegistro(),
                              ),
                            );
                          },
                          child: const Text('Nuevo ctt'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff59554e),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implementar la funcionalidad del botón "Calendario"
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => MejorEscuelaRegistro(),
                              ),
                            );
                          },
                          child: const Text('Mejor Escuela'),
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
                SizedBox(
                  width: 10,
                ),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implementar la funcionalidad del botón "Calendario"
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RegistroBienestarBeca(),
                          ),
                        );
                      },
                      child: const Text('Bienestar'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff59554e),
                        ),
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: Container(
                //     height: 150,
                //     width: 150,
                //     color: Colors.pink,
                //     child: TextButton(
                //       onPressed: () {
                //         Navigator.of(context).pushReplacement(
                //           MaterialPageRoute(
                //             builder: (_) => const RegistroBienestarBeca(),
                //           ),
                //         );
                //       },
                //       child: Text('Bienestar'),
                //     ),
                //   ),
                // ),
              ],
            ),
          ]),
    );
  }
}
