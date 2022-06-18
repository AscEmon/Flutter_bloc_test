import 'package:bloc_test/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class GlobalLoader extends StatelessWidget {
  const GlobalLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator.adaptive(),
        SizedBox(
          width: 10.w,
        ),
        Text("Loading...")
      ],
    );
  }
}
