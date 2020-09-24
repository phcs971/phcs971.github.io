import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../components/components.dart';
import '../basepage/basepage.dart';
import 'componets/conquista_item.dart';
import 'cubit/conquistas_cubit.dart';

class ConquistasPage extends StatelessWidget {
  const ConquistasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConquistasCubit>(
      create: (context) => ConquistasCubit(),
      child: BlocBuilder<ConquistasCubit, ConquistasState>(
        builder: (context, state) {
          List<Widget> children;
          if (state is ConquistasInitial) {
            children = [LoadingSliver()];
          } else if (state is ConquistasLoaded) {
            final main = state.conquistas.where((c) => !c.isOther).toList();
            final other = state.conquistas.where((c) => c.isOther).toList();
            children = [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                sliver: SliverAppBar(
                  primary: false,
                  title: Text(
                    "Conquistas Principais",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    IconButton(
                      icon: Icon(Feather.refresh_cw, color: Theme.of(context).primaryColor),
                      onPressed: context.bloc<ConquistasCubit>().load,
                    )
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.extent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: main.map((c) => ConquistaItem(c)).toList(),
                ),
              ),
              if (other.isNotEmpty) ...[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  sliver: SliverAppBar(
                    primary: false,
                    title: Text(
                      "Outras Conquistas",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    backgroundColor: Colors.white,
                    actions: [
                      IconButton(
                        icon: Icon(Feather.refresh_cw, color: Theme.of(context).primaryColor),
                        onPressed: context.bloc<ConquistasCubit>().load,
                      )
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverGrid.extent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: other.map((c) => ConquistaItem(c)).toList(),
                  ),
                ),
              ]
            ];
          } else if (state is ConquistasError) {
            children = [ErrorSliver(state.message)];
          }
          return BasePage(children: children, index: 1);
        },
      ),
    );
  }
}
