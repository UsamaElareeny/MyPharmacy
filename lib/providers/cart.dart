import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final String pharmacyID;
  final String pharmacyName;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.pharmacyID,
    @required this.pharmacyName,
  });
  @override
  String toString() {
    // TODO: implement toString
    return 'id:$id \n title:$title \n quantity:$quantity \n price:$price \n pharmacyID:$pharmacyID \n pharmacyName:$pharmacyName';
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
    String pharmacyID,
    String pharmacyName,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          pharmacyName: pharmacyName,
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          pharmacyID: existingCartItem.pharmacyID,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          pharmacyName: pharmacyName,
          id: productId,
          title: title,
          price: price,
          pharmacyID: pharmacyID,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                pharmacyName: existingCartItem.pharmacyName,
                pharmacyID: existingCartItem.pharmacyID,
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
