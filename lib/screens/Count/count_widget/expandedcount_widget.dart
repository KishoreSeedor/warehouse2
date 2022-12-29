import 'package:flutter/material.dart';

class ExpandedCountWidget extends StatelessWidget {
  final String asnCount;
  final String deliveryCount;
  final String grnCount;
  final String inStock;
  const ExpandedCountWidget(
      {super.key,
      required this.asnCount,
      required this.deliveryCount,
      required this.grnCount,
      required this.inStock});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        expandedWidget(title: 'ASN', count: asnCount == '' ? '' : asnCount),
        expandedWidget(title: 'Delivery', count: deliveryCount),
        expandedWidget(title: 'GRN', count: grnCount),
        expandedWidget(title: 'Stock', count: inStock)
      ],
    );
  }

  Widget expandedWidget({required String title, required String count}) {
    return Expanded(
        flex: 2,
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title),
              Text(count),
            ],
          ),
        ));
  }
}
