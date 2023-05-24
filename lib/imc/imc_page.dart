import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:imc_mobx/imc/imc_controller.dart';
import 'package:imc_mobx/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final _controller = ImcController();
  final _pesoEC = TextEditingController();
  final _alturaEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final reactionDisposer = <ReactionDisposer>[];
  var imc = 0.0;

  @override
  void initState() {
    super.initState();

    final reactionErrorDisposer =
        reaction<bool>((_) => _controller.hasError, (hasError) {
      if (hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_controller.error ?? 'Erro ao verificar o IMC!'),
          ),
        );
      }
    });

    reactionDisposer.add(reactionErrorDisposer);
  }

  @override
  void dispose() {
    super.dispose();
    _pesoEC.dispose();
    _alturaEC.dispose();
    // ignore: avoid_function_literals_in_foreach_calls
    reactionDisposer.forEach((reactionDisposer) => reactionDisposer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC setState'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Observer(
                  builder: (_) {
                    return ImcGauge(
                      imc: _controller.imc,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Peso'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Peso obrigatório";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Altura'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Altura obrigatória";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    var formValid = _formKey.currentState?.validate() ?? false;

                    if (formValid) {
                      var formatter = NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                      );
                      double peso = formatter.parse(_pesoEC.text) as double;
                      double altura = formatter.parse(_alturaEC.text) as double;

                      _controller.calcularImc(peso: peso, altura: altura);
                    }
                  },
                  child: const Text('Calcular IMC'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
