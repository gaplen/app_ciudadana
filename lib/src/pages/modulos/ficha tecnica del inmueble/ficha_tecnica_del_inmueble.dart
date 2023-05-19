import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/registro_ficha_tecnica.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FichaTecnicaPage extends StatefulWidget {
  String idEscuela;
  FichaTecnicaPage({super.key, required this.idEscuela});

  @override
  State<FichaTecnicaPage> createState() =>
      _FichaTecnicaPageState(idEscuela: idEscuela);
}

class _FichaTecnicaPageState extends State<FichaTecnicaPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";
  bool _showSearchBar = false;

  String idEscuela;
  _FichaTecnicaPageState({required this.idEscuela});

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                : const Center(child: Text('Ficha Tecnica')),
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

        //Boton de Registro
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => RegistroInmueble(
                        idEscuela: widget.idEscuela,
                      )),
            );
          },
        ),
        body: Container(
          padding: const EdgeInsets.all(18.0),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _auth.currentUser != null
                ? FirebaseFirestore.instance
                    .collection('usuarios')
                    .doc(_auth.currentUser!.uid)
                    .collection('escuelas')
                    .doc(idEscuela)
                    .collection('fichaInmueble')
                    .where('escuela', isGreaterThanOrEqualTo: _searchText)
                    .where('escuela', isLessThanOrEqualTo: '$_searchText\uf8ff')
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

                      return SizedBox(
                        height: 500,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.brown.shade100),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Mostrar el Cuadrante
                                      RichText(
                                        text: TextSpan(
                                            text: 'Cuadrante: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['cuadrante']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar el Plantel
                                      RichText(
                                        text: TextSpan(
                                            text: 'Plantel: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['plantel']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar la escuela
                                      RichText(
                                        text: TextSpan(
                                            text: 'Escuela: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['escuela']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar turno
                                      RichText(
                                        text: TextSpan(
                                            text: 'Turno: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['turno']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      const Text(
                                          '-------------------------------------------------------',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),

                                      //Mostrar CCT
                                      RichText(
                                        text: TextSpan(
                                            text: 'CCT: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['ctt']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar Matricula
                                      RichText(
                                        text: TextSpan(
                                            text: 'Matrícula: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['matricula']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar Director
                                      RichText(
                                        text: TextSpan(
                                            text: 'Director: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['director']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar Telefono
                                      RichText(
                                        text: TextSpan(
                                            text: 'Teléfono: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['telefono']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      const Text(
                                          '-------------------------------------------------------',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const Text(
                                          'La Escuela es Nuestra - Mejor Escuela',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const Text(
                                          '-------------------------------------------------------',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),

                                      //Mostrar registro 2019
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2019: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['escuelaA']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar registro 2020
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2020: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['escuelaB']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar registro 2021
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2021: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['escuelaC']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar registro 2022
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2022: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['escuelaD']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar registro 2023
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2023: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['escuelaE']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      const Text(
                                          '-------------------------------------------------------',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const Text(
                                          'Bienestar para Niñas y Niños, Mi Beca para Empezar',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const Text(
                                          '-------------------------------------------------------',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const Text(
                                          'Becas entregadas por año en el inmueble',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      const Text(
                                          '-------------------------------------------------------',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),

                                      //Mostrar bienestar 2019
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2019: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['bienestarA']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar bienestar 2020
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2020: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['bienestarB']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar bienestar 2021
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2021: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['bienestarC']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar bienestar 2022
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2022: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['bienestarD']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar bienestar 2023
                                      RichText(
                                        text: TextSpan(
                                            text: '- 2023: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['bienestarE']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),

                                      //Mostrar promedio
                                      RichText(
                                        text: TextSpan(
                                            text: 'Promedio: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: '${data['promedio']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
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
        ));
  }
}
