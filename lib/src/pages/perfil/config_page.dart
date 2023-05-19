import 'package:app_ciudadana/src/pages/perfil/catalagos_page.dart';
import 'package:flutter/material.dart';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({Key? key}) : super(key: key);

  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  bool _notificaciones = true;
  bool _modoOscuro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: const Text('Configuración'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
                      builder: (_) => CatalogPage(
                          // idEscuela: '',
                          ),
                    ),
                  );
                },
                child: const Text('Catalago'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xff59554e),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // SwitchListTile(
          //   title: const Text('Recibir notificaciones'),
          //   value: _notificaciones,
          //   onChanged: (value) {
          //     setState(() {
          //       _notificaciones = value;
          //     });
          //   },
          // ),
          // SwitchListTile(
          //   title: const Text('Modo oscuro'),
          //   value: _modoOscuro,
          //   onChanged: (value) {
          //     setState(() {
          //       _modoOscuro = value;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
