import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/provider/barcode_provider.dart';
import 'package:warehouse/screens/Count/Count_Provider/count_total_itemcount.dart';
import 'package:warehouse/screens/Count/customerCountScreen/Customercountscreen/customer_count_screen.dart';
import 'package:warehouse/screens/Count/customerCountScreen/customercountprovider/customer_count_provider.dart';
import 'package:warehouse/screens/Count/customerOrderScreen/customer_order_provider/customer_count_order_provider.dart';
import 'package:warehouse/screens/Count/customerOrderScreen/customer_order_screen/customer_order_screen.dart';
import 'package:warehouse/screens/Count/inventryProductScreen/inventry_provider/inventry_provider.dart';
import 'package:warehouse/screens/Count/orderlineProducts/orderlineProductProvider/orderline_prod_provider.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pick_order_provider.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pickorder_line_provider.dart';
import 'package:warehouse/screens/PickOrder/pick_ui_design/pick_orders_screen.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_orderline_provider.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_provider.dart';
import 'package:warehouse/screens/login/login_api_call_warehouse.dart';
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
        ChangeNotifierProvider.value(value: CustomerCountProvider()),
        ChangeNotifierProvider.value(value: CustomerCountOrderProvider()),
        ChangeNotifierProvider.value(value: OrderLineProdProvider()),
        ChangeNotifierProvider.value(
          value: InventryProductProvider(),
        ),
        ChangeNotifierProvider.value(value: LoginWareHouseCall())
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
          'customer_count_screen': (context) => const CustomerCountScreen(),
          'customer_count_order_screen': (context) {
            String id = ModalRoute.of(context)!.settings.arguments as String;
            return CustomerCountOrderScreen(
              id: id,
            );
          }

          // 'recieve-page': (context) => const ReceiveOrders(),
          // 'home_page': (context) => const MyHomePage(),
          // 'orders_page': (context) =>  OrdersSelectPage(),
        },
      ),
    );
  }
}
