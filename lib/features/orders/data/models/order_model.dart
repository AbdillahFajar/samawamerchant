import 'order_item_model.dart';

class OrderModel {
  final int id;
  final String status;
  final double totalAmount;
  final String shippingAddress;
  final String notes;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.shippingAddress,
    required this.notes,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      shippingAddress: json['shipping_address'],
      notes: json['notes'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}