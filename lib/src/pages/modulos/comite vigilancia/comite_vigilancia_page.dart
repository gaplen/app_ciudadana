import 'package:app_ciudadana/src/pages/modulos/comite%20vigilancia/edit_comite_vigilancia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'comite_vigilancia.dart';

class ComiteVigilanciaPage extends StatefulWidget {
  String idEscuela;
  ComiteVigilanciaPage({super.key, required this.idEscuela});

  @override
  State<ComiteVigilanciaPage> createState() =>
      _ComiteVigilanciaPageState(idEscuela: idEscuela);
}

class _ComiteVigilanciaPageState extends State<ComiteVigilanciaPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";

  bool _showSearchBar = false;

  String idEscuela;
  _ComiteVigilanciaPageState({required this.idEscuela});

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _showSearchBar
              ? TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Buscar...",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                )
              : const Center(child: Text("Comite de vigilancia")),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _showSearchBar
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _showSearchBar = false;
                          _searchText = "";
                          _searchController.clear();
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _showSearchBar = true;
                        });
                      },
                    ),
            ),
          ),
        ],
      ),

      //Boton de registro de datos
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff59554e),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => RegistroComiteVigilancia(idEscuela: idEscuela),
          ));
        },
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _auth.currentUser != null
            ? FirebaseFirestore.instance
                .collection('usuarios')
                .doc(_auth.currentUser!.uid)
                .collection('escuelas')
                .doc(idEscuela)
                .collection('comiteVigilancia')
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffe2e3d9),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 25),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 0),
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xffe2e3d9),
                                        radius: 35,
                                        backgroundImage: const AssetImage(
                                            'assets/comite.png'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15),
                                      child: Column(
                                        children: [
                                          //Puesto
                                          SizedBox(
                                            //Definir el ancho para que no sobrepase los pixeles
                                            width: 180,

                                            child: RichText(
                                              text: TextSpan(
                                                  text: 'Puesto: ',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${data['puesto'] != null ? data['puesto'] : 'No hay puesto'}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )
                                                  ]),
                                            ),
                                          ),

                                          // const SizedBox(height: 10),

                                          //Nombre
                                          SizedBox(
                                            //Definir el ancho para que no sobrepase los pixeles
                                            width: 180,

                                            child: RichText(
                                              text: TextSpan(
                                                  text: 'Nombre: ',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${data['nombre'] != null ? data['nombre'] : 'No hay nombre'}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )
                                                  ]),
                                            ),
                                          ),

                                          // const SizedBox(height: 10),

                                          //Teléfono
                                          SizedBox(
                                            //Definir el ancho para que no sobrepase los pixeles
                                            width: 180,

                                            child: RichText(
                                              text: TextSpan(
                                                  text: 'Teléfono: ',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${data['telefono'] != null ? data['telefono'] : 'No hay telefono'}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  EditVigilanciaScreen(
                                                data: data,
                                                idVigilancia: data.id,
                                                idEscuela: idEscuela,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(height: 10)
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
