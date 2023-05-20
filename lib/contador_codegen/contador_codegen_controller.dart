// ignore_for_file: library_private_types_in_public_api

import 'package:imc_mobx/model/full_name.dart';
import 'package:mobx/mobx.dart';

part 'contador_codegen_controller.g.dart';

class ContadorCodegenController = _ContadorCodegenControllerBase
    with _$ContadorCodegenController;

abstract class _ContadorCodegenControllerBase with Store {
  @observable
  var counter = 0;

  @observable
  var fullName = FullName(first: 'first', last: 'last');

  @computed
  String get saudacao => 'Olá ${fullName.first} ${counter * 2}';

  @action
  void increment() {
    counter++;
    fullName = fullName.copyWith(first: 'manuel', last: 'santos');
  }
}
