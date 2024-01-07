import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskproject/features/auth/register_screen.dart';
import 'package:taskproject/utils/keys.dart';
import 'package:taskproject/widgets/custom_text_field.dart';

class ProfileAddOrUpdate extends StatefulWidget {
  const ProfileAddOrUpdate({super.key, required this.isUpdateProfile});
  final bool isUpdateProfile;

  @override
  State<ProfileAddOrUpdate> createState() => _ProfileAddOrUpdateState();
}

class _ProfileAddOrUpdateState extends State<ProfileAddOrUpdate> {
  late final TextEditingController fullNameController;
  late final TextEditingController relationController;
  late final TextEditingController phoneController;
  late final TextEditingController birthdateController;

  late final FocusNode fullNameFocus;
  late final FocusNode relationFocus;
  late final FocusNode phoneFocus;
  late final FocusNode birthDateFocus;

  late final TextEditingController emailController;

  late final FocusNode emailFocus;

  var selectedGender = '';
  @override
  void initState() {
    fullNameController = TextEditingController();
    relationController = TextEditingController();
    phoneController = TextEditingController();
    birthdateController = TextEditingController();
    fullNameFocus = FocusNode();
    relationFocus = FocusNode();
    phoneFocus = FocusNode();
    birthDateFocus = FocusNode();
    emailController = TextEditingController();
    emailFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: widget.isUpdateProfile
            ? const Text(
                'Update profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            : const Text(
                'Add Family Member',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            AppKeys.mainAppNav.currentState?.pop();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                child: Column(
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
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: const Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Full Name',
                      ),
                    ),
                    CustomTextField(
                      textController: fullNameController,
                      textFocus: fullNameFocus,
                      isPass: false,
                      leadingIcon: null,
                      hintText: "Full Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'full name can not be empty';
                        }
                        return null;
                      },
                      isMultiLine: false,
                      onSubmitted: (value) {},
                    ),
                    const Gap(10),
                    widget.isUpdateProfile
                        ? const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Email'))
                        : const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Relation')),
                    widget.isUpdateProfile
                        ? CustomTextField(
                            textController: emailController,
                            textFocus: emailFocus,
                            isPass: false,
                            leadingIcon: null,
                            hintText: "Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'email can not be empty';
                              }
                              return null;
                            },
                            isMultiLine: false,
                            onSubmitted: (value) {},
                          )
                        : CustomTextField(
                            textController: relationController,
                            textFocus: relationFocus,
                            isPass: false,
                            leadingIcon: null,
                            hintText: "Relation",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'relation can not be empty';
                              }
                              return null;
                            },
                            isMultiLine: false,
                            onSubmitted: (value) {},
                          ),
                    const Gap(10),
                    const Align(
                        alignment: Alignment.centerLeft, child: Text('Phone')),
                    CustomTextField(
                      textController: phoneController,
                      textFocus: phoneFocus,
                      isPass: false,
                      leadingIcon: null,
                      hintText: "+92 31389*****",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'phone can not be empty';
                        }
                        return null;
                      },
                      isMultiLine: false,
                      onSubmitted: (value) {},
                    ),
                    const Gap(10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Date of Birth')),
                    CustomTextField(
                        textController: birthdateController,
                        textFocus: birthDateFocus,
                        isPass: true,
                        hintText: '03 Jan 2000',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'date of birth can not be empty';
                          }
                          return null;
                        },
                        isMultiLine: false,
                        onSubmitted: (value) {}),
                    const Gap(10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Birth Gender')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Male'),
                            Radio(
                              value: 'Male',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Female'),
                            Radio(
                              value: 'Female',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(
                                  () {
                                    selectedGender = value!;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    CustomButton(
                      width: width * 0.8,
                      onTap: () {},
                      title: widget.isUpdateProfile ? 'update' : 'Add',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
