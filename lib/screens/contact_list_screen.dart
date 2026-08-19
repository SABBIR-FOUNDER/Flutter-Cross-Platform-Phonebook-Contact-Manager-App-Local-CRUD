import 'contact_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contact_provider.dart';
import '../widgets/contact_tile.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchContacts(String value) {
    context.read<ContactProvider>().searchContacts(value);
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<ContactProvider>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
          tooltip: 'Menu',
        ),

        title: const Text(
          'My Contacts',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(
                FocusNode(),
              );
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),

          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear_search') {
                _clearSearch();
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<String>(
                  value: 'clear_search',
                  child: Text('Clear Search'),
                ),
              ];
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              12,
              16,
              8,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _searchContacts,

              decoration: InputDecoration(
                hintText: 'Search contacts...',

                prefixIcon: const Icon(
                  Icons.search,
                  size: 21,
                ),

                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.close),
                )
                    : null,

                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
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
          ),

          Expanded(
            child: Consumer<ContactProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.contacts.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  onRefresh: provider.loadContacts,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    itemCount: provider.contacts.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 4);
                    },
                    itemBuilder: (context, index) {
                      final contact =
                      provider.contacts[index];

                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: ContactTile(
                          contact: contact,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactDetailsScreen(
                                  contact: contact,
                                ),
                              ),
                            );
                          },

                          onFavouriteTap: () {
                            provider.toogleFavourite(
                              contact,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,

        onPressed: () {
          debugPrint('Add Contact pressed');
        },

        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.contacts_outlined,
              size: 90,
              color: Colors.deepPurple.shade100,
            ),

            const SizedBox(height: 24),

            const Text(
              'No contacts yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Add your first contact by tapping '
                  'the + button below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}