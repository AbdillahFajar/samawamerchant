import 'cart_model.dart';

class CartResponseModel {
  final List<CartModel> items;
  final int totalItems;
  final double totalPrice;

  CartResponseModel({
    required this.items,
    required this.totalItems,
    required this.totalPrice,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      items: (json['items'] as List)
          .map((e) => CartModel.fromJson(e))
          .toList(),
      totalItems: json['total_items'],
      totalPrice: (json['total_price'] as num).toDouble(),
    );
  }
}