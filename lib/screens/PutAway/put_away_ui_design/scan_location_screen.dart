import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/const/color.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_orderline_provider.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

class PutawayScanLocationScreen extends StatefulWidget {
  const PutawayScanLocationScreen({super.key});

  @override
  State<PutawayScanLocationScreen> createState() =>
      _PutawayScanLocationScreenState();
}

class _PutawayScanLocationScreenState extends State<PutawayScanLocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {
      final data = Provider.of<PutAwayOrderLineProvid>(context, listen: false);
      data.locationscannerDialog(context: context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pallet = Provider.of<PutAwayOrderLineProvid>(context);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Note',
            subtitle: 'Do you want close this page?',
            button: true,
            onTapCancelButt: () {
              Navigator.of(context).pop();
             
            },
            onTapOkButt: () async {
              pallet.clearlocationDetailModel();
              pallet.clearpalletScanOrderLineModel();
              Navigator.of(context).pop();
               Navigator.of(context).pop();
            });
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.gray200,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                pallet.clearlocationDetailModel();
                pallet.clearpalletScanOrderLineModel();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            'Scan Location',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            pallet.locationDetailModel.id == ""
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: pallet.locationDetailModel.id != ""
                        ? Container()
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.yellow)),
                            onPressed: () async {
                              await pallet.locationscannerDialog(
                                  context: context);
                            },
                            child: Text(
                              'Scan Location',
                              style: TextStyle(color: Colors.black),
                            )),
                  )
                : Container()
          ],
        ),
        body: Column(
          children: [
            pallet.locationLoading
                ? Container(
                    height: size.height * 0.2,
                    width: size.width,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container(
                    width: size.width,
                    child: Column(
                      children: [
                        pallet.locationDetailModel.id == ""
                            ? const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Please Scan the location'),
                              )
                            : Container(
                                width: size.width,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.yellow)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Location Details',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "Location Name : ${pallet.locationDetailModel.name}"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "Total CBM : ${pallet.locationDetailModel.totalCBMofLocation}"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "Free CBM : ${pallet.locationDetailModel.containCBMofLocation}"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Column(
                                                children: [
                                                  Text('Occupied'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  CircularPercentIndicator(
                                                    radius: 60.0,
                                                    lineWidth: 5.0,
                                                    percent: pallet
                                                            .locationPercentage /
                                                        100,
                                                    center: Text(
                                                      "${pallet.locationPercentage.round()}%",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    progressColor: Colors.green,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                        pallet.locationDetailModel.id == ""
                            ? Container()
                            : pallet.palletScanOrderLineModel.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.yellow)),
                                        onPressed: () async {
                                          await pallet.palletscannerDialog(
                                            context: context,
                                          );
                                        },
                                        child: const Text(
                                          'Scan Pallet',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  )
                                : Container(
                                    width: size.width,
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: Colors.yellow)),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Pallet details',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(pallet.palletScanOrderLineModel[0]
                                            .palletDestinationName),
                                        Text(
                                            "Total CBM of Pallet : ${pallet.totalCbmOfProd.toStringAsFixed(2)}")
                                      ],
                                    ),
                                  ),
                      ],
                    ),
                  )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: size.width,
          height: size.height * 0.06,
          color: Colors.yellow,
          margin: const EdgeInsets.all(20),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              onPressed: () {
                if (pallet.locationDetailModel.id != "" &&
                    pallet.palletScanOrderLineModel.isNotEmpty) {
                  if (pallet.locationUptBool) {
                  } else {
                    String volume =
                        "${pallet.locationDetailModel.containCBMofLocation - pallet.totalCbmOfProd}";
                    print(volume + '------>>> value value');
                    if (volume.contains('-')) {
                      MyCustomAlertDialog().showCustomAlertdialog(
                          context: context,
                          title: 'Note',
                          subtitle:
                              "The volume of the pallet seems to be exceeding the max volume of the location",
                          onTapOkButt: () {
                            Navigator.of(context).pop();
                          });
                    } else {
                      pallet.updateThePalletLocation(
                          context: context,
                          palletId:
                              pallet.palletScanOrderLineModel[0].palletDest,
                          locationId: pallet.locationDetailModel.id,
                          volume: volume);
                    }
                  }
                }
              },
              child: Text(
                pallet.locationDetailModel.id == ""
                    ? "Scan Location"
                    : pallet.palletScanOrderLineModel.isEmpty
                        ? 'Scan Pallet'
                        : 'Confirm ',
                style: TextStyle(
                    color: Colors.black, fontSize: 18, letterSpacing: 2),
              )),
        ),
      ),
    );
  }
}
