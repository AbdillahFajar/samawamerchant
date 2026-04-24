import '../../data/models/order_model.dart';

abstract class OrderRepository {
  Future<OrderModel> checkout();
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(int id);
}