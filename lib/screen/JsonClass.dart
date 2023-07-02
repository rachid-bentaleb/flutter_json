// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp1/model/Contact.dart';
import 'package:http/http.dart' as http;

class JsonClass extends StatefulWidget {
  @override
  State<JsonClass> createState() => _JsonClassState();
}

class _JsonClassState extends State<JsonClass> {
  @override
  static List<Contact> listC = [];
  static Iterable L = [];
  static List<Contact> P = [];

  Future<String> loadJson() async {
    return await rootBundle.loadString('lib/provider/file.json');
  }

  Future<void> afficherContact(String name) async {
    String data = await loadJson();
    L = json.decode(data);
    List<Contact> contactList = L
        .map((jsonObject) => Contact.fromJson(jsonObject))
        .where(
            (contact) => contact.firstname == name || contact.lastname == name)
        .toList();
    setState(() {
      listC = contactList;
      print(listC[0].lastname);
    });
  }

  /// a distanceL
  Future<void> loadJsonhttp() async {
    final rs = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/"));

    setState(() {
      L = json.decode(rs.body);
      //print(L.toString());
      P = List<Contact>.from(L.map((e) => Contact.fromJson(e)));

      print(P[4].firstname);
    });
  }

  TextEditingController SearchController = TextEditingController();

  Widget build(BuildContext context) {
    //loadJsonhttp();

    return Scaffold(
      appBar: AppBar(
        title: Text('Voitures'),
      ),
      body: Center(
        child: Column(
          children: [
            //Text(V[1].marque), Text(V[1].model.toString()),
            Container(
              margin: EdgeInsets.all(20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: SearchController,
                decoration: InputDecoration(
                  hintText: "search a contact",
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    afficherContact(SearchController.text);
                  });
                },
              ),
            ),

            if (listC.isNotEmpty)
              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      listC[0].firstname + " " + listC[0].lastname,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(listC[0].phone,
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  )
                ],
              ),

            if (listC.isEmpty && SearchController.text.isNotEmpty)
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text("Contact not found",
                    style: TextStyle(
                      fontSize: 16,
                    )),
              )
          ],
        ),
      ),
    );
  }
}
