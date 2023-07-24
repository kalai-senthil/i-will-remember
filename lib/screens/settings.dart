import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: IconButton(
              onPressed: FirebaseAuth.instance.signOut,
              icon: const Icon(Icons.logout)),
        )
      ],
    );
  }
}
