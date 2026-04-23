import 'package:equatable/equatable.dart';
import '../../../catalog/data/models/product_model.dart';

class CartModel extends Equatable {
  final int id;
  final int productId;
  final int quantity;
  final ProductModel product;

  const CartModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      product: ProductModel.fromJson(json['product']),
    );
  }

  @override
  List<Object?> get props => [id, productId, quantity, product];
}
