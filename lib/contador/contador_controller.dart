// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

class ContadorController {
  final _counter = Observable<int>(0);
  final _fullName = Observable<FullName>(
    FullName(first: 'first', last: 'last'),
  );
  late Action increment;
  late Computed _saudacaoComputed;

  ContadorController() {
    increment = Action(_incrementCounter);
    _saudacaoComputed = Computed(
      () => 'Olá ${_fullName.value.first} ${_counter.value}',
    );
  }

  FullName get fullName => _fullName.value;
  int get counter => _counter.value;

  String get saudacao => _saudacaoComputed.value;

  void _incrementCounter() {
    _counter.value++;
    // ! Neste caso, não vai recompilar os valores por não serem alterados
    // _fullName.value.first = 'Manuel';
    // _fullName.value.last = 'Santos';

    // ! Opção 1 alterar por meio de prototype (copyWith)
    // ! Trocar isso:
    // _fullName.value = FullName(first: 'Manuel', last: 'Santos');

    // ! Por:
    _fullName.value = _fullName.value.copyWith(first: 'Manuel', last: 'Santos');
  }
}

class FullName {
  String first;
  String last;

  FullName({
    required this.first,
    required this.last,
  });

  FullName copyWith({
    String? first,
    String? last,
  }) {
    return FullName(
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }
}
