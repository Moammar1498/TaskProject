import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskproject/utils/colors.dart';
import 'package:taskproject/utils/keys.dart';
import 'package:taskproject/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode emailFocus;
  late final FocusNode passwordFocus;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    super.initState();
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  const Gap(30),
                  const Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(20),
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
                      }
                      return null;
                    },
                    isMultiLine: false,
                    onSubmitted: (value) {},
                  ),
                  const Align(
                      alignment: Alignment.centerLeft, child: Text('Password')),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (v) {}),
                          const Text('Remember me'),
                        ],
                      ),
                      const Text('Forgot Password?')
                    ],
                  ),
                  const Gap(20),
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    onTap: () {
                      AppKeys.mainAppNav.currentState?.pushNamed('/home');
                    },
                    child: Ink(
                      width: width * 0.8,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const Gap(80),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          AppKeys.mainAppNav.currentState
                              ?.pushNamed('/register');
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 14),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
