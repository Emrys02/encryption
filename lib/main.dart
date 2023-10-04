import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final key = encrypt.Key.fromUtf8("qwertyuiopasdfghjklzxcvbnmkljhgf");
  final iv = encrypt.IV.fromUtf8("initialiaitiondf");
  String text = "This is the text";

  void _encrypt() {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    setState(() => text = encrypter.encrypt(text, iv: iv).base64);
  }

  void _decrypt() {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    setState(() => text = encrypter.decrypt64(text, iv: iv));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Text(text),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: text != "This is the text" ? null : _encrypt, child: const Text("Encrypt")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: text == "This is the text" ? null : _decrypt, child: const Text("Decrypt")),
          ],
        ),
      ),
    );
  }
}
