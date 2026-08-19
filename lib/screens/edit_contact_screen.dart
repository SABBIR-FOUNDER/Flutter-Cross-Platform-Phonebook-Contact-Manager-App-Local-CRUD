import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contact_model.dart';
import '../contact_provider.dart';
import '../widgets/contact_form.dart';

class EditContactScreen extends StatelessWidget {
  final Contact contact;

  const EditContactScreen({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Edit Contact',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ContactForm(
        contact: contact,
        buttonText: 'Update Contact',
        onSubmit: (updatedContact) async {
          await context
              .read<ContactProvider>()
              .updateContact(updatedContact);

          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}