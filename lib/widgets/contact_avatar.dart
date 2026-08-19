import 'package:flutter/material.dart';

import '../contact_model.dart';

class ContactAvatar extends StatelessWidget {
  final Contact contact;
  final double radius;

  const ContactAvatar({
    super.key,
    required this.contact,
    this.radius = 24,
  });

  String _getInitials(String name) {
    final parts = name
        .trim()
        .split(' ')
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.deepPurple,
      child: Text(
        _getInitials(contact.name),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.65,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}