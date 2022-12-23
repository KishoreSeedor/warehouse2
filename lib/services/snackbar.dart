import 'package:flutter/material.dart';
import '../const/color.dart';

class GlobalSnackbar {
  genarelSnackbar({required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 40,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: CustomColor.orangecolor,
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  successsnackbar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SizedBox(
        height: 40,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: CustomColor.yellow,
      duration: const Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
    ));
  }

//  required GestureDetector onPressed
  valitatorSnackBar({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 200,
          right: 20,
          left: 20),
      content: SizedBox(
        height: 40,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      // margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: CustomColor.yellow,
      duration: const Duration(days: 365),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: "Re-enter",
        onPressed: () {
          // onPressed;
        },
      ),
    ));
  }
}
