import 'package:app_ciudadana/src/pages/modulos/calendario/bitacora_page.dart';
import 'package:app_ciudadana/src/pages/modulos/calendario/calendario_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/especiales_page.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/ver_page.dart';
import 'package:flutter/material.dart';

class OpcionesEscuela extends StatefulWidget {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de "Ver"
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VerEscuelasPage(
                        // data: data,
                        // escuelaId: data.id,
                        ),
                  ),
                );
              },
              child: Text("Ver"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de "Bitácora"
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BitacoraScreen(
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
                    builder: (_) => CaledarioPage(
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
