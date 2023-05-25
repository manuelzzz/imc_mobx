import 'package:imc_mobx/model/product.dart';
import 'package:mobx/mobx.dart';
part 'observable_list_controller.g.dart';

class ObservableListController = ObservableListControllerBase
    with _$ObservableListController;

abstract class ObservableListControllerBase with Store {
  @observable
  var products = <Product>[].asObservable();

  @action
  void loadProducts() {
    var productsData = [
      Product(name: 'Computador'),
      Product(name: 'Celular'),
      Product(name: 'Teclado'),
      Product(name: 'Mouser'),
    ];

    products.addAll(productsData);
  }

  @action
  void addProduct() => products.add(Product(name: 'Computador 2'));

  @action
  void removeProduct() => products.removeAt(0);
}
