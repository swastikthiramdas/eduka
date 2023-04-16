import 'package:eduka/screens/home_page.dart';
import 'package:eduka/screens/registeration_screen.dart';
import 'package:eduka/utils/auth_methords.dart';
import 'package:eduka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login_screen extends StatefulWidget {
  @override
  _Login_screenState createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoding = false;
  bool showPassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void NavigateToSign() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(),
      ),
    );
  }

  void loginUser() async {
    setState(() {
      isLoding = true;
    });
    String ref = await AuthMethods().loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (ref == 'Success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const HomeScreen())),
      );
    } else {
      showSnakBar(ref, context);
    }
    setState(() {
      isLoding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 500,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(blurRadius: 1, spreadRadius: 0.10),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 60),
              Container(
                width: 350,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.black45),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Email',
                    hintStyle: TextStyle(fontSize: 12),
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 350,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        obscureText: showPassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.key),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
              MaterialButton(
                splashColor: Colors.lightBlueAccent,
                minWidth: 350,
                height: 60,
                onPressed: () => loginUser(),
                child: Text('LOGIN'),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => NavigateToSign(),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Don\'t have an account ?',
                          style: TextStyle(color: Colors.grey[900])),
                      TextSpan(
                        text: ' Sign up',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
} /**/
