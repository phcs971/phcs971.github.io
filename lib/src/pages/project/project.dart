import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../locators.dart';
import '../../components/components.dart';
import '../base.dart';
import '../basepage/basepage.dart';
import 'components/project_text.dart';
import 'cubit/project_cubit.dart';
import 'components/gallery.dart';

class ProjectPage extends StatelessWidget {
  final String id;
  const ProjectPage(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      (context, info) => BlocProvider<ProjectCubit>(
        create: (context) => ProjectCubit(id),
        child: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {
            List<Widget> children;
            if (state is ProjectInitial) {
              children = [LoadingSliver()];
            } else if (state is ProjectLoaded) {
              bool fullScreen = info.localWidgetSize.width > 1000;

              children = [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      AppBar(
                        primary: false,
                        centerTitle: true,
                        elevation: 0,
                        backgroundColor: Colors.white,
                        iconTheme: IconThemeData(color: state.project.mainColor),
                        leading: IconButton(
                          icon: Icon(Icons.navigate_before),
                          tooltip: "Voltar",
                          onPressed: locator<NavigationService>().pop,
                        ),
                        title: Text(
                          state.project.title,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: state.project.mainColor,
                              ),
                        ),
                        actions: [Container()],
                      ),
                      if (fullScreen)
                        Row(children: [
                          SizedBox(width: 10),
                          GalleryWidget(state.project.gallery),
                          SizedBox(width: 10),
                          Expanded(child: ProjectText(state.project)),
                          SizedBox(width: 10),
                        ]),
                      if (!fullScreen) ...[
                        GalleryWidget(state.project.gallery),
                        Padding(
                          child: ProjectText(state.project),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        ),
                      ],
                    ],
                  ),
                ),
              ];
            } else if (state is ProjectError) {
              children = [ErrorSliver(state.message)];
            }
            return BasePage(children: children, index: -1);
          },
        ),
      ),
    );
  }
}
