import 'package:flutter/material.dart';

import '../contact_model.dart';

class ContactForm extends StatefulWidget {
  final Contact? contact;
  final String buttonText;

  // Keeps compatibility with the current Add Contact screen.
  final VoidCallback? onSave;

  // New callback that returns the completed Contact object.
  final ValueChanged<Contact>? onSubmit;

  const ContactForm({
    super.key,
    this.contact,
    required this.buttonText,
    this.onSave,
    this.onSubmit,
  });

  @override
  State<ContactForm> createState() => ContactFormState();
}

class ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.contact?.name ?? '',
    );

    phoneController = TextEditingController(
      text: widget.contact?.phone ?? '',
    );

    emailController = TextEditingController(
      text: widget.contact?.email ?? '',
    );

    addressController = TextEditingController(
      text: widget.contact?.address ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();

    super.dispose();
  }

  void submitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final contact = Contact(
      id: widget.contact?.id,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      isFavourite: widget.contact?.isFavourite ?? false,
    );

    // New preferred callback.
    widget.onSubmit?.call(contact);

    // Keeps compatibility with the old Add screen.
    if (widget.onSubmit == null) {
      widget.onSave?.call();
    }
  }

  String? validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Name is required';
    }

    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  String? validatePhone(String? value) {
    final phone = value?.trim() ?? '';

    if (phone.isEmpty) {
      return 'Phone number is required';
    }

    if (!RegExp(r'^\d+$').hasMatch(phone)) {
      return 'Phone number must contain only digits';
    }

    if (phone.length < 11) {
      return 'Phone number must be at least 11 digits';
    }

    return null;
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return null;
    }

    final emailPattern = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailPattern.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          12,
          16,
          24,
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),

            CircleAvatar(
              radius: 42,
              backgroundColor: Colors.deepPurple.shade50,
              child: Icon(
                Icons.camera_alt_outlined,
                size: 32,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 28),

            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              validator: validateName,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Name',
                prefixIcon: const Icon(
                  Icons.person_outline,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: validatePhone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Phone Number',
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Email',
                prefixIcon: const Icon(
                  Icons.email_outlined,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: addressController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Address',
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}