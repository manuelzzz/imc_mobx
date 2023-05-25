import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:imc_mobx/pages/observables/list/observable_list_controller.dart';

class ObservableListPage extends StatefulWidget {
  const ObservableListPage({Key? key}) : super(key: key);

  @override
  State<ObservableListPage> createState() => _ObservableListPageState();
}

class _ObservableListPageState extends State<ObservableListPage> {
  final _controller = ObservableListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: _controller.products.length,
                  itemBuilder: (context, index) {
                    final productName = _controller.products[index].name;

                    return CheckboxListTile(
                      value: false,
                      onChanged: (_) {},
                      title: Text(productName),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => _controller.addProduct(),
                child: const Text('Adicionar'),
              ),
              TextButton(
                onPressed: () => _controller.removeProduct(),
                child: const Text('Remover'),
              ),
              TextButton(
                onPressed: () => _controller.loadProducts(),
                child: const Text('Carregar'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
