import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contact_model.dart';
import '../contact_provider.dart';

class DeleteContactDialog extends StatelessWidget {
  final Contact contact;

  const DeleteContactDialog({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Contact',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        'Are you sure you want to delete '
            '${contact.name}?',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),

        const SizedBox(width: 8),

        ElevatedButton(
          onPressed: () async {
            await context
                .read<ContactProvider>()
                .deleteConract(contact.id!);

            if (context.mounted) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}