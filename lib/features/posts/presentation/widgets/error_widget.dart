import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TheErrorWidget extends StatelessWidget {
  final void Function()? onRefresh;
  const TheErrorWidget({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset('assets/loading_error.json'),
          ),
          SizedBox(height: 20),
          Text(
            "Something went wrong, please try again",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20),
          if (onRefresh != null)
            ElevatedButton(
              onPressed: onRefresh,
              child: Text("Try Again"),
            )
        ],
      ),
    );
  }
}
