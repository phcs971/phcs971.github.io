import 'package:flutter/material.dart';

class SwitchFormField extends StatelessWidget {
  final Function(bool) onSaved;
  final bool initialValue;
  final String title;
  const SwitchFormField({this.onSaved, this.initialValue, this.title});

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {
        if (v == null) return "Escolha a opção";
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
            title: Text("$title:"),
            trailing: Switch.adaptive(onChanged: field.didChange, value: field.value),
          ),
        );
      },
    );
  }
}
