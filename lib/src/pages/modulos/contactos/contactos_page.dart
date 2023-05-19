import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactosPage extends StatefulWidget {
  const ContactosPage({super.key});

  @override
  State<ContactosPage> createState() => _ContactosPageState();
}

class _ContactosPageState extends State<ContactosPage> {
  final Uri _url = Uri.parse('https://flutter.dev');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";

  bool _showSearchBar = false;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              : Text("Contactos"),
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _auth.currentUser != null
            ? FirebaseFirestore.instance
                .collection('usuarios')
                .doc(_auth.currentUser!.uid)
                .collection('contactos')
                .where('nombreContacto', isGreaterThanOrEqualTo: _searchText)
                .where('nombreContacto',
                    isLessThanOrEqualTo: _searchText + '\uf8ff')
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
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            color: Color(0xffe2e3d9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(width: 25),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xff59554e),
                                      backgroundImage:
                                          AssetImage('assets/contactos.png'),
                                      child: Container(),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    // color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Text(
                                          data['nombreContacto'].toString() !=
                                                  null
                                              ? data['nombreContacto']
                                                  .toString()
                                              : 'Sin nombre',
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Text(
                                          data['correoElectronico']
                                                      .toString() !=
                                                  null
                                              ? data['correoElectronico']
                                                  .toString()
                                              : 'Sin correo',
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Text(
                                          data['telefono'].toString() != null
                                              ? data['telefono'].toString()
                                              : 'Sin teléfono',
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    // color: Colors.red,
                                  ),
                                  Spacer(),
                                  /////////
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            final url =
                                                'tel:${data['telefono']}';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'No se pudo realizar la llamada: $url';
                                            }
                                          },
                                          icon: const Icon(Icons.phone),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            final telefono = data['telefono'];
                                            final mensaje =
                                                'Hola, ¿cómo estás?';
                                            final url =
                                                'https://wa.me/$telefono/?text=${Uri.parse(mensaje)}';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'No se pudo abrir WhatsApp: $url';
                                            }
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.whatsapp,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
