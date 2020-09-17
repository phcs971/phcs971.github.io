import 'package:flutter/material.dart';

class LoadingSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(child: LoadingWidget());
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 35, bottom: 25),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
      );
}
