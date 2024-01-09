import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskproject/utils/colors.dart';
import 'package:taskproject/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hye, Emily!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Gap(20),
                const Text(
                  'wanna book an appointment?',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: width * 1,
                    height: 50,
                    onTap: () {},
                    title: "Book Appointment",
                  ),
                ),
                const Gap(12),
              ],
            ),
          ),
          Expanded(
            child: Ink(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'You have an upcoming appointment!!',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: const NetworkImage(
                                  'https://i.pravatar.cc/300'),
                              onBackgroundImageError: (exception, stackTrace) {
                                return;
                              },
                            ),
                            const Gap(12),
                            const Text(
                              'Dr. Emma Mia',
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        CustomButton(
                          width: 100,
                          height: 40,
                          onTap: () {},
                          title: 'Attend Now',
                          bgColor: Colors.transparent,
                          textColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                    const Gap(12),
                    Align(
                      alignment: Alignment.center,
                      child: Ink(
                        height: 50,
                        width: width * 1,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 25,
                                    color: AppColors.primaryColor,
                                  ),
                                  Text('Monday, 12 May')
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.alarm_outlined,
                                    size: 25,
                                    color: AppColors.primaryColor,
                                  ),
                                  Text('11:00-12:00 AM')
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Health Articles',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text('See All')
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ArticleItem(),
                            );
                          }),
                    ),
                    const Gap(80)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          child: Ink(
            height: 138,
            width: 312,
            decoration: const BoxDecoration(
              color: Color(0xffEF81A6),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        ClipPath(
          clipper: CustomRectangleClipper(),
          child: Container(
            height: 138,
            width: 312,
            decoration: const BoxDecoration(
              color: Color(0xffE21C5F),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Transform.rotate(
            angle: -1.56,
            child: ClipPath(
              clipper: CustomSqrClipper(),
              child: Container(
                height: 74,
                width: 74,
                decoration: const BoxDecoration(
                    color: Color(0xffDF034D),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(8))),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '02 July 2022',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Gap(172),
                  Icon(
                    Icons.bookmark_outline,
                    color: Colors.white,
                  )
                ],
              ),
              Gap(12),
              Text(
                'COVID-19 Vaccine',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(8),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      'Official public service announcement on corona virus from the world health',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                    size: 30,
                    weight: 0.20,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomRectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double clipPercentage = 0.24; // 20% clipping from the right side

    Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(size.width * (1 - clipPercentage), 0)
      ..quadraticBezierTo(
        size.width,
        size.height / 2,
        size.width * (1 - clipPercentage),
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomSqrClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..quadraticBezierTo(size.width, 0, 0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
