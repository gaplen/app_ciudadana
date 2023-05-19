import 'dart:collection';
import 'package:app_ciudadana/src/models/event.dart';
import 'package:app_ciudadana/src/pages/modulos/calendario/add_event_general.dart';
import 'package:app_ciudadana/src/widgets/event_item.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class CalendarioGeneral extends StatefulWidget {
  // const CaledarioPage({super.key});

  @override
  State<CalendarioGeneral> createState() => _CalendarioGeneralState();
}

class _CalendarioGeneralState extends State<CalendarioGeneral> {
  final _auth = FirebaseAuth.instance;
  late DateTime _focusedDay;

  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;

  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;
  final _firestore = FirebaseFirestore.instance;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      // hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = dateFormat.parse(dateFormat.format(_selectedDate));
    // DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final currentUser = _auth.currentUser;

    final snap = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(currentUser!.uid)
        .collection('eventos')
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
    setState(() {
      _selectedDay = _focusedDay;
    });
  }

  List<Event> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff59554e),
        centerTitle: true,
        title: const Text('Mi Calendario General'),
      ),

      body: ListView(
        children: [
          TableCalendar(
            eventLoader: _getEventsForTheDay,
            // calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                // _calendarFormat = format;
              });
            },
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              _loadFirestoreEvents();
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              print(_events[selectedDay]);
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              weekendTextStyle: TextStyle(color: Colors.pink.shade500),
              selectedDecoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.pink),
            ),
          ),
          ..._getEventsForTheDay(_selectedDay).map(
            (event) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple.shade200,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    EventItem(
                      event: event,

                      //Al presionar editar evento
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (_) => AddEventGeneral(
                        //         firstDate: _firstDay,
                        //         lastDate: _lastDay,
                        //         selectedDate: _selectedDay,
                        //       ),
                        //   ),
                        // );
                      },

                      //Boton de borrar evento
                      onDelete: () async {
                        final delete = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Eliminar Evento?"),

                            content: const Text(
                                "Realmente quiere eliminar este evento?"),

                            //Alerta de borrar evento
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.green,
                                ),
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                        if (delete ?? false) {
                          await FirebaseFirestore.instance
                              .collection('usuarios')
                              .doc(_auth.currentUser!.uid)
                              .collection('eventos')
                              .doc(event.id)
                              .delete();
                          _loadFirestoreEvents();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      //Boton para agregar evento
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff59554e),
        onPressed: () async {
          // _selectDate(context);
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => AddEventGeneral(
                firstDate: _firstDay,
                lastDate: _lastDay,
                selectedDate: _selectedDay,
              ),
            ),
          );
          if (result ?? false) {
            _loadFirestoreEvents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget myDrawer() {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: const <Widget>[
  //         DrawerHeader(
  //           decoration: BoxDecoration( color: Colors.pink ),
  //           child: Text('Calendario'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateFormat.parse(dateFormat.format(_selectedDate)),
      firstDate: DateTime(1900),
      // lastDate: DateTime.now(2100),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }

    final eventos = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('eventos')
        .where('date', isGreaterThanOrEqualTo: _selectedDate)
        .where('date', isLessThanOrEqualTo: _selectedDate)
        .get();
  }
}
