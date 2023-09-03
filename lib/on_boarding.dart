import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  String imgPath;
  String title;
  String description;
  OnBoardingModel({
    required this.imgPath,
    required this.title,
    required this.description,
  });
}

List<OnBoardingModel> onBoaedingData = [
  OnBoardingModel(
      imgPath: "assets/images/shopping.svg",
      title: "Explore",
      description:
          "Choose Whatever the Product you wish for with easiest Way possible using ShopMarket"),
  OnBoardingModel(
      imgPath: "assets/images/shiping.svg",
      title: "Shiping",
      description:
          "Your Order will be Shipped to you as fast as possible by our Carrier"),
  OnBoardingModel(
      imgPath: "assets/images/delivery.svg",
      title: "Get IT Deliverred",
      description: "our Order will be Delivered to you faster")
];

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPagetState();
}

class _OnBoardingPagetState extends State<OnBoardingPage> {
  PageController pageController = PageController();
  bool isLast = false;
  void submitStateofOnBoarding() async {
    await Hive.box(AppStrings.settingsBox)
        .put("onBoarding", true)
        .then((value) {
      Navigator.pushNamed(context, "/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  submitStateofOnBoarding();
                },
                child: const Text("Skip"),
              ),
            ),
            Expanded(
                child: PageView.builder(
              onPageChanged: (value) {
                if (value == onBoaedingData.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              controller: pageController,
              itemCount: onBoaedingData.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  OnBoardingItem(model: onBoaedingData[index]),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onBoaedingData.length,
                  effect: WormEffect(
                      type: WormType.thin,
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 4,
                      dotColor: AppColors.grayColor,
                      activeDotColor: AppColors.primaryColor),
                ),
                TextButton(
                    onPressed: () {
                      if (isLast) {
                        submitStateofOnBoarding();
                      } else {
                        pageController.nextPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.bounceOut);
                      }
                    },
                    child: const Text("Next"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingItem extends StatelessWidget {
  final OnBoardingModel model;
  const OnBoardingItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: SvgPicture.asset(model.imgPath)),
        Text(
          model.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          model.description,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 16, color: AppColors.grayColor),
        ),
        const SizedBox(
          height: 80,
        )
      ],
    );
  }
}
