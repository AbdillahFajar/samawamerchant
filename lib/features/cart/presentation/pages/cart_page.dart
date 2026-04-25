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
    final surface = Theme.of(context).colorScheme.surface;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    bool isEmpty = cart.items.isEmpty;

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
                  color: surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // 🖼 IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "http://10.226.173.78:8081${item.product.imageUrl}",
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
                            style: TextStyle(color: onSurface),
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
                            color: surface,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: onSurface,
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
          color: surface,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Harga", style: TextStyle(color: onSurface)),
                    Text(
                      "Rp ${cart.totalPrice.toStringAsFixed(0)}",
                      style: TextStyle(color: onSurface),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Keranjang masih kosong"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return; // ⛔ STOP di sini
                        }

                        await order.checkout();
                        await cartRead.fetchCart(); // 🔥 BACKEND DIPANGGIL
                        await product
                            .fetchProducts(); // 🔥 ambil stok terbaru dari DB
                        await order
                            .fetchOrders(); // 🔥 refresh data order terbaru
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => const CheckoutSuccessDialog(),
                        );
                      },
                      child: const Text(
                        'Bayar',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
