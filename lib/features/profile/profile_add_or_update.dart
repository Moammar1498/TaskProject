import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/features/auth/model/user.dart';
import 'package:taskproject/features/profile/model/family_member.model.dart';
import 'package:taskproject/features/profile/provider/user_profile.provider.dart';
import 'package:taskproject/features/profile/services/profile_image.service.dart';
import 'package:taskproject/utils/keys.dart';
import 'package:taskproject/utils/utils.dart';
import 'package:taskproject/widgets/custom_button.dart';
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
  String? imageUrl = '';
  String? selectedRelation;
  final relationList = [
    'Brother',
    'Father',
    'Mother',
    'Sister',
    'Son',
    'Daughter'
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final user = context.read<ProfileProvider>().getUser;
    imageUrl = widget.isUpdateProfile ? user?.photoUrl : '';
    fullNameController = TextEditingController(
        text: widget.isUpdateProfile
            ? '${user?.firstName} ${user?.lastName ?? ''}'
            : '');
    relationController = TextEditingController();
    phoneController =
        TextEditingController(text: widget.isUpdateProfile ? user?.phone : '');
    birthdateController = TextEditingController(
        text: widget.isUpdateProfile ? user?.birthdate : '');
    emailController =
        TextEditingController(text: widget.isUpdateProfile ? user?.email : '');
    selectedGender = widget.isUpdateProfile ? user?.gender ?? '' : '';
    fullNameFocus = FocusNode();
    relationFocus = FocusNode();
    phoneFocus = FocusNode();
    birthDateFocus = FocusNode();
    emailFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<ProfileProvider>().getUser;
    final userId = FirebaseAuth.instance.currentUser?.uid;
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
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(widget.isUpdateProfile
                              ? imageUrl!.isNotEmpty
                                  ? imageUrl!
                                  : user?.photoUrl ?? ''
                              : imageUrl!),
                          onBackgroundImageError: (exception, stackTrace) {
                            return;
                          },
                          child: (imageUrl!.isEmpty)
                              ? Center(
                                  child: Text(
                                    widget.isUpdateProfile
                                        ? '${user?.firstName[0]} ${(user!.lastName.isNotEmpty) ? user.lastName[0] : ''}'
                                        : 'Add Image',
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: Material(
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                AppUtils.showPickImageDialog(
                                  context,
                                  () async {
                                    imageUrl = await ProfileImageService
                                        .getProfilePicture(
                                            context,
                                            userId!,
                                            ImageSource.camera,
                                            (widget.isUpdateProfile)
                                                ? false
                                                : true);
                                    setState(() {});
                                  },
                                  () async {
                                    imageUrl = await ProfileImageService
                                        .getProfilePicture(
                                            context,
                                            userId!,
                                            ImageSource.gallery,
                                            (widget.isUpdateProfile)
                                                ? false
                                                : true);
                                    setState(() {});
                                  },
                                );
                              },
                              child: Ink(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: const Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
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
                              } else if (!AppUtils.isValidEmail(value)) {
                                return 'Please enter valid email user@example.com';
                              }
                              return null;
                            },
                            isMultiLine: false,
                            onSubmitted: (value) {},
                          )
                        : DropdownButtonFormField<String>(
                            dropdownColor: Theme.of(context).cardColor,
                            isExpanded: true,
                            style: TextStyle(
                                color: (Theme.of(context).brightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white),
                            alignment: Alignment.centerRight,
                            decoration: buildInputDecoration(
                                context, 'Select Relation'),
                            value: selectedRelation,
                            items: relationList.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    textScaler: const TextScaler.linear(1.0),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRelation =
                                    newValue!; //user.indexOf(value!);
                              });
                            }),
                    const Gap(10),
                    const Align(
                        alignment: Alignment.centerLeft, child: Text('Phone')),
                    CustomTextField(
                      textController: phoneController,
                      textFocus: phoneFocus,
                      isPass: false,
                      isPhone: true,
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
                        isPass: false,
                        readOnly: true,
                        hintText: '03 Jan 2000',
                        onTap: () {
                          selectDate(context);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'date of birth can not be empty';
                          }
                          return null;
                        },
                        isMultiLine: false,
                        onSubmitted: (value) {
                          debugPrint(value + birthdateController.text);
                        }),
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
                              value: 'male',
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
                              value: 'female',
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
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.isUpdateProfile) {
                            final updateUser = UserModel(
                                firstName: fullNameController.text
                                    .trim()
                                    .split(' ')[0],
                                lastName:
                                    fullNameController.text.trim().contains(' ')
                                        ? fullNameController.text
                                            .trim()
                                            .split(' ')[1]
                                        : '',
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                password: '',
                                gender: selectedGender,
                                birthdate:
                                    birthdateController.text.trim().toString(),
                                photoUrl: imageUrl);
                            debugPrint(
                                '${updateUser.firstName} ${updateUser.lastName} ${updateUser.email} ${updateUser.gender} ${updateUser.birthdate} ${updateUser.phone}');
                            context
                                .read<ProfileProvider>()
                                .updateUserProfile(context, updateUser);
                          } else {
                            final familyMember = FamilyMember(
                                fullName: fullNameController.text.trim(),
                                relation: selectedRelation?.trim(),
                                phone: phoneController.text.trim(),
                                birthdate: birthdateController.text.trim(),
                                gender: selectedGender.trim(),
                                photoUrl: imageUrl);
                            context
                                .read<ProfileProvider>()
                                .addFamilyMember(context, familyMember);
                          }
                        }
                      },
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

  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    ))!;

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthdateController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  InputDecoration buildInputDecoration(BuildContext context, String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
          color: Color(0xFF989898), fontWeight: FontWeight.w400),
      contentPadding: const EdgeInsets.all(10),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      isCollapsed: true,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Color((Theme.of(context).brightness == Brightness.light)
                ? 0xffE4E7EB
                : 0xff263238)),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffE4E7EB)),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
