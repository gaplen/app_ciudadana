import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  // Lista de elementos de catálogo
  final List<String> _catalogItems = [
    'Producto 1',
    'Producto 2',
    'Producto 3',
    'Producto 4',
    'Producto 5',
    'Producto 6',
    'Producto 7',
    'Producto 8',
    'Producto 9',
    'Producto 10',
  ];

  // Lista de categorías de catálogo
  final List<String> _catalogCategories = [
    'Categoría 1',
    'Categoría 2',
    'Categoría 3',
    'Categoría 4',
    'Categoría 5',
  ];

  // Categoría actual seleccionada
  String _currentCategory = '';

  @override
  void initState() {
    // Asignamos la primera categoría como categoría actual seleccionada
    _currentCategory = _catalogCategories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
      ),
      body: Column(
        children: [
          // DropdownButton para seleccionar la categoría actual
          DropdownButton<String>(
            value: _currentCategory,
            onChanged: (value) {
              setState(() {
                _currentCategory = value!;
              });
            },
            items: _catalogCategories.map<DropdownMenuItem<String>>((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // ListView de elementos de catálogo filtrados por categoría
          Expanded(
            child: ListView.builder(
              itemCount: _catalogItems.length,
              itemBuilder: (context, index) {
                if (_currentCategory == 'Todos' || _currentCategory == '') {
                  // Si no hay una categoría seleccionada, se muestran todos los elementos
                  return ListTile(
                    title: Text(_catalogItems[index]),
                  );
                } else {
                  // Si hay una categoría seleccionada, se filtran los elementos por categoría
                  if (_catalogItems[index].contains(_currentCategory)) {
                    return ListTile(
                      title: Text(_catalogItems[index]),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
