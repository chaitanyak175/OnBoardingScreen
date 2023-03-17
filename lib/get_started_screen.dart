import 'package:animation/core/theme/app_color.dart';
import 'package:animation/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GetStartedscreen extends StatefulWidget {
  const GetStartedscreen({super.key});

  @override
  State<GetStartedscreen> createState() => _GetStartedscreenState();
}

class _GetStartedscreenState extends State<GetStartedscreen> {
  final pageController = PageController();
  final selectedIndex = ValueNotifier(0);

  final illustrations = [
    "assets/cleaning.json",
    "assets/customerservice.json",
    "assets/ontime.json",
  ];

  final titles = [
    "hi this is chaitanya karmalkar",
    "who are you?",
    "something about it."
  ];

  final descs = [
    "Ho Hey",
    "Ophelia",
    "Wake me Up",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: illustrations.length,
                itemBuilder: (context, index) {
                  return _PageLayout(
                    illustration: illustrations[index],
                    title: titles[index],
                    desc: descs[index],
                  );
                },
                onPageChanged: (value) {
                  selectedIndex.value = value;
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, index, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: Wrap(
                    spacing: 8,
                    children:
                        List.generate(illustrations.length, (indexIndicator) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 8,
                        width: indexIndicator == index ? 24 : 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: indexIndicator == index
                                ? AppColor.primaryColor
                                : AppColor.primaryColor.withOpacity(0.5)),
                      );
                    }),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, index, child) {
                  if (index == illustrations.length - 1) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text("Get Started"),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          pageController.jumpToPage(illustrations.length - 1);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text("Skip"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final nextPage = selectedIndex.value + 1;
                          pageController.animateToPage(
                            nextPage,
                            duration: const Duration(microseconds: 300),
                            curve: Curves.ease);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text("Next"),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageLayout extends StatelessWidget {
  const _PageLayout({
    required this.illustration,
    required this.title,
    required this.desc,
  });

  final String illustration;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset(
                illustration,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              desc,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
            )
          ],
        ));
  }
}
