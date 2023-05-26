import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:imc_mobx/pages/observables/observable_model/observable_model_controller.dart';

class ObservableModelPage extends StatefulWidget {
  const ObservableModelPage({Key? key}) : super(key: key);

  @override
  State<ObservableModelPage> createState() => _ObservableModelPageState();
}

class _ObservableModelPageState extends State<ObservableModelPage> {
  final _controller = ObservableModelController();

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
                    final productStore = _controller.products[index];

                    return Observer(
                      builder: (_) {
                        return CheckboxListTile(
                          value: productStore.selected,
                          onChanged: (_) => _controller.changeSelection(index),
                          title: Text(productStore.product.name),
                        );
                      },
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
