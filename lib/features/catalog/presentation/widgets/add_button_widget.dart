import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samawamerchant/core/constants/app_colors.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../data/models/product_model.dart';

class AddButton extends StatelessWidget {
  final ProductModel product;
  const AddButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<CartProvider>().addItem(product.id);
      },
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text("Pesan", style: TextStyle(color: Colors.black)),
    );
  }
}
