import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testing_data_stream/bloc/counter_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final counterBloc = CounterBloc();

  @override
  void initState() {
    super.initState();
    print("cek initstate");
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding MyHomePage...");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder(
          stream: counterBloc.counterStream,
          builder: (counter, snapshot) {
            print("rebuild builder");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    "${snapshot.data ?? 0}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          }),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            counterBloc.eventSink.add(CounterEvent.Increment);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {
            counterBloc.eventSink.add(CounterEvent.Decrement);
          },
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }
}
