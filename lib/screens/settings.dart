import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/info_show_with_icon.dart';
import 'package:remainder/ui/section_header.dart';
import 'package:remainder/utils.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Utils.pagePadding,
        child: Observer(builder: (context) {
          final user = context.read<AppStore>().user!;
          return Column(
            children: [
              const SectionHeader(
                title: "Settings",
              ),
              InfoShowWithIcon(
                icon: const Icon(Icons.account_circle_rounded),
                info: "Name",
                child: Text(
                  "${user.displayName}",
                ),
              ),
              InfoShowWithIcon(
                icon: const Icon(Icons.alternate_email_rounded),
                info: "Email",
                child: Text(
                  "${user.email}",
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: FirebaseAuth.instance.signOut,
                      icon: const Icon(Icons.logout),
                      label: const Text(
                        "Log Out",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
