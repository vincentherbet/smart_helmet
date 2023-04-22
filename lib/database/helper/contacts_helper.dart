import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

class ContactHelper {
  final Database db;
  const ContactHelper({required this.db});

  void addContact(String name, String number) async {
    await db.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO Contact(name,phone) VALUES(?,?)', [name, number]);
      print('inserted: $id');
    });
  }

  Future<List<AppContact>> getAllContacts() async {
    List<Map> contactsMap = await db.rawQuery('SELECT * FROM Contact');
    List<AppContact> contacts = [];
    for (var contact in contactsMap) {
      contacts.add(AppContact.fromJson(contact));
    }
    return contacts;
  }
}
