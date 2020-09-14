import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../utils/utils.dart';
import '../pages/base.dart';
import '../pages/home/cubit/home_cubit.dart';

class Menu extends StatelessWidget {
  //TODO Pages
  static List<OptionItens> pages = [
    OptionItens("Initial", SimpleLineIcons.home, HomeInitial()),
    OptionItens.divider(),
    OptionItens("Configurações", SimpleLineIcons.settings, HomeConfiguracoes()),
  ];
  @override
  Widget build(BuildContext context) {
    int dividers = pages.where((p) => p.isDivider).length;
    List<Widget> children = pages.map((p) => p.build(context)).toList(),
        cleanChildren = pages.where((p) => !p.isDivider).map((p) => p.build(context)).toList();
    return ScreenTypeLayout(
      mobile: (context, information) {
        bool hasOverflow =
            (dividers * 11 + (cleanChildren.length + 1) * 56) > information.screenSize.height;

        return Container(
          height: information.screenSize.height,
          width: information.orientation == Orientation.portrait ? 250 : 100,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [BoxShadow(blurRadius: 16, color: Colors.black12)],
          ),
          child: Column(
            children: [
              //Title
              Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  information.orientation == Orientation.portrait ? longAppName : shortAppName,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //Divider
              Container(
                color: Theme.of(context).dividerColor,
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              ),
              //Options
              Expanded(
                child: hasOverflow
                    ? SingleChildScrollView(child: Column(children: children))
                    : Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: children),
              ),
            ],
          ),
        );
      },
      tablet: (context, information) {
        if (information.orientation == Orientation.portrait) {
          bool hasOverflow = cleanChildren.length * 135 > information.screenSize.width;
          return Container(
            height: 125,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              boxShadow: [BoxShadow(blurRadius: 16, color: Colors.black12)],
            ),
            child: hasOverflow
                ? ListView(children: cleanChildren, scrollDirection: Axis.horizontal)
                : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: cleanChildren),
          );
        }

        bool hasOverflow =
            (dividers * 11 + (cleanChildren.length + 1) * 56) > information.screenSize.height;

        return Container(
          height: information.screenSize.height,
          width: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [BoxShadow(blurRadius: 16, color: Colors.black12)],
          ),
          child: Column(
            children: [
              //Title
              Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  longAppName,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //Divider
              Container(
                color: Theme.of(context).dividerColor,
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              ),
              //Options
              Expanded(
                child: hasOverflow
                    ? SingleChildScrollView(child: Column(children: children))
                    : Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: children),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OptionItens {
  final bool isDivider;
  final IconData icon;
  final String name;
  final HomeState state;

  const OptionItens.divider()
      : this.isDivider = true,
        this.icon = null,
        this.state = null,
        this.name = null;

  const OptionItens(this.name, this.icon, this.state) : this.isDivider = false;

  Widget build(BuildContext context) {
    if (isDivider)
      return Container(
        color: Theme.of(context).dividerColor,
        height: 1,
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      );
    void onPressed() => BlocProvider.of<HomeCubit>(context).setState(state);
    return ScreenTypeLayout(
      mobile: (context, information) {
        return FlatButton(
          onPressed: onPressed,
          child: information.orientation == Orientation.portrait
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 56,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(icon, size: 25),
                      SizedBox(width: 15),
                      Text(name, style: TextStyle(fontSize: 21))
                    ],
                  ),
                )
              : Container(height: 56, child: Icon(icon, size: 25)),
        );
      },
      tablet: (context, information) {
        if (information.orientation == Orientation.portrait) {
          return FlatButton(
            onPressed: onPressed,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 125,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(icon, size: 45),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    child: FittedBox(
                      child: Text(name, style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return FlatButton(
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 25),
                SizedBox(width: 15),
                Text(name, style: TextStyle(fontSize: 21))
              ],
            ),
          ),
        );
      },
    );
  }
}
