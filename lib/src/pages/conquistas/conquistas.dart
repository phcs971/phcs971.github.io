import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
            children = [
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.extent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: state.conquistas.map((c) => ConquistaItem(c)).toList(),
                ),
              ),
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
