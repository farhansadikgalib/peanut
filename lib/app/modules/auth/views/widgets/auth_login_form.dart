import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/widget/custom_textfield.dart';
import '../../controllers/auth_controller.dart';

class AuthLoginForm extends GetView<AuthController> {
  const AuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: 'Login ID',
          prefixIcon: Icons.person_outline,
          controller: controller.loginController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 20.h),

        Obx(
          () => CustomTextField(
            hintText: 'Password',
            prefixIcon: Icons.lock_outline,
            suffixIcon: controller.isPasswordVisible.value
                ? Icons.visibility
                : Icons.visibility_off,
            controller: controller.passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !controller.isPasswordVisible.value,
            textInputAction: TextInputAction.done,
            onSuffixIconPressed: () {
              controller.togglePasswordVisibility();
            },
          ),
        ),
      ],
    );
  }
}
