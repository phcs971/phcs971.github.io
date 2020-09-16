import 'package:flutter/material.dart';

import '../locators.dart';

Future cannotLaunchUrl(BuildContext context) {
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Não Foi Possível Abrir o Link"),
      content: Text("Tente novamente! Se o erro persistir entre em contato: phcs.971@gmail.com"),
      actions: [
        FlatButton(
          child: Text('Ok'),
          onPressed: () => locator<NavigationService>().pop(),
        )
      ],
    ),
  );
}
