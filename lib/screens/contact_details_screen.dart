import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contact_model.dart';
import '../contact_provider.dart';
import '../widgets/contact_avatar.dart';
import '../widgets/delete_contact_dialog.dart';
import 'edit_contact_screen.dart';

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailsScreen({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Contact Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditContactScreen(
                    contact: contact,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Contact',
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return DeleteContactDialog(
                    contact: contact,
                  );
                },
              );
            },
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete Contact',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            ContactAvatar(
              contact: contact,
              radius: 52,
            ),

            const SizedBox(height: 16),

            Text(
              contact.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              contact.phone,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 28),

            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
              child: Column(
                children: [
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    title: 'Phone Number',
                    value: contact.phone,
                  ),

                  if (contact.email.isNotEmpty)
                    _buildInfoRow(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value: contact.email,
                    ),

                  if (contact.address.isNotEmpty)
                    _buildInfoRow(
                      icon: Icons.location_on_outlined,
                      title: 'Address',
                      value: contact.address,
                      isLast: true,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await context
                      .read<ContactProvider>()
                      .toogleFavourite(contact);
                },
                icon: Icon(
                  contact.isFavourite
                      ? Icons.star
                      : Icons.star_border,
                ),
                label: Text(
                  contact.isFavourite
                      ? 'Remove from Favourites'
                      : 'Add to Favourites',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                  side: const BorderSide(
                    color: Colors.deepPurple,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.deepPurple,
              size: 20,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}