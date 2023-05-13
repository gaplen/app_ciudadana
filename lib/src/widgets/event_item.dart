import 'package:flutter/material.dart';
// import 'package:flutterfire_samples/models/event.dart';
import 'package:app_ciudadana/src/models/event.dart';

import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final DateFormat timeFormat = DateFormat('hh:mm a');
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Hora: ${timeFormat.format(event.dateTime) != null ? timeFormat.format(event.dateTime).toString() : "Sin hora"}',
                  // ),
                  // Text(event.dateTime.toString()),
                  Text(
                      'Titulo: ${event.title != null ? event.title.toString() : "Sin título"}'),
                  Text(
                      'Descripcion: ${event.description != null ? event.description.toString() : "Sin título"}'),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ],
    );
  }
}
