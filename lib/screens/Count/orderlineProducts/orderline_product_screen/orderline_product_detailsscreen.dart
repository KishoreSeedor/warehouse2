import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/Count/Count_model/customer_count_orderprod_model.dart';
import 'package:warehouse/screens/Count/count_widget/expandedcount_widget.dart';

import '../../customerCountScreen/customercountprovider/customer_count_provider.dart';

class OrderlineProductDetailsScreen extends StatefulWidget {
  final String id;
  const OrderlineProductDetailsScreen({super.key, required this.id});

  @override
  State<OrderlineProductDetailsScreen> createState() =>
      _OrderlineProductDetailsScreenState();
}

class _OrderlineProductDetailsScreenState
    extends State<OrderlineProductDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CustomerCountProvider>(context, listen: false)
        .getCountforAllDetails(
            context: context, apiName: 'total-product', id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final count = Provider.of<CustomerCountProvider>(context);
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
      body: SingleChildScrollView(
          child: Column(
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

          // Container(
          //   height: size.height * 0.1,
          //   child: Column(
          //     children: [
          //       Text()
          //     ],
          //   ),
          // )
        ],
      )),
    );
  }
}
