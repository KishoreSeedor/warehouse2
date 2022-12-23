import 'package:flutter/material.dart';

import '../../../const/color.dart';

class PutAwayFilterWidget extends StatelessWidget {
  const PutAwayFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.02, left: size.width * 0.15, bottom: size.height * 0.005),
        child: const Text(
          "Location",
          style: TextStyle(
              color: CustomColor.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        child: SizedBox(
          height: size.height * 0.05,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: CustomColor.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 2)),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.02, left: size.width * 0.15, bottom: size.height * 0.005),
        child: const Text(
          "Exp,Rec,Date",
          style: TextStyle(
              color: CustomColor.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        child: SizedBox(
          height: size.height * 0.05,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: CustomColor.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: CustomColor.homepageBgColor, width: 2)),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.02, left: size.width * 0.15, bottom: size.height * 0.005),
        child: const Text(
          "PO Number",
          style: TextStyle(
              color: CustomColor.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        child: SizedBox(
          height: size.height * 0.05,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: CustomColor.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 2)),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.02, left: size.width * 0.15, bottom: size.height * 0.005),
        child: const Text(
          "Assigned User ID",
          style: TextStyle(
              color: CustomColor.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        child: SizedBox(
          height: size.height * 0.05,
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset("assets/images/dropdown.png"),
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: CustomColor.white, width: 2)),
            ),
          ),
        ),
      ),
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.03, left: size.width * 0.42),
            child: SizedBox(
              height: size.height * 0.035,
              width: size.width * 0.26,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: CustomColor.whiteGreen,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "RESET",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.03,
            ),
            child: SizedBox(
              height: size.height * 0.035,
              width: size.width * 0.26,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xFFEDFDDD),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "APPLY",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    ]);
  }
}
