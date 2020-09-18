import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../locators.dart';
import '../models/models.dart';

void _pop([dynamic result]) => locator<NavigationService>().pop(result);

Future cannotLaunchUrl(BuildContext context) {
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Não Foi Possível Abrir o Link"),
      content: Text("Tente novamente! Se o erro persistir entre em contato: phcs.971@gmail.com"),
      actions: [FlatButton(child: Text('Ok'), onPressed: _pop)],
    ),
  );
}

Future dialogConquista(BuildContext context, Conquista conquista) {
  return showDialog(
    context: context,
    child: GestureDetector(
      onTap: _pop,
      child: AlertDialog(
        title: Center(child: Text(conquista.title)),
        content: Image.network(conquista.url),
        actions: [
          Center(
            child: Text(
              "${conquista.description} (${DateFormat("MM/yyyy").format(conquista.date)})",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}
