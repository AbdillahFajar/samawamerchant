import 'package:flutter/material.dart';
import '../../domain/order_repository.dart';
import '../../data/models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _repository;

  List<OrderModel> _items =
      []; //Ini untuk halaman list order yang gak nampilin detail per order
  OrderModel?
  _selectedOrder; //Ini untuk halaman yang nampilin detail per order dari list order

  List<OrderModel> get items => _items;
  OrderModel? get selectedOrder => _selectedOrder;

  OrderProvider(
    this._repository,
  ); //panggil ini di main.dart, cukup OrderProvider(OrderRepositoryImpl()), tanpa "repository:"

  // 🔥 Ambil semua order
  Future<void> fetchOrders() async {
    _items = await _repository.getOrders();
    notifyListeners();
  }

  // 🔥 Checkout
  Future<void> checkout() async {
    await _repository.checkout();
  }

  // 🔥 Ambil 1 order by ID
  Future<void> fetchOrderById(int id) async {
    _selectedOrder = null; // Reset UI sebelum tampilin data baru dari detail order yang diklik
    notifyListeners();

    _selectedOrder = await _repository.getOrderById(id);
    notifyListeners();
  }
}
