import 'package:flutter/material.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      child: Container(
        width: double.maxFinite,
        height: 100,
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
            child: Center(
                child: Text(
          "No Internet connect",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ))),
      ),
    );
  }
}
