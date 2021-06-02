import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import 'cubit/startup_cubit.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: StartupCubit(),
      child: BlocBuilder<StartupCubit, StartupState>(
        builder: (context, state) {
          return Scaffold(
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
                  if (state is StartupLoading) LoadingWidget(),
                  if (state is StartupWaiting && !kIsWeb)
                    Container(
                      padding: EdgeInsets.only(top: 35, bottom: 25),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Theme.of(context).primaryColor),
                        ),
                        onPressed: () => context.read<StartupCubit>().login(),
                        child: Container(
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          child: Text(
                            "Entrar com Google",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
