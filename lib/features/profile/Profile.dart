import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskproject/features/profile/profile_add_or_update.dart';
import 'package:taskproject/utils/colors.dart';
import 'package:taskproject/utils/keys.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'My Profile',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Ink(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        const NetworkImage('https://i.pravatar.cc/300'),
                    onBackgroundImageError: (exception, stackTrace) {
                      return;
                    },
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Material(
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          AppKeys.mainAppNav.currentState?.push(
                              MaterialPageRoute(
                                  builder: (_) => const ProfileAddOrUpdate(
                                      isUpdateProfile: true)));
                        },
                        child: Ink(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor),
                          child: const Center(
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'Mathew Adam',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text('mathew@email.com'),
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Ink(
                    height: 90,
                    width: 90,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '23y 4m',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(4),
                        Text('Age')
                      ],
                    ),
                  ),
                  const Gap(20),
                  Ink(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'male',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(4),
                        Text('Birth Gender')
                      ],
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Family Members',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 2) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                AppKeys.mainAppNav.currentState?.push(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const ProfileAddOrUpdate(
                                                isUpdateProfile: false)));
                              },
                              child: Ink(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),
                            ),
                            const Gap(4),
                            const Text('Add'),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: const NetworkImage(
                                  'https://i.pravatar.cc/300'),
                              onBackgroundImageError: (exception, stackTrace) {
                                return;
                              },
                            ),
                            const Gap(4),
                            const Text('Brother'),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Past Appointments",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: const NetworkImage(
                                      'https://i.pravatar.cc/300'),
                                  onBackgroundImageError:
                                      (exception, stackTrace) {
                                    return;
                                  },
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Dr. Graham George',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Ink(
                                        height: 28,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            )),
                                        child: const Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Row(children: [
                                            Icon(
                                              Icons.heart_broken,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                            Text('4.0')
                                          ]),
                                        ),
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.video_call,
                                            size: 18,
                                          ),
                                          Text('Video Session'),
                                        ],
                                      ),
                                      const Text('Mathew Adam (me)'),
                                    ]),
                                const Gap(20),
                                const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '60 \$',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                        width: 90,
                                        child: Text('Monday, Oct 10, 08:30 PM'))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
