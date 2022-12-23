import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../const/color.dart';
import '../put_away_model/put_away_orderline_model.dart';
import '../put_away_orders_select.dart';

class PutAwayOrderProdWidget extends StatelessWidget {
  const PutAwayOrderProdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final putaway = Provider.of<PutAwayOrdersModel>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => PutAwayOrdersSelect(putawayOrder: putaway,)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  putaway.companyName,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: size.height * 0.015,
                  width: size.width * 0.05,
                  decoration: BoxDecoration(
                      color: CustomColor.yellow,
                      borderRadius: BorderRadius.circular(3)),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            putaway.createDate,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
           putaway.displayName,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
           putaway.origin,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
