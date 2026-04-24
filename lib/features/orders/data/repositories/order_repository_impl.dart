import '../../../../core/services/dio_client.dart';
import '../../domain/repositories/order_repository.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<OrderModel> checkout() async {
    final res = await DioClient.instance.post(
      '/orders/checkout',
      data: {"shipping_address": "dummy", "notes": ""},
    );

    return OrderModel.fromJson(res.data['data']);
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final res = await DioClient.instance.get('/orders');

    final List data = res.data['data'];

    return List<OrderModel>.from(data.map((e) => OrderModel.fromJson(e)));
  }

  @override
  Future<OrderModel> getOrderById(int id) async {
    final res = await DioClient.instance.get('/orders/$id');
    return OrderModel.fromJson(res.data['data']);
  }
}
