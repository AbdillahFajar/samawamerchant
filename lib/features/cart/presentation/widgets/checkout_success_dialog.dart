import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckoutSuccessDialog extends StatefulWidget {
  const CheckoutSuccessDialog({super.key});

  @override
  State<CheckoutSuccessDialog> createState() => _CheckoutSuccessDialogState();
}

class _CheckoutSuccessDialogState extends State<CheckoutSuccessDialog> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.of(context).pop(); // 🔥 auto close
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetAnimationDuration: const Duration(seconds: 3),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            Lottie.asset(
              'assets/animations/checkout_success.json',
              width: 150,
              repeat: false
            ),
            const SizedBox(height: 10),
            const Text(
              'Pembayaran Berhasil!',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            )
          ]
        )
      )
    );
  }
}