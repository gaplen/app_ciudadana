// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class AgendarEvento extends StatefulWidget {
//   final DateTime firstDate;
//   final DateTime lastDate;
//   final DateTime? selectedDate;
//   const AgendarEvento(
//       {Key? key,
//       required this.firstDate,
//       required this.lastDate,
//       this.selectedDate})
//       : super(key: key);

//   @override
//   State<AgendarEvento> createState() => _AgendarEventoState();
// }

// class _AgendarEventoState extends State<AgendarEvento> {
//   late DateTime _selectedDate;
//   final _titleController = TextEditingController();
//   final _descController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = widget.selectedDate ?? DateTime.now();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Nuevo Evento"),
//         backgroundColor: Colors.purple.shade200,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           InputDatePickerFormField(
//             firstDate: widget.firstDate,
//             lastDate: widget.lastDate,
//             initialDate: _selectedDate,
//             onDateSubmitted: (date) {
//               print(date);
//               setState(() {
//                 _selectedDate = date;
//               });
//             },
//           ),
//           TextField(
//             controller: _titleController,
//             maxLines: 1,
//             decoration: const InputDecoration(labelText: 'Titulo'),
//           ),
//           TextField(
//             controller: _descController,
//             maxLines: 5,
//             decoration: const InputDecoration(labelText: 'Descripcion'),
//           ),
//           ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor:
//                   MaterialStateProperty.all(Colors.purple.shade200),
//             ),
//             onPressed: () {
//               _addEvent();
//               Navigator.pop(context);
//             },
//             child: const Text("Guardar"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _addEvent() async {
//     final title = _titleController.text;
//     final description = _descController.text;
//     if (title.isEmpty) {
//       print('title cannot be empty');
//       return;
//     }
//     await FirebaseFirestore.instance.collection('events').add({
//       "title": title,
//       "description": description,
//       "date": Timestamp.fromDate(_selectedDate),
//     });
//     if (mounted) {
//       Navigator.pop<bool>(context, true);
//     }
//   }
// }

import 'dart:collection';

import 'package:app_ciudadana/src/pages/modulos/calendario/add_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_ciudadana/src/models/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:app_ciudadana/src/widgets/event_item.dart';

class AgendarEvento extends StatefulWidget {
  // const AgendarEvento({super.key});

  @override
  State<AgendarEvento> createState() => _AgendarEventoState();
}

class _AgendarEventoState extends State<AgendarEvento> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: firstDay)
        .where('date', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day = DateTime.utc(
        event.date.year,
        event.date.month,
        event.date.day,
      );
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    setState(() {});
  }

  List<Event> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mi Calendario'),
        backgroundColor: Colors.purple.shade200,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              TextButton(onPressed: () {}, child: Text('ver')),
              TextButton(onPressed: () {}, child: Text('Bitacora')),
              TextButton(onPressed: () {}, child: Text('Especiales')),
              // TextButton(onPressed: () {
              //    Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (_) => AgendarEvento( firstDate: _firstDay,
              //     lastDate: _lastDay,
              //     selectedDate: _selectedDay,),
              //     ),
              //   );
              // }, child: Text('Agendar')),
            ],
          )
          // TableCalendar(
          //   eventLoader: _getEventsForTheDay,
          //   calendarFormat: _calendarFormat,
          //   onFormatChanged: (format) {
          //     setState(() {
          //       _calendarFormat = format;
          //     });
          //   },
          //   focusedDay: _focusedDay,
          //   firstDay: _firstDay,
          //   lastDay: _lastDay,
          //   onPageChanged: (focusedDay) {
          //     setState(() {
          //       _focusedDay = focusedDay;
          //     });
          //     _loadFirestoreEvents();
          //   },
          //   selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
          //   onDaySelected: (selectedDay, focusedDay) {
          //     print(_events[selectedDay]);
          //     setState(() {
          //       _selectedDay = selectedDay;
          //       _focusedDay = focusedDay;
          //     });
          //   },
          //   calendarStyle: const CalendarStyle(
          //     weekendTextStyle: TextStyle(
          //       color: Colors.red,
          //     ),
          //     selectedDecoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.purple,
          //     ),
          //   ),
          //   // calendarBuilders: CalendarBuilders(
          //   //   headerTitleBuilder: (context, day) {
          //   //     return Container(
          //   //       color: Colors.purple,
          //   //       padding: const EdgeInsets.all(8.0),
          //   //       // child: Text(day.toString()),
          //   //     );
          //   //   },
          //   // ),
          // ),
          // ..._getEventsForTheDay(_selectedDay).map(
          //   (event) => Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           color: Colors.purple.shade200,
          //         ),
          //         borderRadius: BorderRadius.circular(12.0),
          //       ),
          //       child: EventItem(
          //           event: event,
          //           onDelete: () async {
          //             final delete = await showDialog<bool>(
          //               context: context,
          //               builder: (_) => AlertDialog(
          //                 title: const Text("Eliminar Eveto?"),
          //                 content: const Text(
          //                     "Realmente quiere eliminar este evento?"),
          //                 actions: [
          //                   TextButton(
          //                     onPressed: () => Navigator.pop(context, false),
          //                     style: TextButton.styleFrom(
          //                       foregroundColor: Colors.red,
          //                     ),
          //                     child: const Text("No"),
          //                   ),
          //                   TextButton(
          //                     onPressed: () => Navigator.pop(context, true),
          //                     style: TextButton.styleFrom(
          //                       foregroundColor: Colors.green,
          //                     ),
          //                     child: const Text("Yes"),
          //                   ),
          //                 ],
          //               ),
          //             );
          //             if (delete ?? false) {
          //               await FirebaseFirestore.instance
          //                   .collection('events')
          //                   .doc(event.id)
          //                   .delete();
          //               _loadFirestoreEvents();
          //             }
          //           }),
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade200,
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => AddEvent(
                firstDate: _firstDay,
                lastDate: _lastDay,
                selectedDate: _selectedDay,
              ),
            ),

            // MaterialPageRoute(
            //   builder: (_) => AddEvent(),
            // ),
          );
          if (result ?? false) {
            _loadFirestoreEvents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
