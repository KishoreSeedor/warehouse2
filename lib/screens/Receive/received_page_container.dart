import 'package:flutter/material.dart';
import '../../const/color.dart';

class ReceivedContainer extends StatefulWidget {
  const ReceivedContainer({
    Key? key,
    required this.onTap,
    required this.height,
    required this.width,
    required this.companyName,
    required this.createDate,
    required this.displayName,
    required this.origin,
  }) : super(key: key);

  final double height;
  final double width;
  final String companyName;
  final String createDate;
  final String origin;
  final String displayName;
  final GestureTapCancelCallback? onTap;

  @override
  State<ReceivedContainer> createState() => _ReceivedContainerState();
}

class _ReceivedContainerState extends State<ReceivedContainer> {
  @override
  Widget build(BuildContext context) {
    // var hi = MediaQuery.of(context).size.height;
    // var wi = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 10,
                child: Text(
                  widget.companyName,
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: widget.height * 0.015,
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
            widget.createDate,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.displayName,
            overflow: TextOverflow.visible,
            maxLines: 1,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.origin,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
