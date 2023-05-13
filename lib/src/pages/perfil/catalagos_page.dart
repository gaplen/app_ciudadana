import 'package:app_ciudadana/src/pages/perfil/catalago_add.dart';
import 'package:app_ciudadana/src/pages/perfil/edit_catalago.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String newTitle = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";
  bool _showSearchBar = false;
  // String _searchText = "";
  String? _selectedValue;

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
                .where('nombre', isLessThanOrEqualTo: _searchText + '\uf8ff')
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            // height: 100,cd
                            decoration: BoxDecoration(
                              color: Color(0xffe2e3d9),
                              border: Border.all(color: Colors.black, width: 1),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            // color: Colors.red,
                                            child: Text(
                                              '${data['nombre'] != null ? data['nombre'] : ''}',

                                              // 'Escuela  : ${data['nombreEscuela']}',
                                              overflow: TextOverflow.ellipsis,
                                              // data['nombreEscuela'].toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
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
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                    ),
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
                                      icon: const Icon(
                                        Icons.label,
                                        size: 20,
                                      ),
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