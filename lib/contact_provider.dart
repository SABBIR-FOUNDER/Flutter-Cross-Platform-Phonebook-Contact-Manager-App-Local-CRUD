



import 'package:flutter/cupertino.dart';
import 'package:phonebook/contact_model.dart';
import 'package:phonebook/database_helper.dart';


class ContactProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<Contact> _contacts = [];
  List<Contact> _favourites = [];
  bool _isLoading = false;
  String _searchQuery = '';


  List<Contact> get favourites => _favourites;

  List<Contact> get contacts => _contacts;

  bool get isLoading => _isLoading;

  String get searchQuery => _searchQuery;

  Future<void> loadContacts() async {
    //Load Contacts
    _isLoading = true;
    notifyListeners();

    try {
      _contacts = await _databaseHelper.getContacts();
      _favourites = _contacts
          .where((contact) => contact.isFavourite)
          .toList();
    }
    catch (e) {
      debugPrint('Error Loading Contacts : $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addContact(Contact contact) async {
    //Add  Contact
    try {
      await _databaseHelper.insertContact(contact);
      await loadContacts();
    } catch (e) {
      debugPrint('Error Adding Contact: $e');
    }
  }

  Future<void> updateContact(Contact contact) async {
    //Update existing Contact
    try {
      await _databaseHelper.updateContact(contact);
      await loadContacts();
    } catch (e) {
      debugPrint('Error updating contact: $e');
    }
  }

  //Delete contact

  Future<void> deleteConract(int id) async {
    try {
      await _databaseHelper.deleteContact(id);
      await loadContacts();
    } catch (e) {
      debugPrint('Error Deleting Contact: $e');
    }
  }

  Future<void> toogleFavourite(Contact contact) async {
    // Toggle favorite/unfavourite
    try {
      final newFavouriteStatus = !contact.isFavourite;
      await _databaseHelper.updateFavourite(
        contact.id!,
        newFavouriteStatus,
      );
      await loadContacts();
    } catch (e) {
      debugPrint('Error Updating Favourite: $e');
    }
  }

  Future<Contact?> getContactById(int id) async {
    // Get 1 contact by ID
    try {
      final contacts = await _databaseHelper.getContacts();
      for (final contact in contacts) {
        if (contact.id == id) {
          return contact;
        }
      }
    } catch (e) {
      debugPrint('Error Getting Contact: $e');
    }
    return null;
  }


//Name search
  Future<void> searchContacts(String query) async {
    _searchQuery = query.trim();

    if (_searchQuery.isEmpty) {
      await loadContacts();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      _contacts = await _databaseHelper.searchContacts(
        _searchQuery,
      );

      _favourites = _contacts
          .where((contact) => contact.isFavourite)
          .toList();
    } catch (e) {
      debugPrint('Error Searching Contacts: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

//Clear Search
  Future<void> clearSearch() async {
    _searchQuery = '';
    await loadContacts();
  }
}

