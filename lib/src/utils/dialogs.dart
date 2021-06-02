import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

import '../locators.dart';
import '../models/models.dart';

void _pop([dynamic result]) => locator<NavigationService>().pop(result);

Future cannotLaunchUrl(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Não Foi Possível Abrir o Link"),
      content: Text("Tente novamente! Se o erro persistir entre em contato: phcs.971@gmail.com"),
      actions: [TextButton(child: Text('Ok'), onPressed: _pop)],
    ),
  );
}

Future dialogConquista(BuildContext context, Conquista conquista) {
  return showDialog(
    context: context,
    builder: (_) => GestureDetector(
      onTap: _pop,
      child: AlertDialog(
        title: Center(child: Text(conquista.title!)),
        content: Image.network(conquista.url!),
        actions: [
          Center(
            child: Text(
              "${conquista.description} (${DateFormat("MM/yyyy").format(conquista.date!)})",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}

Future<Color?> colorPicker(BuildContext context, Color? initialValue) async {
  Color? res = initialValue;
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Escolha uma Cor"),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: initialValue!,
          onColorChanged: (v) => res = v,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
          enableAlpha: true,
        ),
      ),
      actions: [
        TextButton(
            child: Text("Cancel", style: TextStyle(color: Colors.red)),
            onPressed: () {
              res = initialValue;
              locator<NavigationService>().pop();
            }),
        TextButton(child: Text("Ok"), onPressed: locator<NavigationService>().pop),
      ],
    ),
  );
  return res;
}
