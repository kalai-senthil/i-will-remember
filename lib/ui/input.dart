import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.hintText,
    required this.onChange,
    this.type = TextInputType.text,
    this.textEditingController,
    this.disabled = false,
    this.obscureText = false,
  });
  final String hintText;
  final bool obscureText;
  final bool disabled;
  final TextInputType type;
  final Function(String d) onChange;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: type,
        onChanged: onChange,
        enabled: !disabled,
        obscureText: obscureText,
        controller: textEditingController,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
