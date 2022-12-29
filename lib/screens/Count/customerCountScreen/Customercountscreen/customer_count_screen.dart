import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/Count/count_widget/expandedcount_widget.dart';
import 'package:warehouse/screens/Count/customerCountScreen/customercountprovider/customer_count_provider.dart';
import 'package:warehouse/screens/Count/customerOrderScreen/customer_order_screen/customer_order_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/empty_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/loading_screen.dart';

import '../../Count_model/count_customer_model.dart';

class CustomerCountScreen extends StatefulWidget {
  static const routeName = 'customer_count_screen';
  const CustomerCountScreen({super.key});

  @override
  State<CustomerCountScreen> createState() => _CustomerCountScreenState();
}

class _CustomerCountScreenState extends State<CustomerCountScreen> {
  List<CountCustomerModel> searchListData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final data = Provider.of<CustomerCountProvider>(context, listen: false);
    data.getAllCustomerApi(context: context);
    data
        .getCountforAllDetails(
            context: context, apiName: 'total-warehouse', id: '')
        .then((value) {
      print(data.countTotalModel);
    });
  }

  final TextEditingController customerTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    customerTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<CustomerCountProvider>(context);
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
          customer.coiuntLoading
              ? Container()
              : Container(
                  height: size.height * 0.1,
                  child: ExpandedCountWidget(
                      asnCount: customer.countTotalModel != null
                          ? customer.countTotalModel!.asn
                          : '-',
                      deliveryCount: customer.countTotalModel != null
                          ? customer.countTotalModel!.delivery
                          : '-',
                      grnCount: customer.countTotalModel != null
                          ? customer.countTotalModel!.grn
                          : '-',
                      inStock: customer.countTotalModel != null
                          ? customer.countTotalModel!.inStock
                          : '-'),
                ),
          Container(
            height: size.height * 0.06,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]),
            child: TextFormField(
              controller: customerTextController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Customer name',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
              onChanged: (val) {
                setState(() {
                  searchListData = customer.searchQuery(val);
                  setState(() {});
                });
              },
            ),
          ),
          if (customer.customerLoading)
            Flexible(child: LoadingScreenPutAway(title: 'Loading...'))
          else if (customer.allCustomerData.isNotEmpty)
            searchListData.isEmpty
                ? Flexible(
                    child: ListView.builder(
                        itemCount: customer.allCustomerData.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  CustomerCountOrderScreen.routeName,
                                  arguments:
                                      customer.allCustomerData[index].id);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(7),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  customer.allCustomerData[index].name,
                                  style: TextStyle(fontSize: 18),
                                )),
                          );
                        }))
                : Flexible(
                    child: ListView.builder(
                        itemCount: searchListData.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  CustomerCountOrderScreen.routeName,
                                  arguments:
                                      customer.allCustomerData[index].id);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(7),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  searchListData[index].name,
                                  style: TextStyle(fontSize: 18),
                                )),
                          );
                        }))
          else if (customer.customerErrorLoading)
            Flexible(
                child: Center(
                    child: ErrorScreenPutAway(
                        title: customer.customerErrorScreen)))
          else if (customer.allCustomerData.isEmpty)
            Flexible(
              child: EmptyScreenPutAway(
                title: 'No Customer found',
              ),
            )
        ],
      ),
    );
  }
}
