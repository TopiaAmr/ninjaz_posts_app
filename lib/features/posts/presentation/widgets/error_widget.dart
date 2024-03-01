import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A widget that displays an error message with a refresh button.
///
/// This widget is typically used when there is an error fetching data from
/// the internet and the user should try again.
class TheErrorWidget extends StatelessWidget {
  /// Callback function that is called when the refresh button is pressed.
  final void Function()? onRefresh;

  /// Creates a [TheErrorWidget].
  const TheErrorWidget({
    super.key,
    this.onRefresh,
  });

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
