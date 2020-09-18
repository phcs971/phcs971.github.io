import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import 'cubit/startup_cubit.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: StartupCubit(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200,
                child: Image.asset('assets/images/icon.png'),
              ),
              SizedBox(height: 25),
              LoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
