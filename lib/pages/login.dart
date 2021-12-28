import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_key/controllers/authController.dart';
import 'package:test_key/pages/forgetPassword.dart';
import 'package:test_key/pages/registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                'Login',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Colors.blue)),
                    controller: emailController,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.blue)),
                    controller: passwordController,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color.fromRGBO(87, 68, 172, 1)),
                child: TextButton(
                    onPressed: () {
                      controller.login(
                          emailController.text, passwordController.text);
                      //Get.to(() => RegisterScreen());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPassword());
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => RegisterScreen());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign Up',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
