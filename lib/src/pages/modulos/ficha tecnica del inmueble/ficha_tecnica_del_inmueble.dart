// import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/ficha_options_page.dart';
// import 'package:flutter/material.dart';

// class FichaTecnicaPage extends StatefulWidget {
//   const FichaTecnicaPage({super.key});

//   @override
//   State<FichaTecnicaPage> createState() => _FichaTecnicaPageState();
// }

// class _FichaTecnicaPageState extends State<FichaTecnicaPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ficha técnica del inmueble'),
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Acción del botón
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (_) => const FichaOptionsPage(),
//               ),
//             );
//           },
//           child: Icon(Icons.add)),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               cttWidget(),
//               SizedBox(height: 10),
//               cttWidget(),
//               SizedBox(height: 10),
//               cttWidget(),
//               SizedBox(height: 10),
//               cttWidget(),
//               SizedBox(height: 10),
//               Text('total de escuelas: 4'),
//               SizedBox(height: 30),
//               Center(child: Text('La Escuela es Nuestra - Mejor Escuela')),
//               SizedBox(height: 30),
//               trabajoWidget(),
//               Center(child: Text('Bienestar para Niñas y niños, Mi Beca para')),
//               SizedBox(height: 30),
//               bienestarWidget()
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget cttWidget() {
//     return Container(
//       // height: 200,
//       width: double.infinity,
//       // color: Colors.red,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 50,
//               width: 150,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               // color: Colors.pink,
//               child: Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       'CTT1',
//                       style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       ' 009DPR1809E',
//                       style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     'Matricula: ',
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   '333',
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // Text(
//               //   'telefono: 5549518518',
//               //   style: TextStyle(
//               //       fontSize: 15,
//               //       color: Colors.black,
//               //       fontWeight: FontWeight.bold),
//               // ),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     'Director(a): ',
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   'Adriana Luz Maria Flores Rangel',
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // Text(
//               //   'telefono: 5549518518',
//               //   style: TextStyle(
//               //       fontSize: 15,
//               //       color: Colors.black,
//               //       fontWeight: FontWeight.bold),
//               // ),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     'Telefono:: ',
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   '1321312312',
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // Text(
//               //   'telefono: 5549518518',
//               //   style: TextStyle(
//               //       fontSize: 15,
//               //       color: Colors.black,
//               //       fontWeight: FontWeight.bold),
//               // ),
//             ],
//           ),
//           SizedBox(height: 10),
//           // Row(
//           //   children: [
//           //     Text(
//           //       'Director(a): Adriana Flores',
//           //       style: TextStyle(
//           //           fontSize: 15,
//           //           color: Colors.black,
//           //           fontWeight: FontWeight.bold),
//           //     ),
//           //     SizedBox(width: 10),
//           //     Text(
//           //       'Telefono: 5549518518',
//           //       style: TextStyle(
//           //           fontSize: 15,
//           //           color: Colors.black,
//           //           fontWeight: FontWeight.bold),
//           //     ),
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget trabajoWidget() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Column(
//         children: [
//           DataTable(
//             columns: [
//               DataColumn(
//                 label: Text('Trabajo'),
//               ),
//               DataColumn(
//                 label: Text('2019'),
//               ),
//               DataColumn(
//                 label: Text('2020'),
//               ),
//               DataColumn(
//                 label: Text('2021'),
//               ),
//               DataColumn(
//                 label: Text('2022'),
//               ),
//             ],
//             rows: [
//               DataRow(cells: [
//                 DataCell(Text('TRABAJO')),
//                 DataCell(Text('368')),
//                 DataCell(Text('361')),
//                 DataCell(Text('347')),
//                 DataCell(Text('328')),
//               ]),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget bienestarWidget() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Container(
//         // color: Colors.red,
//         child: Column(
//           children: [
//             DataTable(
//               columns: [
//                 DataColumn(
//                   label: Container(
//                     // color: Colors.purple,
//                     child: Text('Año'),
//                   ),
//                 ),
//                 DataColumn(label: Container(width: 50, child: Text('2019'))),
//                 DataColumn(label: Container(width: 50, child: Text('2020'))),
//                 DataColumn(label: Container(width: 50, child: Text('2021'))),
//                 DataColumn(label: Container(width: 50, child: Text('2022'))),
//               ],
//               rows: [
//                 DataRow(cells: [
//                   DataCell(
//                     Container(
//                       // color: Colors.purple,
//                       // height: 100,
//                       width: 100,
//                       child: Text('Alumnos Beneficiados CTT1'),
//                     ),
//                   ),
//                   DataCell(Container(width: 30, child: Text('368'))),
//                   DataCell(Text('361')),
//                   DataCell(Text('347')),
//                   DataCell(Text('328')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Container(
//                       // color: Colors.purple,
//                       // height: 100,
//                       width: 100,
//                       child: Text('Alumnos Beneficiados CTT2'))),
//                   DataCell(Text('Valor 5')),
//                   DataCell(Text('Valor 6')),
//                   DataCell(Text('Valor 7')),
//                   DataCell(Text('Valor 8')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Container(
//                       // color: Colors.purple,
//                       // height: 100,
//                       width: 100,
//                       child: Text('Alumnos Beneficiados CTT3'))),
//                   DataCell(Text('Valor 9')),
//                   DataCell(Text('Valor 10')),
//                   DataCell(Text('Valor 11')),
//                   DataCell(Text('Valor 12')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Container(
//                       // color: Colors.purple,
//                       // height: 100,
//                       width: 100,
//                       child: Text('Alumnos Beneficiados CTT4'))),
//                   DataCell(Text('Valor 9')),
//                   DataCell(Text('Valor 10')),
//                   DataCell(Text('Valor 11')),
//                   DataCell(Text('Valor 12')),
//                 ]),
//               ],
//             ),
//             SizedBox(
//               height: 15,
//             )
//           ],
//         ),
//       ),
//     );

//     // Container(
//     //   child: Column(
//     //     children: [
//     //       Column(
//     //         crossAxisAlignment: CrossAxisAlignment.start,
//     //         mainAxisAlignment: MainAxisAlignment.start,
//     //         children: [
//     //           Text('Trabajo'),
//     //           Container(
//     //             height: 200,
//     //             width: 200,
//     //             color: Colors.pink,
//     //           )
//     //         ],
//     //       )
//     //     ],
//     //   ),
//     // );
//   }
// }

import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/ficha_options_page.dart';
import 'package:app_ciudadana/src/pages/modulos/ficha%20tecnica%20del%20inmueble/registro_ficha_tecnica.dart';
import 'package:app_ciudadana/src/pages/modulos/modulos_escuela/modulos_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FichaTecnicaPage extends StatefulWidget {
  const FichaTecnicaPage({super.key});

  @override
  State<FichaTecnicaPage> createState() => _FichaTecnicaPageState();
}

class _FichaTecnicaPageState extends State<FichaTecnicaPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Ficha Tecnica",
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => FichaOptionsPage()),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: 600,
                child: Container(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _auth.currentUser != null
                        ? FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(_auth.currentUser!.uid)
                            .collection('bienestarCTT')
                            .snapshots()
                        : const Stream.empty(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
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
                                      // color: Colors.red,
                                      height: 140,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(width: 25),
                                          Container(
                                            // height: 200,
                                            width: double.infinity,
                                            // color: Colors.red,
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 50,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Colors.red,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        // color: Colors.pink,
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                data['nivel']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                data['numCTT']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              'Matricula: ',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Text(
                                                            data['matricula']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              'Director(a): ',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
                                                            child: Text(
                                                              data['nombre']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              'Telefono:: ',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Text(
                                                            data['telefono']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                ),
              ),
              ///////////////0
              Container(
                height: 100,
                child: Text('hola'),
              ),
              Container(
                // color: Colors.purple,
                height: 200,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _auth.currentUser != null
                      ? FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(_auth.currentUser!.uid)
                          .collection('bienestarBecas')
                          .snapshots()
                      : const Stream.empty(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
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
                                  Center(
                                    child: Text(
                                      'La Escuela es Nuestra - Mejor Escuela',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 150,
                                    // color: Colors.pink,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: [
                                          DataTable(
                                            columns: [
                                              DataColumn(
                                                label: Text('Trabajo'),
                                              ),
                                              DataColumn(
                                                label: Text('2019'),
                                              ),
                                              DataColumn(
                                                label: Text('2020'),
                                              ),
                                              DataColumn(
                                                label: Text('2021'),
                                              ),
                                              DataColumn(
                                                label: Text('2022'),
                                              ),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(Text('TRABAJO')),
                                                DataCell(Text('')),
                                                DataCell(Text('')),
                                                DataCell(Container(
                                                    width: 70,
                                                    child: Text(
                                                        'Sillas, bancas y pupitres'))),
                                                DataCell(Text('')),
                                              ]),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
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
              ),
              Container(
                height: 100,
                child: Text('hola'),
              ),

              Container(
                color: Colors.red,
                height: 280,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _auth.currentUser != null
                      ? FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(_auth.currentUser!.uid)
                          .collection('bienestarBecas')
                          .snapshots()
                      : const Stream.empty(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
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
                                  DataTable(
                                    columns: [
                                      DataColumn(
                                        label: Container(
                                          // color: Colors.purple,
                                          child: Text('Año'),
                                        ),
                                      ),
                                      DataColumn(
                                          label: Container(
                                              width: 50, child: Text('2019'))),
                                      DataColumn(
                                          label: Container(
                                              width: 50, child: Text('2020'))),
                                      DataColumn(
                                          label: Container(
                                              width: 50, child: Text('2021'))),
                                      DataColumn(
                                          label: Container(
                                              width: 50, child: Text('2022'))),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(
                                          Container(
                                            // color: Colors.purple,
                                            // height: 100,
                                            width: 100,
                                            child: Text(
                                              data['nivel'].toString(),
                                            ),
                                          ),
                                        ),
                                        DataCell(Container(
                                            width: 30, child: Text('368'))),
                                        DataCell(Text('361')),
                                        DataCell(Text('347')),
                                        DataCell(Text('328')),
                                      ]),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 300,
              )

              // // Center(
              //   child: Text(
              //     'Bienestar para Niñas y niños, Mi Beca para',
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20),
              //   ),
              // ),
              // // SizedBox(height: 30),
              // Container(
              //   height: 300,
              //   // color: Colors.purple,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Container(
              //       // color: Colors.red,
              //       child: Column(
              //         children: [
              //           DataTable(
              //             columns: [
              //               DataColumn(
              //                 label: Container(
              //                   // color: Colors.purple,
              //                   child: Text('Año'),
              //                 ),
              //               ),
              //               DataColumn(
              //                   label:
              //                       Container(width: 50, child: Text('2019'))),
              //               DataColumn(
              //                   label:
              //                       Container(width: 50, child: Text('2020'))),
              //               DataColumn(
              //                   label:
              //                       Container(width: 50, child: Text('2021'))),
              //               DataColumn(
              //                   label:
              //                       Container(width: 50, child: Text('2022'))),
              //             ],
              //             rows: [
              //               DataRow(cells: [
              //                 DataCell(
              //                   Container(
              //                     // color: Colors.purple,
              //                     // height: 100,
              //                     width: 100,
              //                     child: Text('Alumnos Beneficiados CTT1'),
              //                   ),
              //                 ),
              //                 DataCell(
              //                     Container(width: 30, child: Text('368'))),
              //                 DataCell(Text('361')),
              //                 DataCell(Text('347')),
              //                 DataCell(Text('328')),
              //               ]),
              //               DataRow(cells: [
              //                 DataCell(Container(
              //                     // color: Colors.purple,
              //                     // height: 100,
              //                     width: 100,
              //                     child: Text('Alumnos Beneficiados CTT2'))),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //               ]),
              //               DataRow(cells: [
              //                 DataCell(Container(
              //                     // color: Colors.purple,
              //                     // height: 100,
              //                     width: 100,
              //                     child: Text('Alumnos Beneficiados CTT3'))),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //               ]),
              //               DataRow(cells: [
              //                 DataCell(Container(
              //                     // color: Colors.purple,
              //                     // height: 100,
              //                     width: 100,
              //                     child: Text('Alumnos Beneficiados CTT4'))),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //                 DataCell(Text('')),
              //               ]),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 15,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 30),
            ],
          ),
        ));
  }

  Widget myWidget1() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _auth.currentUser != null
          ? FirebaseFirestore.instance
              .collection('usuarios')
              .doc(_auth.currentUser!.uid)
              .collection('bienestarCTT')
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
                        // color: Colors.red,
                        height: 140,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(width: 25),
                            Container(
                              // height: 200,
                              width: double.infinity,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            // color: Colors.red,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          // color: Colors.pink,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  data['nivel'].toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  data['numCTT'].toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'Matricula: ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              data['matricula'].toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'Director(a): ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                data['nombre'].toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'Telefono:: ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              data['telefono'].toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
    );
  }
}
