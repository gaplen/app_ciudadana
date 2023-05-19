// import 'dart:typed_data';

// import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_edit_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:signature/signature.dart';

// import 'comite_bienestar.dart';

// class ComiteBienestarPage extends StatefulWidget {
//   String idEscuela;

//   ComiteBienestarPage({super.key, required this.idEscuela});

//   @override
//   State<ComiteBienestarPage> createState() =>
//       _ComiteBienestarPageState(idEscuela: idEscuela);
// }

// Uint8List? image;

// class _ComiteBienestarPageState extends State<ComiteBienestarPage> {
//   String idEscuela;

//   _ComiteBienestarPageState({required this.idEscuela});
//   bool isSignatureEnabled = true;
//   bool _isButtonEnabled = true; // Estado inicial del botón
//   Color _buttonColor = Colors.green; //
//   final SignatureController _controller = SignatureController(
//       penStrokeWidth: 1,
//       penColor: Colors.black,
//       exportBackgroundColor: Colors.white10);
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _searchController = TextEditingController();

//   String _searchText = "";
//   bool _showSearchBar = false;
//   // TextEditingController _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff59554e),
//         title: AnimatedSwitcher(
//           duration: Duration(milliseconds: 200),
//           child: _showSearchBar
//               ? TextField(
//                   controller: _searchController,
//                   decoration: const InputDecoration(
//                     hintText: "Buscar...",
//                     border: InputBorder.none,
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _searchText = value;
//                     });
//                   },
//                 )
//               : Center(child: Text("Comite Bienestar")),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 18.0),
//             child: AnimatedSwitcher(
//               duration: Duration(milliseconds: 200),
//               child: _showSearchBar
//                   ? IconButton(
//                       icon: Icon(Icons.clear),
//                       onPressed: () {
//                         setState(() {
//                           _showSearchBar = false;
//                           _searchText = "";
//                           _searchController.clear();
//                         });
//                       },
//                     )
//                   : IconButton(
//                       icon: Icon(Icons.search),
//                       onPressed: () {
//                         setState(() {
//                           _showSearchBar = true;
//                         });
//                       },
//                     ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xff59554e),
//         child: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//                 builder: (_) => RegistroComiteBienestar(
//                       idEscuela: '',
//                       // escuelaId: '',
//                     )),
//           );
//         },
//       ),
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: _auth.currentUser != null
//             ? FirebaseFirestore.instance
//                 .collection('usuarios')
//                 .doc(_auth.currentUser!.uid)
//                 .collection('escuelas')
//                 .doc(idEscuela)
//                 .collection('comiteBienestar')
//                 .where('nombreBienestar', isGreaterThanOrEqualTo: _searchText)
//                 .where('nombreBienestar',
//                     isLessThanOrEqualTo: '$_searchText\uf8ff')
//                 .snapshots()
//             : const Stream.empty(),
//         builder: (BuildContext context,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Error"));
//           } else {
//             final docs = snapshot.data!.docs;
//             if (docs.isEmpty) {
//               return const Center(child: Text("No hay datos"));
//             } else {
//               return ListView.builder(
//                 itemCount: docs.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final data = docs[index];

//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 130,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.black,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                             color: Color(0xffe2e3d9),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 const SizedBox(width: 25),
//                                 Row(
//                                   children: [
//                                     const Padding(
//                                       padding:
//                                           EdgeInsets.only(top: 20, left: 12),
//                                       child: CircleAvatar(
//                                         backgroundColor: Color(0xff59554e),
//                                         radius: 35,
//                                         backgroundImage:
//                                             AssetImage('assets/comite.png'),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 15, left: 15),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.5,
//                                             // color: Colors.red,
//                                             child: Text(
//                                               'Puesto    : ${data['puesto']}',
//                                               // data['nombreEscuela'].toString(),
//                                               style: const TextStyle(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.5,
//                                             // color: Colors.red,
//                                             child: Text(
//                                               'Nombre  : ${data['nombre']}',
//                                               style: const TextStyle(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.5,
//                                             // color: Colors.red,
//                                             child: Text(
//                                               'Telefono: ${data['telefono']}',
//                                               style: const TextStyle(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 0.0),
//                                       child: IconButton(
//                                         onPressed: () {
//                                           Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                               builder: (_) =>
//                                                   EditComiteBienestar(
//                                                 data: data,
//                                                 escuelaId: data.id,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         icon: const Icon(Icons.edit),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_edit_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import 'comite_bienestar.dart';

class ComiteBienestarPage extends StatefulWidget {
  String idEscuela;

  ComiteBienestarPage({super.key, required this.idEscuela});

  @override
  State<ComiteBienestarPage> createState() =>
      _ComiteBienestarPageState(idEscuela: idEscuela);
}

// Uint8List? image;

class _ComiteBienestarPageState extends State<ComiteBienestarPage> {
  String idEscuela;

  _ComiteBienestarPageState({required this.idEscuela});

  bool isSignatureEnabled = true;
  bool _isButtonEnabled = true; // Estado inicial del botón
  Color _buttonColor = Colors.green;

  final SignatureController _controller = SignatureController(
      penStrokeWidth: 1,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white10);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";
  bool _showSearchBar = false;

  // TextEditingController _searchController = TextEditingController();

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
              : const Center(child: Text("Comite Bienestar")),
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

      //Boton de registro
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => RegistroComiteBienestar(idEscuela: idEscuela)),
          );
        },
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _auth.currentUser != null
            ? FirebaseFirestore.instance
                .collection('usuarios')
                .doc(_auth.currentUser!.uid)
                .collection('escuelas')
                .doc(idEscuela)
                .collection('comiteBienestar')
                .where('nombreBienestar', isGreaterThanOrEqualTo: _searchText)
                .where('nombreBienestar',
                    isLessThanOrEqualTo: '$_searchText\uf8ff')
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
                                      padding:
                                          EdgeInsets.only(top: 20, left: 12),
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xff59554e),
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage('assets/comite.png'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //Puesto

                                          SizedBox(
                                            //Definir el ancho para que no sobrepase los pixeles
                                            // width: 180,

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
                                                          '${data['puestoBienestar'] != null ? data['puestoBienestar'] : 'No hay puesto'}',
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
                                            // width: 180,

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
                                                          '${data['nombreBienestar'] != null ? data['nombreBienestar'] : 'No hay informacion'}',
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
                                            width: 200,

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
                                                          '${data['telefonoBienestar'] != null ? data['telefonoBienestar'] : 'No hay informacion'}',
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
                                                  EditComiteBienestar(
                                                data: data,
                                                idBienestar: data.id,
                                                idEscuela: idEscuela,
                                              ),
                                            ),
                                          );
                                          print('idEscuela: $idEscuela');
                                          print('idBienestar: ${data.id}');
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
