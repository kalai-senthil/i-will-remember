import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      final isRegister = context.read<AppStore>().loginStore.isRegister;
      final isLoggingIn = context.read<AppStore>().loginStore.isLoggingIn;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PageHeader(
            title: isRegister ? "Register" : "Login",
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
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: isRegister
                      ? context.read<AppStore>().loginStore.register
                      : context.read<AppStore>().loginStore.logIn,
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
                      : Text(
                          isRegister ? "Register" : "Login",
                        ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: isLoggingIn
                ? null
                : context.read<AppStore>().loginStore.changeLoginType,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Register",
                style: GoogleFonts.quicksand(
                  color: Utils.darkPrimaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              "Continue with",
              style: GoogleFonts.quicksand(),
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                child: InkWell(
                  onTap: isLoggingIn
                      ? null
                      : context.read<AppStore>().loginStore.withGoogle,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: Utils.borderRadiusRoundedCard,
                      color: Utils.lightPrimaryColor,
                      boxShadow: Utils.cardBtnShadow,
                      border: Border.all(
                        color: Utils.darkPrimaryColor,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/google.svg",
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Google",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: InkWell(
                  onTap: isLoggingIn
                      ? null
                      : context.read<AppStore>().loginStore.withGithub,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: Utils.borderRadiusRoundedCard,
                      color: Utils.lightPrimaryColor,
                      boxShadow: Utils.cardBtnShadow,
                      border: Border.all(
                        color: Utils.darkPrimaryColor,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/github.svg",
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Github",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
