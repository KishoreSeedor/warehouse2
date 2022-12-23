import 'package:flutter/cupertino.dart';
import 'package:warehouse/models/orders_line_model.dart';
import 'package:warehouse/services/api/recive_api.dart';

class ParticularProvider extends ChangeNotifier {
  List<OrderLine> _particular = [];
  List<OrderLine> get particular => _particular;
  bool isLoading = false;

  ParticularProvider({required BuildContext context, domain}) {
    final _order = RecieveAPI();

    Future<void> getAllParticular() async {
      isLoading = true;
      notifyListeners();

      final response =
          _order.particularOrders(context: context, domain: domain);

      _particular = response as List<OrderLine>;
      notifyListeners();
    }
  }
}
