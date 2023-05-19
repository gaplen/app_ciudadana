import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroInmueble extends StatefulWidget {
  String idEscuela;
  RegistroInmueble({super.key, required this.idEscuela});

  @override
  _RegistroInmuebleState createState() => _RegistroInmuebleState();
}

class _RegistroInmuebleState extends State<RegistroInmueble> {
  final _formKey = GlobalKey<FormState>();
  String? idEscuela;
  String? cuadrante;
  String? plantel;
  String? escuela;
  String? turno;
  String? ctt;
  String? matricula;
  String? director;
  String? telefono;
  String? escuelaA;
  String? escuelaB;
  String? escuelaC;
  String? escuelaD;
  String? escuelaE;
  String? bienestarA;
  String? bienestarB;
  String? bienestarC;
  String? bienestarD;
  String? bienestarE;
  String? promedio;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    idEscuela = widget.idEscuela;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro Inmueble')),
      body: Container(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const Text('Datos Generales',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                //Registro del Cuadrante
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    onChanged: (value) {
                      cuadrante = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Cuadrante',
                      hintText: 'Ingrese el cuadrante. Ej. IZP00',
                    ),
                  ),
                ),

                //Registro del plantel
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Plantel',
                      hintText: 'Ingrese el número del Plantel',
                    ),
                    //Asignar dato
                    onChanged: (value) {
                      plantel = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro de al escuela
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    onChanged: (value) {
                      escuela = value;
                    },
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Escuela',
                      hintText: 'Ingrese el nombre de la escuela',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Registro del turno
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Turno',
                      hintText: 'Ingrese el turno',
                    ),
                    onChanged: (value) {
                      turno = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),
                const Text('Datos de la Escuela',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                //Registro del CTT
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'CTT',
                      hintText: 'Ingresa el CTT',
                    ),
                    onChanged: (value) {
                      ctt = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro de la matricula
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Matrícula',
                      hintText: 'Ingresa la Matrícula',
                    ),
                    onChanged: (value) {
                      matricula = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro del director
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Director',
                      hintText: 'Ingresa el nombre del director',
                    ),
                    onChanged: (value) {
                      director = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro del telefono
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      hintText: 'Ingresa el número de Teléfono',
                    ),
                    onChanged: (value) {
                      telefono = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),
                const Text('La Escuela es Nuestra - Mejor Escuela',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                //Registro del 2019
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'A. 2019',
                      hintText: 'Ingresa los datos del 2019',
                    ),
                    onChanged: (value) {
                      escuelaA = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro del 2020
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'B. 2020',
                      hintText: 'Ingresa los datos del 2020',
                    ),
                    onChanged: (value) {
                      escuelaB = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro del 2021
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'C. 2021',
                      hintText: 'Ingresa los datos del 2021',
                    ),
                    onChanged: (value) {
                      escuelaC = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro del 2022
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'D. 2022',
                      hintText: 'Ingresa los datos del 2022',
                    ),
                    onChanged: (value) {
                      escuelaD = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro del 2023
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'E. 2023',
                      hintText: 'Ingresa los datos del 2023',
                    ),
                    onChanged: (value) {
                      escuelaE = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),
                const Text('Bienestar para Niñas y Niños, Mi Beca para Empezar',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Text('Becas entregadas por año en el inmueble',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: 20),

                //Registro bienestar del 2019
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'A. 2019',
                      hintText: 'Ingresa los datos del 2019',
                    ),
                    onChanged: (value) {
                      bienestarA = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro bienestar del 2020
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'B. 2020',
                      hintText: 'Ingresa los datos del 2020',
                    ),
                    onChanged: (value) {
                      bienestarB = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro bienestar del 2021
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'C. 2021',
                      hintText: 'Ingresa los datos del 2021',
                    ),
                    onChanged: (value) {
                      bienestarC = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro bienestar del 2022
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'D. 2022',
                      hintText: 'Ingresa los datos del 2022',
                    ),
                    onChanged: (value) {
                      bienestarD = value;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                //Registro bienestar del 2023
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'E. 2023',
                      hintText: 'Ingresa los datos del 2023',
                    ),
                    onChanged: (value) {
                      bienestarE = value;
                    },
                  ),
                ),

                const SizedBox(height: 40),

                //Registro del promedio
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextField(
                    //teclado numerico
                    keyboardType: TextInputType.number,
                    //Diseño del input
                    decoration: InputDecoration(
                      labelText: 'Promedio',
                      hintText: 'Ingresa el promedio',
                    ),
                    onChanged: (value) {
                      promedio = value;
                    },
                  ),
                ),

                const SizedBox(height: 40),

                //Boton de guardar
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = await _auth.currentUser;

                        if (user != null) {
                          final data = {
                            'cuadrante': cuadrante,
                            'plantel': plantel,
                            'escuela': escuela,
                            'turno': turno,
                            'ctt': ctt,
                            'matricula': matricula,
                            'director': director,
                            'telefono': telefono,
                            'escuelaA': escuelaA,
                            'escuelaB': escuelaB,
                            'escuelaC': escuelaC,
                            'escuelaD': escuelaD,
                            'escuelaE': escuelaE,
                            'bienestarA': bienestarA,
                            'bienestarB': bienestarB,
                            'bienestarC': bienestarC,
                            'bienestarD': bienestarD,
                            'bienestarE': bienestarE,
                            'promedio': promedio,
                          };

                          await _firestore
                              .collection('usuarios')
                              .doc(user.uid)
                              .collection('escuelas')
                              .doc(idEscuela)
                              .collection('fichaInmueble')
                              .add(data);

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Formulario agregado correctamente')),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },

                    //Estilo/Diseño de boton
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      elevation: 0,
                      shadowColor: Colors.pink.shade900,
                    ),

                    child: const Text('Agregar'),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
