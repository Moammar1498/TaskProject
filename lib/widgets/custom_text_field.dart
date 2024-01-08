import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textController,
    required this.textFocus,
    required this.isPass,
    this.leadingIcon,
    required this.hintText,
    required this.validator,
    required this.isMultiLine,
    required this.onSubmitted,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  final bool readOnly;

  final TextEditingController textController;
  final FocusNode textFocus;
  final bool isPass;
  final VoidCallback? onTap;
  final Icon? leadingIcon;
  final bool isMultiLine;
  final String hintText;
  final String? Function(String?) validator;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
    return isPass
        ? ValueListenableBuilder(
            valueListenable: obscurePassword,
            builder: (context, value, child) {
              return TextFormField(
                focusNode: textFocus,
                controller: textController,
                validator: validator,
                obscureText: obscurePassword.value,
                decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  hintText: hintText.isEmpty ? 'Password' : hintText,
                  fillColor: Colors.grey[100],
                  filled: true,
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: leadingIcon,
                  suffixIcon: InkWell(
                      onTap: () {
                        obscurePassword.value = !obscurePassword.value;
                      },
                      child: Icon(obscurePassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTapOutside: (e) {
                  textFocus.unfocus();
                },
              );
            })
        : TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            onTapOutside: (e) {
              textFocus.unfocus();
            },
            maxLength: (isMultiLine) ? 250 : null,
            maxLines: (isMultiLine) ? 8 : 1,
            focusNode: textFocus,
            controller: textController,
            validator: validator,
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              prefixIcon: leadingIcon,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelStyle: const TextStyle(fontWeight: FontWeight.w400),
              contentPadding: const EdgeInsets.all(10),
              isCollapsed: true,
              hintText: hintText,
              fillColor: Colors.grey[100],
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
  }
}
