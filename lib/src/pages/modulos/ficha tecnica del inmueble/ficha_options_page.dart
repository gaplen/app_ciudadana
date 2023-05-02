import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/registro_bienestar_beca.dart';
import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/registro_ficha_tecnica.dart';
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
      ),
      body: Column(children: [
        Center(
          child: Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const FichaTecnicaRegistro(),
                  ),
                );
              },
              child: Text('Nuevo ctt'),
            ),
          ),
        ),
        Center(
          child: Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const RegistroBienestarBeca(),
                  ),
                );
              },
              child: Text('Bienestar'),
            ),
          ),
        )
      ]),
    );
  }
}
