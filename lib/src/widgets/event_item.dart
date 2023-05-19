// import 'package:flutter/material.dart';
// // import 'package:flutterfire_samples/models/event.dart';
// import 'package:app_ciudadana/src/models/event.dart';

// import 'package:intl/intl.dart';

// class EventItem extends StatefulWidget {
//   final Event event;
//   final Function() onDelete;
//   final Function()? onTap;

//   const EventItem({
//     Key? key,
//     required this.event,
//     required this.onDelete,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   State<EventItem> createState() => _EventItemState();
// }

// class _EventItemState extends State<EventItem> {
//   final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
//   // DateTime _selectedDate = DateTime.now();
//   // DateTime day = DateTime.now();
//   // DateTime _selectedTime = DateTime.now();
//   // DateTime dateTime = DateTime.now();
//   // final DateFormat timeFormat = DateFormat('hh:mm a');

//   DateTime _selectedDate = DateTime.now();
//   DateTime day = DateTime.now();
//   DateTime _selectedTime = DateTime.now();
//   final DateFormat timeFormat = DateFormat('HH:mm');
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _selectedDate = widget.selectedDate ?? DateTime.now();

//     _selectedTime = timeFormat.parse(timeFormat.format(_selectedTime));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hora: ${timeFormat.format(_selectedTime) != null ? timeFormat.format(_selectedTime).toString() : "Sin hora"}',
//                   ),
//                   Text(
//                     'Fecha: ${dateFormat.format(_selectedDate) != null ? dateFormat.format(_selectedDate).toString() : "Sin fecha"}',
//                     // widget.event.dateTime.toString(),
//                   ),
//                   Text(
//                       'Titulo: ${widget.event.title != null ? widget.event.title.toString() : "Sin título"}'),
//                   Text(
//                       'Descripcion: ${widget.event.description != null ? widget.event.description.toString() : "Sin título"}'),
//                 ],
//               ),
//             ),
//             Spacer(),
//             IconButton(
//               icon: const Icon(
//                 Icons.delete,
//                 color: Colors.red,
//               ),
//               onPressed: widget.onDelete,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:app_ciudadana/src/models/event.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

class EventItem extends StatefulWidget {
  final Event event;
  final Function() onDelete;
  final Function()? onTap;

  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormat = DateFormat('HH:mm');

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Obtener los datos del documento
    FirebaseFirestore.instance
        .collection('eventos')
        .doc(widget.event.id)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        // El documento existe, obtener los datos
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          // Actualizar los valores de _selectedDate y _selectedTime
          _selectedDate = data['date'].toDate();
          _selectedTime = data['hora'].toDate();
        });
      } else {
        // El documento no existe
        // Manejar el caso de documento no encontrado
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Titulo: ${widget.event.title != null ? widget.event.title.toString() : "Sin título"}'),
                    Text(
                        'Descripcion: ${widget.event.description != null ? widget.event.description.toString() : "Sin título"}'),
                  ],
                ),
              ),
            ),
            Spacer(),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ],
    );
  }
}
