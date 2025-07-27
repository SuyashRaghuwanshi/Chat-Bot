import 'package:flutter/material.dart';

class Authentification extends StatefulWidget {
  const Authentification({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AuthentificationState();
  }
}
class _AuthentificationState extends State<Authentification> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 18, 26),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/images/login.png', width: 300, height: 300),
            const Text(
              'BE A FRIEND OF MINE BY LOGIN',
              style: TextStyle(color: Colors.blue, fontSize: 25),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Email Address",
                  labelStyle: TextStyle(color: Colors.white)),
              controller: controller,
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white),
              ),
              controller: controller,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {},
                  child: const Text(
                    'Login!',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 20)),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {},
                  child: const Text(
                    'Signup!',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
