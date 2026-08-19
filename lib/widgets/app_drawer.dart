import 'package:flutter/material.dart';

import '../screens/about_screen.dart';
import '../screens/add_contact_screen.dart';
import '../screens/contact_list_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                24,
                30,
                24,
                24,
              ),
              color: Colors.deepPurple,
              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.contacts,
                      size: 32,
                      color: Colors.deepPurple,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'My Contacts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    'Manage your friends easily',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            _buildDrawerItem(
              context,
              Icons.contacts_outlined,
              'My Contacts',
                  () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const ContactListScreen(),
                  ),
                );
              },
            ),

            _buildDrawerItem(
              context,
              Icons.star_outline,
              'Favourites',
                  () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const FavoritesScreen(),
                  ),
                );
              },
            ),

            _buildDrawerItem(
              context,
              Icons.person_add_outlined,
              'Add Contact',
                  () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const AddContactScreen(),
                  ),
                );
              },
            ),

            _buildDrawerItem(
              context,
              Icons.info_outline,
              'About App',
                  () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const AboutScreen(),
                  ),
                );
              },
            ),

            _buildDrawerItem(
              context,
              Icons.settings_outlined,
              'Settings',
                  () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context,
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.deepPurple,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: onTap,
    );
  }
}