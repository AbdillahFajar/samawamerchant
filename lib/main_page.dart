import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'my_flutter_app_icons.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/pages/auth_settings.dart';
import 'features/catalog/presentation/pages/dashboard_page.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'features/orders/presentation/pages/order_header_page.dart';
import  'core/providers/theme_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    CartPage(),
    OrdersHeaderPage(),
    AuthSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDark;
    final surface = Theme.of(context).colorScheme.surface;
    final primary = Theme.of(context).colorScheme.primary;
    final unselectedWidgetColor = Theme.of(context).unselectedWidgetColor;

    Widget appBarTitle;
    Widget appBarActions = const SizedBox(); //bikin widget untuk actions di appBar dan isi SizedBox kosong sebagai awalnya

    switch (_selectedIndex) {
      case 0: // Dashboard
        appBarTitle = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard', style: TextStyle(fontSize: 18)),
            Text(
              'Halo, ${auth.firebaseUser?.displayName ?? 'User'}!',
              style: const TextStyle(fontSize: 13),
            ),
          ],
        );
        appBarActions = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row(
            //   children: [
            //     Icon(
            //       isDark ? Icons.dark_mode : Icons.light_mode,
            //       size: 20,
            //       color: isDark ? Colors.amber : Colors.grey.shade600,
            //     ),
            //     Text(
            //       isDark ? 'Mode Gelap' : 'Mode Terang',
            //       style: const TextStyle(
            //         fontSize: 14
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(width: 10),
            Switch(
              value: isDark, //Posisi switch ada di mode gelap, karena mode awal aplikasi adalah mode terang dan di ThemeProvider, isDark di-set sebagai false
              onChanged: (_) => context.read<ThemeProvider>().toggleTheme(), //Panggil fungsi toggleTheme() untuk membalikkan kondisi tema saat switch diubah, dan memicu rebuild aplikasi dengan tema baru
            ),
          ]
        );
        break;

      case 1:
        appBarTitle = const Text('Keranjang Kamu');
        break;

      case 2:
        appBarTitle = const Text('History Belanja Kamu');
        break;

      case 3:
        appBarTitle = const Text('Halaman Pengaturan');
        break;

      default:
        appBarTitle = const Text('App');
    }

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: [appBarActions], //Karena actions membutuhkan List<Widget>, yaitu beberapa widget sekaligus, pake panggil appBarActions dengan dikurung siku ([])
        ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: primary,
        unselectedItemColor: unselectedWidgetColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Belanja',
            backgroundColor: surface,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
            backgroundColor: surface,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Pesanan',
            backgroundColor: surface,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
            backgroundColor: surface,
          ),
        ],
      ),
    );
  }
}
