import 'package:flutter/material.dart';

void showCustomBottomSheet({
  required BuildContext context,
  Widget? widget,
  bool loading = false,
  Function()? onDone,
}) {
  showModalBottomSheet(
    // isScrollControlled: true,
    context: context,
    builder: (context) {
      return widget ?? const SizedBox();
    },
  );
}

void showCustomAlertDialog(
    {required BuildContext context,
    Widget? widget,
    Function()? onDone,
    bool loading = false}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, _, __) {
      return AlertDialog(
        content: widget,
        actions: [
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.close,
            ),
          ),
          loading
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: onDone,
                  icon: const Icon(
                    Icons.done,
                  ),
                )
        ],
      );
    },
  );
}
