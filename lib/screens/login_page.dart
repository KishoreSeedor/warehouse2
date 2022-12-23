import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/services/bar_code_scaner.dart';
import '../const/color.dart';
import '../provider/device_info.dart';
import '../provider/login_auth_provider.dart';
import '../services/dialogue.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });
  static const routname = 'login-screen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<DeviceInformation>(context, listen: false).InitPlatformStatus();
    super.initState();
  }

  bool obsecureText = true;
  final _fromKey = GlobalKey<FormState>();
  final GlobalServices _services = GlobalServices();

  void sumit() async {
    final cricleLoading = Provider.of<AuthProvider>(context, listen: false);
    cricleLoading.isLoading
        ? showDialog(
            context: context,
            builder: ((context) {
              return const Center(
                  child: CircularProgressIndicator(
                color: CustomColor.yellow,
              ));
            }))
        : null;
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    final isValid = _fromKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_emailController.text.isEmpty ||
        !regExp.hasMatch(_emailController.text)) {
      return _services.customDialog(context, "Email", "Enter vaild email");
    } else if (_passwordController.text.isEmpty) {
      return _services.customDialog(
          context, "Password", "Enter Valid Password");
    } else {
      _fromKey.currentState!.save();
      await Provider.of<AuthProvider>(context, listen: false).loginApi(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
      debugPrint('loginApi');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<AuthProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _fromKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/loginImage.png"),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: height * 0.025),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFEBEBEB),
                      ),
                      width: width * 0.9,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02,
                                  left: width * 0.1,
                                  bottom: height * 0.01),
                              child: const Text(
                                "Enter Username",
                                style: TextStyle(
                                    color: CustomColor.darkword,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.1),
                              child: SizedBox(
                                height: height * 0.05,
                                child: TextFormField(
                                  controller: _emailController,
                                  onChanged: (value) {
                                    value = _emailController.text.trim();
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: CustomColor.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.01,
                                  left: width * 0.1,
                                  bottom: height * 0.01),
                              child: const Text(
                                "Enter Password",
                                style: TextStyle(
                                    color: CustomColor.darkword,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.1),
                              child: SizedBox(
                                height: height * 0.05,
                                child: TextFormField(
                                  controller: _passwordController,
                                  onChanged: ((value) {
                                    value = _passwordController.text.trim();
                                  }),
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: CustomColor.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Center(
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          color: CustomColor.yellow,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        onPressed: () {
                          sumit();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor.yellow,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          loading.isLoading ? "Loading" : 'Login',
                          style: TextStyle(
                              color: CustomColor.blackcolor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  const Center(
                      child: Text(
                    "Version 1.0.0 Developed By Seedor",
                    style: TextStyle(color: Color(0xFFC6C6C6), fontSize: 16),
                  ))
                ]),
          ),
        ),
        backgroundColor: CustomColor.white,
      ),
    );
  }
}
