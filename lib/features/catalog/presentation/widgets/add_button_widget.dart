import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../data/models/product_model.dart';

class AddButton extends StatelessWidget {
  final ProductModel product;
  const AddButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
     final primary = Theme.of(context).colorScheme.primary;
     final onSurface = Theme.of(context).colorScheme.onSurface;

    return TextButton(
      onPressed: () {
        context.read<CartProvider>().addItem(product.id);
      },
      style: TextButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text("Pesan", style: TextStyle(color: onSurface)),
    );
  }
}
