import 'package:app_estudos_flutter/pages/page_um.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  PageController pageController = PageController(initialPage: 0);
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(206, 74, 2, 122),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    page = value;
                  },
                  children: const [MyWidget()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
