import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/features/profile/profile_add_or_update.dart';
import 'package:taskproject/features/profile/provider/user_profile.provider.dart';
import 'package:taskproject/features/profile/widgets/past_appointments_item.dart';
import 'package:taskproject/utils/colors.dart';
import 'package:taskproject/utils/keys.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileProvider>().getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final currentUser = context.watch<ProfileProvider>().getUser;
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
                    backgroundImage: NetworkImage(currentUser?.photoUrl ?? ''),
                    onBackgroundImageError: (exception, stackTrace) {
                      return;
                    },
                    child: Center(
                      child: (currentUser != null)
                          ? (currentUser.photoUrl!.isEmpty)
                              ? Text(
                                  '${currentUser.firstName[0]} ${(currentUser.lastName.isNotEmpty) ? currentUser.lastName[0] : ''}',
                                )
                              : const SizedBox.shrink()
                          : const Text('FN'),
                    ),
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
              Text(
                ('${currentUser?.firstName} ${currentUser?.lastName}'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(currentUser?.email ?? 'mathew@email.com'),
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ProfilePropertyWidget(
                    label: 'Age',
                    property: '23y 4m',
                  ),
                  const Gap(20),
                  ProfilePropertyWidget(
                      label: 'Birth Gender',
                      property: currentUser?.gender ?? 'male')
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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('familyMembers')
                        .where(
                          'userId',
                          isEqualTo: FirebaseFirestore.instance
                              .collection('users')
                              .doc(
                                FirebaseAuth.instance.currentUser?.uid,
                              ),
                        )
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var familyMembers = snapshot.data?.docs ?? [];

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: familyMembers.length + 1,
                        itemBuilder: (context, index) {
                          if (familyMembers.isEmpty) {
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
                            if (index == familyMembers.length) {
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
                                                        isUpdateProfile:
                                                            false)));
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
                              var familyMember = familyMembers[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          familyMember['photoUrl'] ?? ''),
                                      onBackgroundImageError:
                                          (exception, stackTrace) {
                                        return;
                                      },
                                      child: (familyMember['photoUrl'].isEmpty)
                                          ? Center(
                                              child: Text(
                                                  familyMember['fullName'][0]))
                                          : const SizedBox.shrink(),
                                    ),
                                    const Gap(4),
                                    Text(familyMember['relation']),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                  )),
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
                      return const PastAppointmentsItem();
                    }),
              )
            ],
          ),
        ));
  }
}

class ProfilePropertyWidget extends StatelessWidget {
  const ProfilePropertyWidget({
    super.key,
    required this.label,
    required this.property,
  });

  final String label;
  final String property;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            property,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(4),
          Text(
            label,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
