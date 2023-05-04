import 'package:app_ciudadana/src/pages/modulos/calendario/bitacora_add_page.dart';
import 'package:app_ciudadana/src/pages/modulos/calendario/edit_event.dart';
import 'package:app_ciudadana/src/pages/modulos/comite%20de%20bienestar/comite_edit_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class BitacoraScreen extends StatefulWidget {
  const BitacoraScreen({super.key});

  @override
  State<BitacoraScreen> createState() => _BitacoraScreenState();
}

class _BitacoraScreenState extends State<BitacoraScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  final _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  String _searchText = "";

  bool _showSearchBar = false;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final currentDateString = _dateFormat.format(currentDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
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
              : Center(child: Text("Bitacora")),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: _showSearchBar
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _showSearchBar = false;
                          _searchText = "";
                          _searchController.clear();
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
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
      //
      // AppBar(
      //   backgroundColor: Color(0xff59554e),
      //   title: Padding(
      //     padding: const EdgeInsets.only(right: 10),
      //     child: TextField(
      //       controller: _searchController,
      //       decoration: const InputDecoration(
      //         hintText: "Bitacora",
      //         border: InputBorder.none,
      //       ),
      //       onChanged: (value) {
      //         setState(() {
      //           _searchText = value;
      //         });
      //       },
      //     ),
      //   ),
      // ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff59554e),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => BitacoraAddPage()),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _auth.currentUser != null
            ? FirebaseFirestore.instance
                .collection('usuarios')
                .doc(_auth.currentUser!.uid)
                .collection('events')
                .where('title', isGreaterThanOrEqualTo: _searchText)
                .where('title', isLessThanOrEqualTo: _searchText + '\uf8ff')
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
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      data['date'].seconds * 1000);

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
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 12),
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xff59554e),
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage('assets/calendar.png'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Fecha    : ${_dateFormat.format(date)}',
                                            // data['nombreEscuela'].toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'Titulo  : ${data['title']}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'Descripcion: ${data['description']}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
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
                                              builder: (_) => BitacoraEditPage(
                                                data: data,
                                                escuelaId: data.id,
                                              ),
                                              //     EditComiteBienestar(
                                              //   data: data,
                                              //   escuelaId: data.id,
                                              // ),
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
