import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contact_provider.dart';
import '../widgets/contact_form.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

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
          'Add Contact',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ContactForm(
        buttonText: 'Save Contact',
        onSubmit: (contact) async {
          await context
              .read<ContactProvider>()
              .addContact(contact);

          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}