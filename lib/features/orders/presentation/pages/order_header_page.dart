import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/order_provider.dart';
import '../../../../core/routes/app_router.dart';

class OrdersHeaderPage extends StatefulWidget {
  const OrdersHeaderPage({super.key});

  @override
  State<OrdersHeaderPage> createState() => _OrdersHeaderPageState();
}

class _OrdersHeaderPageState extends State<OrdersHeaderPage> {
  //Load data belanja customer
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    var order = context.watch<OrderProvider>();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: order.items.length,
            itemBuilder: (context, index) {
              final item = order.items[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Text('Rp ${item.totalAmount.toStringAsFixed(0)}'),
                  subtitle: Text(item.status),
                  trailing: ElevatedButton(
                    onPressed: () {
                      //Pindah halaman dan kirim id header order ke halmaan order detail
                      Navigator.pushNamed(
                        context,
                        AppRouter.orderDetail,
                        arguments: item.id,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
