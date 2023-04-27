import 'dart:typed_data';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';

import '../database/helper/contacts_helper.dart';
import '../database/models/contact.dart';

class SosPage extends StatefulWidget {
  final ContactHelper contactHelper;
  const SosPage({super.key, required this.contactHelper});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  List<AppContact> contacts = [];

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  void getContacts() async {
    final contactsData = await widget.contactHelper.getAllContacts();
    setState(() {
      contacts = contactsData;
    });
  }

  void addContact() async {
    if (await FlutterContacts.requestPermission()) {
      final contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        widget.contactHelper
            .addContact(contact.displayName, contact.phones[0].number);
        getContacts();
      } else {
        print('Operation Rejected');
      }
    } else {
      print('Permission Rejected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("S.O.S"), actions: [
        IconButton(
          onPressed: () async {
            if (contacts.isNotEmpty) {
              List<String> recipents = [];
              contacts.forEach((contact) {
                recipents.add(contact.phone);
              });
              await sendSMS(
                  message: "I'm crashed , Pls help me ", recipients: recipents);
            }
          },
          icon: Icon(Icons.forward_to_inbox),
        ),
        IconButton(
          onPressed: () async {
            addContact();
          },
          icon: Icon(Icons.add),
        )
      ]
          // backgroundColor: Colors.deepPurple,
          ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          // Uint8List? imageBytes = contacts[index].photo;
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phone),

            // leading: imageBytes != null
            //     ? CircleAvatar(
            //         backgroundImage: MemoryImage(imageBytes),
            //       )
            //     : CircleAvatar(
            //         backgroundColor: Colors.white54,
            //       ),
          );
        },
        itemCount: contacts.length,
      ),
    );
  }
}
