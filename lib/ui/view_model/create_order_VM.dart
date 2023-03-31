import 'package:CHATS_Vendor/core/models/product_model.dart';
import 'package:CHATS_Vendor/core/provider_model/base_provider_model.dart';
import 'package:CHATS_Vendor/ui/widgets/cart_items.dart';

class CreateOrderVM extends BaseProviderModel {
  List<ProductModel> _selectedProducts = <ProductModel>[];
  List<CartItem>? _cartItems;
  List<CartItem>? get cartItems {
    return _cartItems;
  }

  List<ProductModel> get finalCartItems {
    return _selectedProducts;
  }

  Future<void> selectProduct(ProductModel product) async {
    if (_selectedProducts.contains(product)) return;
    product.cost = product.cost == null ? 1 : product.cost;
    _selectedProducts.add(product);
    print({"Selected products", _selectedProducts});
    _cartItems = [];
    notifyListeners();

    _selectedProducts.forEach((product) {
      _cartItems?.add(
        CartItem(
          name: product.tag,
          qty: 1,
          amount: product.cost == null ? 1 : product.cost,
          onDelete: () {
            int idx = _selectedProducts.indexOf(product);
            print({
              "Deleting product from cart at index",
              idx,
              _selectedProducts.length
            });
            _selectedProducts.remove(product);
            _cartItems?.removeAt(idx == -1 ? 0 : idx);

            notifyListeners();
          },
          onQtyChange: (int? qty) {
            print({"Quantity increment called", qty});
            product.qty = qty;
            notifyListeners();
            // product.cost = (qty!.toDouble() * product.cost!);
          },
        ),
      );
    });
    // notifyListeners();
    print(_cartItems);
  }

  Future getCartItems() async {
    _cartItems!.isEmpty
        ? _selectedProducts.forEach((product) {
            _cartItems?.add(CartItem(
              name: product.tag,
              qty: 1,
              amount: product.cost,
              onDelete: () {
                int idx = _selectedProducts.indexOf(product);
                print({"Deleting product from cart at index", idx});
                _selectedProducts.remove(product);
                _cartItems?.removeAt(idx);

                notifyListeners();
              },
            ));
          })
        : print("There is already items in it");
    notifyListeners();
  }

  Future emptyCartItems() async {
    _cartItems?.clear();
    _selectedProducts.clear();
  }
}
