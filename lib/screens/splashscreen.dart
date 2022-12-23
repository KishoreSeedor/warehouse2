import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../const/color.dart';
import '../provider/login_details.provider.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final loginData = Provider.of<UserDetails>(context, listen: false);
    loginData.getAllDetails().then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        debugPrint('${loginData.email} email value');
        loginData.email == 'Not yet updated'
            ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage()))
            : Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const MyHomePage()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: CustomColor.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: const Text(
                  "WareHouse",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }
}
