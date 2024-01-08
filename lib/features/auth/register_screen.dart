import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/features/auth/model/user.dart';
import 'package:taskproject/features/auth/viewmodel/auth_vm.dart';
import 'package:taskproject/utils/colors.dart';
import 'package:taskproject/utils/utils.dart';
import 'package:taskproject/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController fNameController;
  late final TextEditingController lNameController;
  late final TextEditingController phoneController;
  late final TextEditingController retypePasswordController;
  late final FocusNode emailFocus;
  late final FocusNode passwordFocus;
  late final FocusNode fNameFocus;
  late final FocusNode lNameFocus;
  late final FocusNode phoneFocus;
  late final FocusNode retypePasswordFocus;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    phoneController = TextEditingController();
    retypePasswordController = TextEditingController();
    emailFocus = FocusNode();
    fNameFocus = FocusNode();
    lNameFocus = FocusNode();
    phoneFocus = FocusNode();
    passwordFocus = FocusNode();
    retypePasswordFocus = FocusNode();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/topbg.png',
                width: width * 1,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const Gap(30),
                    const Text(
                      'Register an account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(20),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'First Name',
                      ),
                    ),
                    CustomTextField(
                      textController: fNameController,
                      textFocus: fNameFocus,
                      isPass: false,
                      leadingIcon: null,
                      hintText: "First Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'first name can not be empty';
                        }
                        return null;
                      },
                      isMultiLine: false,
                      onSubmitted: (value) {},
                    ),
                    const Gap(10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Last Name')),
                    CustomTextField(
                      textController: lNameController,
                      textFocus: lNameFocus,
                      isPass: false,
                      leadingIcon: null,
                      hintText: "Last Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'last name can not be empty';
                        }
                        return null;
                      },
                      isMultiLine: false,
                      onSubmitted: (value) {},
                    ),
                    const Gap(10),
                    const Align(
                        alignment: Alignment.centerLeft, child: Text('Email')),
                    CustomTextField(
                      textController: emailController,
                      textFocus: emailFocus,
                      isPass: false,
                      leadingIcon: null,
                      hintText: "abc@email.com",
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
                        child: Text('Password')),
                    CustomTextField(
                        textController: passwordController,
                        textFocus: passwordFocus,
                        isPass: true,
                        hintText: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password can not be empty';
                          } else if (value.length < 8) {
                            return 'password must be at least 8 ch long.';
                          }
                          return null;
                        },
                        isMultiLine: false,
                        onSubmitted: (value) {}),
                    const Gap(10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Retype Password')),
                    CustomTextField(
                        textController: retypePasswordController,
                        textFocus: retypePasswordFocus,
                        isPass: true,
                        hintText: 'Confirm Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password can not be empty';
                          } else if (value.trim() !=
                              passwordController.text.trim()) {
                            return 'password must match. please confirm again';
                          }
                          return null;
                        },
                        isMultiLine: false,
                        onSubmitted: (value) {}),
                    const Gap(20),
                    CustomButton(
                      width: width * 0.8,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final user = UserModel(
                            firstName: fNameController.text.trim().toString(),
                            lastName: lNameController.text.trim().toString(),
                            email: emailController.text.trim().toString(),
                            phone: phoneController.text.trim().toString(),
                            password: passwordController.text.trim().toString(),
                          );
                          await context
                              .read<AuthProvider>()
                              .registerUser(context, user);
                        }
                      },
                      title: 'Create Account',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.onTap,
    this.height,
    required this.title,
    this.bgColor,
    this.textColor,
  });

  final double width;
  final VoidCallback onTap;
  final double? height;
  final String title;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      onTap: onTap,
      child: Ink(
        width: width,
        height: height ?? 40,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primaryColor,
          border: Border.all(color: AppColors.primaryColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 16, color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
