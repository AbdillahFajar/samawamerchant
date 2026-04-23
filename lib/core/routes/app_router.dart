import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:samawamerchant/main_page.dart";
import "../../features/auth/presentation/providers/auth_provider.dart";
import "../../features/catalog/presentation/pages/splash_page.dart";
import "../../features/auth/presentation/pages/register_page.dart";
import "../../features/auth/presentation/pages/login_page.dart";
import "../../features/auth/presentation/pages/verify_email_page.dart";
import "../../features/orders/presentation/pages/order_detail_page.dart";

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';
  static const String orderDetail = '/order-detail';
  static const String mainPage = '/main';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    verifyEmail: (_) => const VerifyEmailPage(),
    mainPage: (_) => const AuthGuard(child: MainPage()), //Di sini udah include DashboardPage, CartPage dan OrderHeaderPage
    orderDetail: (_) => const OrderDetailPage(),
  };
}

// Bungkus halaman yang butuh autentikasi dengan AuthGuard
class AuthGuard extends StatelessWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final status = context.watch<AuthProvider>().status;

    return switch (status) {
      AuthStatus.authenticated => child, // Lanjut ke halaman
      AuthStatus.emailNotVerified =>
        const VerifyEmailPage(), // Redirect verifikasi
      _ => const LoginPage(), // Redirect login
    };
  }
}

// Penggunaan di routes:
// dashboard: (_) => const AuthGuard(child: DashboardPage())
//            ↑ DashboardPage HANYA muncul jika status = authenticated atau ada data user ada di database
