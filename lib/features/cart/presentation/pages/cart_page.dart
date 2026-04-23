import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../../../cart/presentation/widgets/checkout_success_dialog.dart';
import '../../../catalog/presentation/providers/product_provider.dart';
import '../../../orders/presentation/providers/order_provider.dart';
import '../../../../core/constants/app_colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //Load data Cart Customer dari Backend
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    final cartRead = context.read<CartProvider>();
    final product = context.read<ProductProvider>();
    final order = context.read<OrderProvider>();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // 🖼 IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "http://192.168.1.10:8081${item.product.imageUrl}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // 📝 INFO PRODUK
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rp ${item.product.price.toStringAsFixed(0)}',
                            style: const TextStyle(color: AppColors.primaryDark),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            cart.removeItemById(item.id);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                          iconSize: 25,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.accent),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 20),
                                onPressed: () {
                                  context.read<CartProvider>().decreaseQty(
                                    item,
                                  );
                                },
                              ),
                              Text(
                                item.quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 20),
                                onPressed: () {
                                  context.read<CartProvider>().increaseQty(
                                    item,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Harga"),
                    Text("Rp ${cart.totalPrice.toStringAsFixed(0)}"),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await order.checkout();
                        await cartRead.fetchCart(); // 🔥 BACKEND DIPANGGIL
                        await product.fetchProducts(); // 🔥 ambil stok terbaru dari DB
                        await order.fetchOrders(); // 🔥 refresh data order terbaru
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => const CheckoutSuccessDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text(
                        'Bayar',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // SizedBox(width: 12),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     await cartRead.clearCart();
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.red,
                    //   ),
                    //   child: const Text(
                    //     "Batalkan",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}