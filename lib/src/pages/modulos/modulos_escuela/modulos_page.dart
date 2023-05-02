import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_bienestar_page.dart';
import 'package:app_ciudadana/src/pages/modulos/comite%20vigilancia/comite_vigilancia_page.dart';
import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/ficha_tecnica_del_inmueble.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/registro_escuelas.dart';
import 'package:flutter/material.dart';

import '../modulo comite ejecucion/comote_ejecucion_page.dart';

class ModulosScreen extends StatefulWidget {
  const ModulosScreen({super.key});

  @override
  State<ModulosScreen> createState() => _ModulosScreenState();
}

class _ModulosScreenState extends State<ModulosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('modulos page'),
      ),
      body: Column(
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const RegistroEscuela(),
                      ),
                    );
                  },
                  child: Text('Registro de escuela'),
                ),
              ),
              SizedBox(width: 20),
              Container(
                height: 150,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción del botón
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const FichaTecnicaPage(),
                      ),
                    );
                  },
                  child: const Text('Ficha técnica del inmueble'),
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
                        builder: (_) => const ComiteEjecucionPage(),
                      ),
                    );
                  },
                  child: const Text('Comité de ejecución'),
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
                        builder: (_) => const ComiteVigilanciaPage(),
                      ),
                    );
                  },
                  child: const Text('Comité de vigilancia'),
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
                    builder: (_) => const ComiteBienestarPage(),
                  ),
                );
              },
              child: const Text('Comité de bienestar'),
            ),
          ),
        ],
      ),
    );
  }
}