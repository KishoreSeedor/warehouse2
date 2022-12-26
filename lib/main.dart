import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/provider/barcode_provider.dart';
import 'package:warehouse/screens/Count/Count_Provider/count_total_itemcount.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pick_order_provider.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pickorder_line_provider.dart';
import 'package:warehouse/screens/PickOrder/pick_ui_design/pick_orders_screen.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_orderline_provider.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_provider.dart';
import 'provider/device_info.dart';
import 'provider/login_auth_provider.dart';
import 'provider/login_details.provider.dart';
import 'provider/recive_orders_provider.dart';

import 'screens/splashscreen.dart';
import 'services/api/recive_api.dart';

class MyhttpOverrides extends HttpOverrides {
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  HttpOverrides.global = MyhttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: DeviceInformation()),
        // ChangeNotifierProvider.value(value: RecievedDetails()),
        ChangeNotifierProvider.value(value: UserDetails()),
        ChangeNotifierProvider.value(
          value: RecieveAPI(),
        ),
        ChangeNotifierProvider.value(value: ParticularOrders()),
        ChangeNotifierProvider.value(value: RecieveAPI()),
        ChangeNotifierProvider.value(value: PutAwayProvider()),
        ChangeNotifierProvider.value(value: PickOrderProvider()),
        ChangeNotifierProvider.value(value: PickOrderLineProvider()),
        ChangeNotifierProvider.value(value: PutAwayOrderLineProvid()),
        ChangeNotifierProvider.value(value: barcodeprovider()),
        ChangeNotifierProvider.value(value: CountTotalIdProvider()),
      ],
      child: MaterialApp(
        title: 'Warehouse',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          'pickOrderRoute': (context) => const PickOrdersScreen(),

          // 'recieve-page': (context) => const ReceiveOrders(),
          // 'home_page': (context) => const MyHomePage(),
          // 'orders_page': (context) =>  OrdersSelectPage(),
        },
      ),
    );
  }
}
