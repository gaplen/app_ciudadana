import 'package:flutter/material.dart';
// import 'package:flutterfire_samples/models/event.dart';
import 'package:app_ciudadana/src/models/event.dart';

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
    return ListTile(
      title: Text(
        event.title,
        style: TextStyle(
          color: Colors.black,
          // fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        event.description.toString(),
        style: TextStyle(
          color: Colors.black,
          // fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: onDelete,
      ),
    );
  }
}
