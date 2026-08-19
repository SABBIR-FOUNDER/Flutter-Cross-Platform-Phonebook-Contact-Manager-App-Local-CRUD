import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider =
    context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Appearance',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),

          const SizedBox(height: 8),

          Card(
            elevation: 0,
            child: SwitchListTile(
              value: themeProvider.isDarkMode,

              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },

              secondary: Icon(
                themeProvider.isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: Colors.deepPurple,
              ),

              title: const Text(
                'Dark Mode',
              ),

              subtitle: Text(
                themeProvider.isDarkMode
                    ? 'Dark theme is enabled'
                    : 'Light theme is enabled',
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Application',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),

          const SizedBox(height: 8),

          Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.info_outline,
                    color: Colors.deepPurple,
                  ),
                  title: const Text(
                    'About App',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/about',
                    );
                  },
                ),

                const Divider(height: 1),

                const ListTile(
                  leading: Icon(
                    Icons.apps_outlined,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'Version',
                  ),
                  trailing: Text(
                    '1.0.0',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
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