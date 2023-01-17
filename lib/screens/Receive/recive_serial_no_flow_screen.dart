import 'package:flutter/material.dart';

import '../../const/color.dart';

class ReciveSerialNoFlowScreen extends StatelessWidget {
  const ReciveSerialNoFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: ListView.builder(
      itemCount: 4,
      itemBuilder: (ctx, index) {
      return GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(17),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColor.gray200,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'loca name',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColor.blackcolor2),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.04,
                              ),
                              child: Text(
                                'prod name',
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.blackcolor2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'qty',
                                style: const TextStyle(
                                    color: CustomColor.blackcolor2,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Text(
                              //   "3",
                              //   style: const TextStyle(
                              //       color: CustomColor.blackcolor2,
                              //       fontSize: 23,
                              //       fontWeight: FontWeight.bold),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          const Text(
                            "PCS",
                            style: TextStyle(
                                color: CustomColor.blackcolor2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                  ],
                ),
              ),
            );
    }));
  }
}
