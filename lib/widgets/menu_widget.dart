import 'package:flutter/material.dart';

import '../const/color.dart';

class MenuWidget extends StatelessWidget {
  String image;
  Function value;
  String title;
  MenuWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Center(
      child: GestureDetector(
        onTap: () {
          value;
        },
        child: Container(
          color: Colors.white,
          height: height * 0.05,
          width: width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Image.asset(
                    image,
                    scale: 15,
                  )),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReceivedMenu extends StatelessWidget {
  const ReceivedMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: height * 0.5,
          width: width * 0.8,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 2,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MenuWidget(
                  value: () {},
                  image: "assets/images/locate.png",
                  title: "Locate item",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Divider(
                    thickness: 3,
                    color: CustomColor.grayword,
                  ),
                ),
                MenuWidget(
                  value: () {},
                  image: "assets/images/camera.png",
                  title: "Attach image",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Divider(
                    thickness: 3,
                    color: CustomColor.grayword,
                  ),
                ),
                MenuWidget(
                  value: () {},
                  image: "assets/images/move.png",
                  title: "Move",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Divider(
                    thickness: 3,
                    color: CustomColor.grayword,
                  ),
                ),
                MenuWidget(
                  value: () {},
                  image: "assets/images/post.png",
                  title: "Post",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Divider(
                    thickness: 3,
                    color: CustomColor.grayword,
                  ),
                ),
                MenuWidget(
                  value: () {},
                  image: "assets/images/registration.png",
                  title: "Registrations",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Divider(
                    thickness: 3,
                    color: CustomColor.grayword,
                  ),
                ),
                MenuWidget(
                  value: () {},
                  image: "assets/images/delete.png",
                  title: "Delete Registrations",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Divider(
                    thickness: 3,
                    color: CustomColor.grayword,
                  ),
                ),
                MenuWidget(
                  value: () {},
                  image: "assets/images/barcode_menu.png",
                  title: "Type Barcode",
                ),
              ]),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
