import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isproject/appbar.dart';

import 'DES/des.dart';

class RecieveScreen extends StatelessWidget {
  const RecieveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Recieve Screen'),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Message')
            .doc('Message')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //// 3DES begin
          List<dynamic> TriDESencrypted = snapshot.data!['3DES-Data'];

          List<dynamic> TriDESiv = snapshot.data!['3DES-iv'];

          String TriDESkey = snapshot.data!['3DES-Key'];

          DES3 des3CBC = DES3(
              key: TriDESkey.codeUnits,
              mode: DESMode.CBC,
              iv: TriDESiv.cast<int>());

          List<int> TriDESdecrypted =
              des3CBC.decrypt(TriDESencrypted.cast<int>());
          //// 3DES end

          /// DES begin
          List<dynamic> DESencrypted = snapshot.data!['DES-Data'];

          List<dynamic> DESiv = snapshot.data!['DES-iv'];

          String DESkey = snapshot.data!['DES-Key'];

          DES desCBC = DES(
              key: DESkey.codeUnits,
              mode: DESMode.CBC,
              iv: DESiv.cast<int>());

          List<int> DESdecrypted = desCBC.decrypt(DESencrypted.cast<int>());

          /// DES end
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '3DES - CBC Mode :  ${utf8.decode(TriDESdecrypted)}',
                  style:
                      const TextStyle(color: Colors.deepPurple, fontSize: 32),
                ),
                Text(
                  'DES - CBC Mode :  ${utf8.decode(DESdecrypted)}',
                  style:
                      const TextStyle(color: Colors.deepPurple, fontSize: 32),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
