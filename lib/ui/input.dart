import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.hintText,
    required this.onChange,
    this.type = TextInputType.text,
    this.textEditingController,
    this.isDense = false,
    this.autoFocus = false,
    this.disabled = false,
    this.obscureText = false,
  });
  final String hintText;
  final bool obscureText;
  final bool disabled;
  final bool isDense;
  final bool autoFocus;
  final TextInputType type;
  final Function(String d) onChange;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      onChanged: onChange,
      enabled: !disabled,
      obscureText: obscureText,
      autofocus: autoFocus,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: isDense,
      ),
    );
  }
}
