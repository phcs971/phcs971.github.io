import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portifolio/src/locators.dart';

class ErrorSliver extends StatelessWidget {
  final String message;
  const ErrorSliver(this.message);

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(child: ErroWidget(message));
}

class ErroWidget extends StatelessWidget {
  final String message;
  const ErroWidget(this.message, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 60),
          Icon(Entypo.emoji_sad, size: 100, color: Theme.of(context).primaryColor),
          SizedBox(height: 5),
          Text(
            "Oops!",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 48,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Um Erro Aconteceu!",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
          ),
          SizedBox(height: 5),
          Text(message),
          SizedBox(height: 5),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              "Voltar a Home",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
            ),
            onPressed: () => locator<NavigationService>().push(HomeRoute),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
