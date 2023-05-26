import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:imc_mobx/pages/observables/future/future_controller.dart';

class FuturePage extends StatefulWidget {
  const FuturePage({Key? key}) : super(key: key);

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  final _controller = FutureController();

  @override
  void initState() {
    super.initState();
    _controller.buscarNome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.buscarNome(),
        child: const Icon(Icons.add),
      ),
      body: Observer(
        builder: (_) {
          return FutureBuilder<String>(
            future: _controller.nomeFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const SizedBox.shrink();
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return Center(
                      child: Text(snapshot.data!),
                    );
                  }

                  return const Center(
                    child: Text('Nome não encontrado'),
                  );
              }
            },
          );
        },
      ),
    );
  }
}
