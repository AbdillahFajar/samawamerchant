import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late int orderId; //bikin orderId sebagai variabel terpisah biar bisa dipakai di mana aja 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderId = ModalRoute.of(context)!.settings.arguments as int;
      context.read<OrderProvider>().fetchOrderById(orderId); //Ambil id order dari order header page untuk nampilin detail order dari header order yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();
    final order = provider.selectedOrder;
     final surface = Theme.of(context).colorScheme.surface;
     final onSurface = Theme.of(context).colorScheme.onSurface;

    if (order == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ), //Loading, mungkin ini penyebab datanya agak lama muncul
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Detail Pesanan")),
      body: Column(
        children: [
          // 🔹 List Item
          Expanded(
            child: ListView.builder(
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.receipt, size: 30),
                    title: Text(
                        item.productName,
                        style: TextStyle(
                          color: onSurface,
                        )
                      ),
                    subtitle: Text(
                        "Jumlah: ${item.quantity}",
                        style: TextStyle(
                          color: onSurface,
                        )
                      ),
                    trailing: Text(
                      "Rp ${item.subtotal.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: onSurface,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
