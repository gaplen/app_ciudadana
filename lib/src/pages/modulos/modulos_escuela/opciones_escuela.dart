import 'package:app_ciudadana/src/pages/modulos/calendario/bitacora_page.dart';
import 'package:app_ciudadana/src/pages/modulos/calendario/calendario_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/especiales_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/modulos_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/ver_page.dart';
import 'package:flutter/material.dart';

class OpcionesEscuela extends StatefulWidget {
  String idEscuela;
  OpcionesEscuela({super.key, required this.idEscuela});
  @override
  _OpcionesEscuelaState createState() => _OpcionesEscuelaState();
}

class _OpcionesEscuelaState extends State<OpcionesEscuela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Escuela"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de "Editar"
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ModulosScreen(
                idEscuela: widget.idEscuela,
                // data: data,
              ),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de "Ver"
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => VerEscuelasPage(
                //         // data: data,
                //         // escuelaId: data.id,
                //         ),
                //   ),
                // );
              },
              child: Text("Ver"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de "Bitácora"
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BitacoraScreen(
                      idEscuela: '',
                      // data: data,
                      // escuelaId: data.id,
                    ),
                  ),
                );
              },
              child: Text("Bitácora"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de "Especiales"
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EspecialesPage(
                        // data: data,
                        // escuelaId: data.id,
                        ),
                  ),
                );
              },
              child: Text("Especiales"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de "Agendar"
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CalendarioPage(
                      idEscuela: '',
                      // data: data,
                      // escuelaId: data.id,
                    ),
                  ),
                );
              },
              child: Text("Agendar"),
            ),
          ],
        ),
      ),
    );
  }
}
