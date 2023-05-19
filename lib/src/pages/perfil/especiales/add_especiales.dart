import 'package:app_ciudadana/src/pages/perfil/catalago_add.dart';
import 'package:app_ciudadana/src/pages/perfil/edit_catalago.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddEspeciales extends StatefulWidget {
  String idEscuela;
  AddEspeciales({super.key, required this.idEscuela});

  @override
  _AddEspecialesState createState() =>
      _AddEspecialesState(idEscuela: idEscuela);
}

class _AddEspecialesState extends State<AddEspeciales> {
  String newTitle = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _searchText = "";
  bool _showSearchBar = false;
  String? _selectedValue;

  String idEscuela;
  _AddEspecialesState({required this.idEscuela});

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String newName = '';

  @override
  void initState() {
    // Asignamos la primera categoría como categoría actual seleccionada

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AddEtiqueta(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _auth.currentUser != null
            ? FirebaseFirestore.instance
                .collection('usuarios')
                .doc(_auth.currentUser!.uid)
                .collection('etiquetas')
                .where('nombre', isGreaterThanOrEqualTo: _searchText)
                .where('nombre', isLessThanOrEqualTo: '$_searchText\uf8ff')
                .snapshots()
            : const Stream.empty(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else {
            final docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return const Center(child: Text("No hay datos"));
            } else {
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = docs[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              border: Border.all(color: Colors.pink.shade900),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          //Mostrar etiqueta
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Text(
                                              '${data['nombre'] ?? ''}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const Spacer(),

                                    //Editar el catálogo
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => EditarCatalago(
                                              data: data,
                                              escuelaId: data.id,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit, size: 20),
                                    ),

                                    //Agregar a especiales
                                    IconButton(
                                      onPressed: () {
                                        final currentUser = _auth.currentUser;

                                        final info = {
                                          'nombre': data['nombre'],
                                        };

                                        // Guarda los nuevos datos de la escuela en la base de datos.
                                        FirebaseFirestore.instance
                                            .collection('usuarios')
                                            .doc(currentUser!.uid)
                                            .collection('escuelas')
                                            .doc(idEscuela)
                                            .collection('especiales')
                                            .add(info);

                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.label, size: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}


//