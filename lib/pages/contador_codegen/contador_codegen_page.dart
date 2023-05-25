// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:imc_mobx/pages/contador_codegen/contador_codegen_controller.dart';
import 'package:mobx/mobx.dart';

class ContadorCodegenPage extends StatefulWidget {
  const ContadorCodegenPage({Key? key}) : super(key: key);

  @override
  State<ContadorCodegenPage> createState() => _ContadorCodegenPageState();
}

class _ContadorCodegenPageState extends State<ContadorCodegenPage> {
  final controller = ContadorCodegenController();
  final reactionsDisposer = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();

    final autorunDisposer = autorun(
      (_) {
        if (kDebugMode) {
          print('---------------------- auto run ----------------------');
          print(controller.fullName.first);
          print(controller.fullName.last);
        }
      },
    );

    // na reaction o mobx só escuta o atributo observável que foi passado
    final reactionDisposer = reaction(
      (_) => controller.counter,
      (counter) {
        if (kDebugMode) {
          print('---------------------- reaction ----------------------');
          print(counter);
        }
      },
    );

    final whenDisposer = when(
      (_) => controller.fullName.first == 'Manel',
      () {
        if (kDebugMode) {
          print('---------------------- when ----------------------');
          print(controller.fullName.first);
        }
      },
    );

    reactionsDisposer
      ..add(autorunDisposer)
      ..add(reactionDisposer)
      ..add(whenDisposer);
  }

  @override
  void dispose() {
    super.dispose();

    reactionsDisposer.forEach((reaction) => reaction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador mobx codegen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) {
                return Text(
                  '${controller.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullName.first);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullName.last);
              },
            ),
            Observer(builder: (_) {
              return Text(controller.saudacao);
            }),
            TextButton(
              onPressed: () => controller.changeName(),
              child: const Text('Change name'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
