import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../basepage/basepage.dart';
import 'components/project_item.dart';
import 'cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tick = 0;
  Timer timer;
  final k = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (k.currentState.isEndDrawerOpen) return;
      setState(() => tick++);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          List<Widget> children;
          if (state is HomeInitial) {
            children = [LoadingSliver()];
          } else if (state is HomeLoaded) {
            children = [
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.extent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: state.projects.map((p) => ProjectItem(p, tick)).toList(),
                ),
              ),
            ];
          } else if (state is HomeError) {
            children = [ErrorSliver(state.message)];
          }
          return BasePage(children: children, index: 0, scKey: k);
        },
      ),
    );
  }
}
