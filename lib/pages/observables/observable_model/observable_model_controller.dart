import 'package:imc_mobx/model/product.dart';
import 'package:imc_mobx/pages/observables/observable_model/model/product_store.dart';
import 'package:mobx/mobx.dart';
part 'observable_model_controller.g.dart';

class ObservableModelController = ObservableModelControllerBase
    with _$ObservableModelController;

abstract class ObservableModelControllerBase with Store {
  @observable
  var products = <ProductStore>[].asObservable();

  @action
  void loadProducts() {
    var productsData = [
      ProductStore(product: Product(name: 'Computador'), selected: false),
      ProductStore(product: Product(name: 'Celular'), selected: false),
      ProductStore(product: Product(name: 'Teclado'), selected: false),
      ProductStore(product: Product(name: 'Mouse'), selected: false),
    ];

    products.addAll(productsData);
  }

  @action
  void addProduct() => products.add(
        ProductStore(product: Product(name: 'Computador 2'), selected: false),
      );

  @action
  void removeProduct() => products.removeAt(0);

  @action
  void changeSelection(int index) {
    products[index].selected = !products[index].selected;
  }
}
