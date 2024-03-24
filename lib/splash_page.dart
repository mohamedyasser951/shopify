import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';

class SplashPage extends StatefulWidget {
  final Widget startWidget;
  const SplashPage({
    super.key,
    required this.startWidget,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5000)).whenComplete(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => widget.startWidget,
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(seconds: 4),
                child: SvgPicture.asset(ImagesPath.splashImg),
                builder: (context, value, child) =>
                    Opacity(opacity: value, child: child)),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              "Shopify",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
