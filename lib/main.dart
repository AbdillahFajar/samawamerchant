import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:samawamerchant/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:samawamerchant/features/orders/data/repositories/order_repository_impl.dart';
import 'firebase_options.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/catalog/presentation/providers/product_provider.dart';
import 'features/cart/presentation/providers/cart_provider.dart';
import 'features/orders/presentation/providers/order_provider.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase SEBELUM runApp
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider(repository: CartRepositoryImpl())),
        ChangeNotifierProvider(create: (_) => OrderProvider(OrderRepositoryImpl())),
      ],
      child: const MyApp(), //bikin MyApp file
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Buat variabel themeProvider untuk rebuild aplikasi menggunakan consumer watch dari package provider
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
        title: 'Samawa Merchant',
        
        //Daftarkan kedua tema aplikasi
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,

        //Untuk menentukan mode tema yang digunakan dengan menggunakan themeProvider. Perubahan modenya dipicu oleh fungsi toggleTheme() dari class ThemeProvider yang 
        themeMode: themeProvider.themeMode,

        initialRoute: AppRouter.splash,
        routes: AppRouter.routes,
        debugShowCheckedModeBanner: false,
    );
  }
}
