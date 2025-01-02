import 'package:flutter/material.dart';
import 'package:helper/Screens/chat_Screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 18, 26),
      appBar: AppBar(
        title: const Text('Helper'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/chat_logo.jpg',
              width: 100,
              height: 100,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Center(
              child: Title(
                color: Colors.white,
                child: const Text(
                  'WELCOME TO HELPER',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(60),
            ),
            TextButton(
              style: TextButton.styleFrom(
                side: const BorderSide(
                  color: Colors.blue,
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatScreen()));
              },
              child: const Text('TRY HELPER'),
            ),
            const Padding(padding: EdgeInsets.all(20))
          ],
        ),
      ),
    );
  }
}
