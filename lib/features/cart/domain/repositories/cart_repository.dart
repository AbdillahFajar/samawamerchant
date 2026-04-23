import '../../data/models/cart_response_model.dart';

abstract class CartRepository {
  Future<CartResponseModel> getCart();

  Future<void> addItem(int productId, int quantity);
  Future<void> removeItemById(int id);
  Future<void> clearCart();
  Future<void> updateItem(int id, int quantity);
}