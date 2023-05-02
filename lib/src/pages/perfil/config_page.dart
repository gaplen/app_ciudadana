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
        title: const Text('Configuración'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Recibir notificaciones'),
            value: _notificaciones,
            onChanged: (value) {
              setState(() {
                _notificaciones = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Modo oscuro'),
            value: _modoOscuro,
            onChanged: (value) {
              setState(() {
                _modoOscuro = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
