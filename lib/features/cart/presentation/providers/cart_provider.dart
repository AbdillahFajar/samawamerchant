import 'package:flutter/material.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../data/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _repository;

  List<CartModel> _items = [];
  int _totalItems = 0;
  double _totalPrice = 0;

  List<CartModel> get items => _items;
  int get totalItems => _totalItems;
  double get totalPrice => _totalPrice;

  CartProvider({required CartRepository repository})
      : _repository = repository; //panggil ini di main.dart pake repository: CartRepositoryImpl()

  // 🔥 Ambil cart dari backend
  Future<void> fetchCart() async {
    final res = await _repository.getCart();

    _items = res.items;
    _totalItems = res.totalItems;
    _totalPrice = res.totalPrice;

    notifyListeners();
  }

  // ➕ tambah item
  Future<void> addItem(int productId) async {
    await _repository.addItem(productId, 1);
    await fetchCart();
  }

  // ❌ hapus item
  Future<void> removeItemById(int id) async {
    await _repository.removeItemById(id);
    await fetchCart();
  }

  // 🗑 clear cart
  Future<void> clearCart() async {
    await _repository.clearCart();
    await fetchCart();
  }

  // ➕ tambah qty
  Future<void> increaseQty(CartModel item) async {
    await _repository.updateItem(item.id, item.quantity + 1);
    await fetchCart();
  }

  // ➖ kurang qty
  Future<void> decreaseQty(CartModel item) async {
    if (item.quantity <= 1) {
      await _repository.removeItemById(item.id);
    } else {
      await _repository.updateItem(item.id, item.quantity - 1);
    }
    await fetchCart();
  }
}