import 'package:imc_mobx/model/product.dart';
import 'package:mobx/mobx.dart';
part 'product_store.g.dart';

class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  @observable
  Product product;

  @observable
  bool selected;

  ProductStoreBase({
    required this.product,
    required this.selected,
  });
}
