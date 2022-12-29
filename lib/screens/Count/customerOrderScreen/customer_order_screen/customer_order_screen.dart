import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/Count/count_widget/expandedcount_widget.dart';
import 'package:warehouse/screens/Count/customerCountScreen/customercountprovider/customer_count_provider.dart';
import 'package:warehouse/screens/Count/customerOrderScreen/customer_order_provider/customer_count_order_provider.dart';
import 'package:warehouse/screens/Count/orderlineProducts/orderline_product_screen/orderline_product_screen.dart';

import '../../../PutAway/utilites/empty_screen.dart';
import '../../../PutAway/utilites/error_screen.dart';
import '../../../PutAway/utilites/loading_screen.dart';

class CustomerCountOrderScreen extends StatefulWidget {
  final String id;
  static const routeName = 'customer_count_order_screen';
  const CustomerCountOrderScreen({super.key, required this.id});

  @override
  State<CustomerCountOrderScreen> createState() =>
      _CustomerCountOrderScreenState();
}

class _CustomerCountOrderScreenState extends State<CustomerCountOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CustomerCountProvider>(context, listen: false)
        .getCountforAllDetails(
            context: context, apiName: 'total-customer-product', id: widget.id);
    Provider.of<CustomerCountOrderProvider>(context, listen: false)
        .getCustomerProdListApi(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    final prodList = Provider.of<CustomerCountOrderProvider>(context);
    final count = Provider.of<CustomerCountProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
          title: Text('count'),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Column(
          children: [
            Container(
              height: size.height * 0.1,
              child: ExpandedCountWidget(
                  asnCount: count.countTotalModel != null
                      ? count.countTotalModel!.asn
                      : '-',
                  deliveryCount: count.countTotalModel != null
                      ? count.countTotalModel!.delivery
                      : '-',
                  grnCount: count.countTotalModel != null
                      ? count.countTotalModel!.grn
                      : '-',
                  inStock: count.countTotalModel != null
                      ? count.countTotalModel!.inStock
                      : '-'),
            ),
            if (prodList.customerProdLoading)
              Flexible(child: LoadingScreenPutAway(title: 'Loading...'))
            else if (prodList.allCustomerProdList.isNotEmpty)
              Flexible(
                child: ListView.builder(
                    itemCount: prodList.allCustomerProdList.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => OrderLineProductScreen(
                                  id: prodList.allCustomerProdList[index].id)));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(10),
                          color: Colors.grey[200],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(prodList
                                  .allCustomerProdList[index].displayName),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'No of line ${prodList.allCustomerProdList[index].moveLineIds.length}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text(prodList
                                  .allCustomerProdList[index].companyName),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            else if (prodList.customerErrorLoading)
              Flexible(
                  child: ErrorScreenPutAway(
                      title: prodList.customerprodErrorMessage))
            else if (prodList.allCustomerProdList.isEmpty)
              Flexible(
                  child: EmptyScreenPutAway(
                title: 'No Product found',
              ))
          ],
        ));
  }
}
