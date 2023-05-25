import 'package:flutter/material.dart';
// import 'package:imc_mobx/contador/contador_page.dart';
// import 'package:imc_mobx/contador_codegen/contador_codegen_page.dart';
// import 'package:imc_mobx/pages/imc/imc_page.dart';
import 'package:imc_mobx/pages/observables/list/observable_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ObservableListPage(),
    );
  }
}
