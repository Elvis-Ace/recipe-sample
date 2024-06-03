import 'package:mobx/mobx.dart';
import 'package:recipe/basedata/formatter.dart';
import 'package:recipe/db/products.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  String total = "0";
  ObservableList<Product> cartItems = ObservableList<Product>();

  @action
  void addToCart(Product item) {
    var existingIndex = cartItems.indexWhere((itemm) => itemm.id == item.id);
    if (existingIndex == -1) {
      cartItems.add(item);
    }
    int tt = 0;
    for(int i = 0;i<cartItems.length;i++){
      tt += cartItems[i].price;
    }
    total = MyFormatter.formatNumber(tt.toString());
  }

  @action
  void removeFromCart(Product item) {
    cartItems.remove(item);
    int tt = 0;
    for(int i = 0;i<cartItems.length;i++){
      tt += cartItems[i].price;
    }
    total = MyFormatter.formatNumber(tt.toString());
  }

  @action
  void removeAll(){
    cartItems.clear();
    total = "0";
  }

}