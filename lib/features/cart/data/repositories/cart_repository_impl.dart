import '../../../../core/services/dio_client.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../data/models/cart_response_model.dart';

class CartRepositoryImpl implements CartRepository {
  @override
  Future<CartResponseModel> getCart() async {
    final res = await DioClient.instance.get('/cart');

    return CartResponseModel.fromJson(res.data['data']);
  }

  @override
  Future<void> addItem(int productId, int quantity) async {
    await DioClient.instance.post(
      '/cart',
      data: {
        "product_id": productId,
        "quantity": quantity,
      },
    );
  }

  @override
  Future<void> removeItemById(int id) async {
    await DioClient.instance.delete('/cart/$id');
  }

  @override
  Future<void> clearCart() async {
    await DioClient.instance.delete('/cart');
  }

  @override
  Future<void> updateItem(int id, int quantity) async {
    await DioClient.instance.put(
      '/cart/$id',
      data: {"quantity": quantity},
    );
  }
}