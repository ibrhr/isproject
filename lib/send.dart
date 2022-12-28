import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isproject/DES/random_string.dart';

import 'DES/des.dart';
import 'appbar.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({Key? key}) : super(key: key);

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  String? message;
  bool is3DES = true;
  String dropdownButtonValue = '3DES';

  var firestoreDocument =
      FirebaseFirestore.instance.collection('Message').doc('Message');

  Future<void> send3DES(String message) async {
    RandomData rndData = RandomData();
    String key = rndData.getRandomString(24); // 24-byte
    List<int> iv = rndData.getRandomIntList(8);
    List<int> encrypted;

    print('key: $key');
    print('message: $message');

    DES3 des3CBC = DES3(key: key.codeUnits, mode: DESMode.CBC, iv: iv);
    encrypted = des3CBC.encrypt(message.codeUnits);

    await firestoreDocument.update({
      '3DES-Data': encrypted,
      '3DES-Key': key,
      '3DES-iv': iv,
    });
  }

  Future<void> sendDES(String message) async {
    RandomData rndData = RandomData();

    String key = rndData.getRandomString(8); // 8 byte
    List<int> iv = rndData.getRandomIntList(8);
    List<int> encrypted;
    print('key: $key');
    print('message: $message');
    DES desCBC = DES(key: key.codeUnits, mode: DESMode.CBC, iv: iv);
    encrypted = desCBC.encrypt(message.codeUnits);
    await firestoreDocument.update({
      'DES-Data': encrypted,
      'DES-Key': key,
      'DES-iv': iv,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Send Screen',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Send Encrypted Message'),
                onChanged: (value) => message = value,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (is3DES) {
                        await send3DES(message!);
                      } else {
                        await sendDES(message!);
                      }
                    },
                    child: const Text('Send'),
                  ),
                  DropdownButton(
                    value: dropdownButtonValue,
                    items: const [
                      DropdownMenuItem<String>(
                        value: '3DES',
                        child: Text(
                          '3DES - CBC Mode',
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'DES',
                        child: Text(
                          'DES - CBC Mode',
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropdownButtonValue = value!;
                        if (value == '3DES') {
                          is3DES = true;
                        } else {
                          is3DES = false;
                        }
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
