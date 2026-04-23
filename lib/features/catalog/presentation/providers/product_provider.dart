import "package:flutter/material.dart";
import "package:dio/dio.dart";
import "../../data/models/product_model.dart";
import "../../../../core/services/dio_client.dart";
import "../../../../core/constants/api_constants.dart";

enum ProductStatus { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  ProductStatus _status = ProductStatus.initial;
  List<ProductModel> _products = [];
  String? _error;

  ProductStatus get status => _status;
  List<ProductModel> get products => _products;
  String? get error => _error;
  bool get isLoading => _status == ProductStatus.loading;

  // Fetch products — token otomatis disertakan oleh DioClient interceptor
  Future<void> fetchProducts() async {
    _status = ProductStatus.loading;
    notifyListeners();

    try {
      final response = await DioClient.instance.get(ApiConstants.products);

      // Backend response: { "data": [ {...}, {...} ] }
      final List<dynamic> data = response.data['data'];
      _products = data.map((e) => ProductModel.fromJson(e)).toList();
      _status = ProductStatus.loaded;
    } on DioException catch (e) {
      _error = e.response?.data['message'] ?? 'Gagal memuat produk';
      _status = ProductStatus.error;
    }

    notifyListeners();
  }

  // //Kurangin stok ketika checkout berhasil
  // void reduceStock(int productId, int quantity) {
  //   final index = _products.indexWhere((p) => p.id == productId);

  //   if (index != -1) {
  //     final product = _products[index];

  //     _products[index] = ProductModel(
  //       id: product.id,
  //       name: product.name,
  //       price: product.price,
  //       stock: product.stock - quantity,
  //       imageUrl: product.imageUrl,
  //       category: product.category,
  //     );

  //     notifyListeners();
  //   }
  // }
}
