import 'package:bloc_lesson/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_state.dart';

class OnePage extends StatelessWidget {
  const OnePage({Key? key,BuildContext? context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, MainState>(
              buildWhen: (prev, current) {
                return current.counter != prev.counter;
              },
              builder: (context, state) {
                print("bloc build counter");
                return Text(
                  '${state.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            BlocBuilder<CounterCubit, MainState>(
              buildWhen: (prev, current) {
                return current.name != prev.name;
              },
              builder: (context, state) {
                print("bloc build name");
                return Text(
                  state.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}