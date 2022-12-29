import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/Count/Count_model/customer_count_orderprod_model.dart';
import 'package:warehouse/screens/Count/customerOrderScreen/customer_order_provider/customer_count_order_provider.dart';
import 'package:warehouse/screens/Count/orderlineProducts/orderlineProductProvider/orderline_prod_provider.dart';
import 'package:warehouse/screens/Count/orderlineProducts/orderline_product_screen/orderline_product_detailsscreen.dart';
import 'package:warehouse/screens/PutAway/utilites/empty_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/loading_screen.dart';

import '../../../../const/color.dart';
import '../../count_widget/expandedcount_widget.dart';
import '../../customerCountScreen/customercountprovider/customer_count_provider.dart';

class OrderLineProductScreen extends StatefulWidget {
  final String id;
  const OrderLineProductScreen({super.key, required this.id});

  @override
  State<OrderLineProductScreen> createState() => _OrderLineProductScreenState();
}

class _OrderLineProductScreenState extends State<OrderLineProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderLineProdProvider>(context, listen: false)
        .getOrderlineProdApi(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prodLine = Provider.of<OrderLineProdProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
          title: Text('Orderline'),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: prodLine.orderlineProdLoading
            ? LoadingScreenPutAway(
                title: 'Loading...',
              )
            : prodLine.orderlineErrorLoading
                ? ErrorScreenPutAway(title: prodLine.orderlineError)
                : prodLine.orderLIneProduct.isEmpty
                    ? EmptyScreenPutAway(title: 'No product found.')
                    : ListView.builder(
                        itemCount: prodLine.orderLIneProduct.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      OrderlineProductDetailsScreen(
                                          id: prodLine
                                              .orderLIneProduct[index].id)));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          prodLine.orderLIneProduct[index].name,
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: size.height * 0.015,
                                          decoration: BoxDecoration(
                                              color: CustomColor.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    prodLine.orderLIneProduct[index].createDate,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    prodLine.orderLIneProduct[index].name,
                                    overflow: TextOverflow.visible,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    prodLine.orderLIneProduct[index].origin,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }));
  }
}
