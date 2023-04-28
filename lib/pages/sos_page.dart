import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:location/location.dart';

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
  Location location = Location();
  late LocationData locationData;

  @override
  void initState() {
    super.initState();
    getContacts();
    getLocation();
  }

  void getLocation() async {
    locationData = await location.getLocation();
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
        // print('Operation Rejected');
      }
    } else {
      // print('Permission Rejected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("S.O.S"), actions: [
        IconButton(
          onPressed: () async {
            String gMapUrl =
                "https://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";
            if (contacts.isNotEmpty) {
              List<String> recipents = [];
              for (var contact in contacts) {
                recipents.add(contact.phone);
              }
              await sendSMS(
                message: "I'm crashed , Pls help me My Location is $gMapUrl",
                recipients: recipents,
              );
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
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phone),
          );
        },
        itemCount: contacts.length,
      ),
    );
  }
}
