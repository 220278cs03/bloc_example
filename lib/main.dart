import 'package:bloc_lesson/main_cubit.dart';
import 'package:bloc_lesson/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'one_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Lesson',
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: const MyHomePage(title: 'Bloc Lesson'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("main build");
    return BlocListener<CounterCubit, MainState>(
      listenWhen: (prev, current){
        return prev.counter != current.counter || prev.name != current.name;
      },
  listener: (context, state) {
    if(state.counter == 5){
      showDialog(context: context, builder: (context){
        return const AlertDialog(
          title: Text("5"),
        );
      });
    }
    if(state.name == "Najot Ta'lim"){
      showDialog(context: context, builder: (context){
        return const AlertDialog(
          title: Text("Najot Ta'lim"),
        );
      });
    }
  },
  child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, MainState>(
              buildWhen: (prev, current){
                return current.counter != prev.counter;
              },
              builder: (context, state) {
                print("bloc build");
                return Text(
                 "${state.counter}"
                );
              },
            ),
            BlocBuilder<CounterCubit, MainState>(
              buildWhen: (prev, current){
                return current.name != prev.name;
              },
              builder: (context, state) {
                print("bloc build");
                return Text(
                    state.name
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<CounterCubit>().increment();
            },
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: TextFormField(
                      controller: name,
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<CounterCubit>().addName(name.text);
                            Navigator.pop(context);
                          },
                          child: const Text("Save"))
                    ],
                  ));
            },
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.ac_unit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<CounterCubit>(context),
                        child: const OnePage(),
                      )));
            },
          ),
        ],
      ),

    ),
);}
}
