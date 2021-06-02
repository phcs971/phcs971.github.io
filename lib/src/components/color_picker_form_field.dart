import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ColorPickerFormField extends StatelessWidget {
  final Function(Color?)? onSaved;
  final Color? initialValue;
  final String? title;
  const ColorPickerFormField({this.onSaved, this.initialValue, this.title});

  @override
  Widget build(BuildContext context) {
    return FormField<Color>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {
        if (v == null) return "Escolha uma Cor";
        return null;
      },
      onSaved: onSaved,
      initialValue: initialValue,
      builder: (field) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: ListTile(
            onTap: () async {
              final color = await colorPicker(context, field.value);
              if (color != null) field.didChange(color);
            },
            title: Text("$title:          #${field.value!.value.toRadixString(16).padLeft(8, '0')}"),
            trailing: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 17,
              child: CircleAvatar(backgroundColor: field.value, radius: 16),
            ),
          ),
        );
      },
    );
  }
}
