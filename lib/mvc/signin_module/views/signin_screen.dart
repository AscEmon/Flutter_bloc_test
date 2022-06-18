import 'package:bloc_test/mvc/signin_module/views/components/form_part.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white54,
      appBar: AppBar(
        title:   Text("Sign In"),
      ),
      body: Column(
        children: [
          FormPart(),
        ],
      ),
    );
  }
}
