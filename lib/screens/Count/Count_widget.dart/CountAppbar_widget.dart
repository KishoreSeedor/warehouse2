import 'package:flutter/material.dart';
import 'package:warehouse/const/color.dart';

class CountAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CountAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.graybox,
      leading: Image.asset(
        "assets/images/count_logo.png",
        scale: 12,
      ),
      title: const Text(
        "Company Name",
        style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontFamily: "Nunito",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
