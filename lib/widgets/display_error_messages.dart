import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DisplayErrorMessage extends StatelessWidget {
  const DisplayErrorMessage({super.key, this.error});
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("data. $error"),
    );
  }
}