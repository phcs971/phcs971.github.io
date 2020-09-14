import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';
import '../base.dart';
import '../../components/menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          Widget child;
          //TODO Home States and Pages
          if (state is HomeInitial) {
            child = Container(child: Text('Horario'));
          } else if (state is HomeCalendario) {
            child = Container(child: Text('Calendario'));
          } else if (state is HomeAnotacoes) {
            child = Container(child: Text('Anotacoes'));
          } else if (state is HomeDespezas) {
            child = Container(child: Text('Despezas'));
          } else if (state is HomeNotas) {
            child = Container(child: Text('Notas'));
          } else if (state is HomeObjetivos) {
            child = Container(child: Text('Objetivos'));
          } else if (state is HomeConta) {
            child = Container(child: Text('Conta'));
          } else if (state is HomeAjuda) {
            child = Container(child: Text('Ajuda'));
          } else if (state is HomeConfiguracoes) {
            child = Container(child: Text('Configuracoes'));
          }

          return ScreenTypeLayout(
            mobile: (context, information) {
              final key = GlobalKey<ScaffoldState>();
              return OrientationLayout(
                portrait: Scaffold(
                  key: key,
                  backgroundColor: Theme.of(context).backgroundColor,
                  drawer: Menu(),
                  body: Stack(
                    children: [
                      child,
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          icon: Icon(Icons.menu, size: 30),
                          onPressed: () => key.currentState.openDrawer(),
                        ),
                      ),
                    ],
                  ),
                ),
                landscape: Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: Row(children: [Menu(), Expanded(child: child)]),
                ),
              );
            },
            tablet: (context, information) {
              var children = [Expanded(child: child), Menu()];
              return OrientationLayout(
                portrait: Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: Column(children: children),
                ),
                landscape: Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: Row(children: children.reversed.toList()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
