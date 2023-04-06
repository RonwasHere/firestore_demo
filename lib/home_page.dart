import 'package:firestore_demo/read%20data/get_user_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_demo/main_page.dart';
import 'package:firestore_demo/home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //list
  List<String> docIDs = [];

  //document id
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        //orderby, untuk mengurutkan data berdsrkan age dari terkecil ke besar
        .orderBy('age', descending: false)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('=========='),
              SizedBox(height: 30),
              //list untuk menapilkan data (READ)
              Expanded(
                child: FutureBuilder(
                  future: getDocId(),
                  builder: ((context, snapshot) {
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: GetUserName(documentId: docIDs[index]),
                            tileColor: Colors.grey[200],
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
