import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/input.dart';
import 'package:remainder/ui/page_header.dart';
import 'package:remainder/ui/section_header.dart';
import 'package:remainder/utils.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Login Animation from RIVE
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.6,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final isLoggingIn = context.read<AppStore>().loginStore.isLoggingIn;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: "Login",
          ),
          InputWidget(
            onChange: context.read<AppStore>().loginStore.setUserMail,
            hintText: "Enter Email",
            type: TextInputType.emailAddress,
            disabled: isLoggingIn,
          ),
          InputWidget(
            onChange: context.read<AppStore>().loginStore.setPassword,
            hintText: "Enter Password",
            obscureText: true,
            disabled: isLoggingIn,
            type: TextInputType.visiblePassword,
          ),
          Observer(
            builder: (context) {
              final error = context.read<AppStore>().loginStore.error;
              if (error == null) {
                return const SizedBox();
              }
              return Text(
                error,
                style: GoogleFonts.quicksand(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: context.read<AppStore>().loginStore.logIn,
                  icon: isLoggingIn
                      ? const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(Icons.done_rounded),
                  label: isLoggingIn
                      ? const Text(
                          "Logging you in",
                        )
                      : const Text(
                          "Login",
                        ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
