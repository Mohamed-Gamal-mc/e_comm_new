import 'package:e_comm_new/core/resources/assets_manager.dart';
import 'package:e_comm_new/core/resources/color_manager.dart';
import 'package:e_comm_new/core/resources/font_manager.dart';
import 'package:e_comm_new/core/resources/styles_manager.dart';
import 'package:e_comm_new/core/resources/values_manager.dart';
import 'package:e_comm_new/core/routes/routes.dart';
import 'package:e_comm_new/core/utils/ui_utils.dart';
import 'package:e_comm_new/core/utils/validator.dart';
import 'package:e_comm_new/core/widgets/custom_elevated_button.dart';
import 'package:e_comm_new/core/widgets/custom_text_field.dart';
import 'package:e_comm_new/features/auth/data/models/register_request.dart';
import 'package:e_comm_new/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_comm_new/features/auth/presentation/cubit/auth_states.dart';
import 'package:e_comm_new/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

enum PasswordStrength { empty, weak, medium, strong }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController? _nameController = TextEditingController();
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _phoneController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<PasswordStrength> strength =
      ValueNotifier<PasswordStrength>(PasswordStrength.empty);
  @override
  void initState() {
    super.initState();

    _passwordController?.addListener(_passwordListener);
  }

  static void onPasswordChanged({
    required TextEditingController? passwordController,
    required ValueNotifier<PasswordStrength> strength,
  }) {
    final next = calcStrength(passwordController!.text);
    if (next != strength.value) {
      strength.value = next;
    }
  }

  static PasswordStrength calcStrength(String p) {
    if (p.isEmpty) return PasswordStrength.empty;

    final hasLower = RegExp(r'[a-z]').hasMatch(p);
    final hasUpper = RegExp(r'[A-Z]').hasMatch(p);
    final hasDigit = RegExp(r'\d').hasMatch(p);
    final hasSpecial =
        RegExp(r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]=+~`]').hasMatch(p);

    int score = 0;
    if (p.length >= 8) score++;
    if (p.length >= 12) score++;
    if (hasLower && hasUpper) score++;
    if (hasDigit) score++;
    if (hasSpecial) score++;

    if (score <= 1) return PasswordStrength.weak;
    if (score <= 3) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }

  Widget _passwordStrengthBar() {
    return ValueListenableBuilder<PasswordStrength>(
      valueListenable: strength,
      builder: (context, s, _) {
        if (s == PasswordStrength.empty) return const SizedBox.shrink();

        final active = _activeCount(s);

        return Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Password Strength',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.65),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _strengthLabel(s),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: _labelColor(s),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: List.generate(4, (i) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: _segmentColor(i, active),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  String _strengthLabel(PasswordStrength s) {
    switch (s) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Good';
      case PasswordStrength.strong:
        return 'Strong';
      default:
        return '';
    }
  }

  Color _labelColor(PasswordStrength s) {
    if (s == PasswordStrength.weak) return const Color(0xFFFF3B30);
    if (s == PasswordStrength.medium) return const Color(0xFFFFCC00);
    if (s == PasswordStrength.strong) return const Color(0xFF34C759);
    return Colors.transparent;
  }

  int _activeCount(PasswordStrength s) {
    if (s == PasswordStrength.weak) return 1;
    if (s == PasswordStrength.medium) return 3;
    if (s == PasswordStrength.strong) return 4;
    return 0;
  }

  Color _segmentColor(int index, int active) {
    final inactive = Colors.white.withValues(alpha: 0.22);
    if (index >= active) return inactive;

    if (index == 0) return const Color(0xFFFF3B30);
    if (index == 1) return const Color(0xFFFF9500);
    if (index == 2) return const Color(0xFFFFCC00);
    return const Color(0xFF34C759);
  }

  void _passwordListener() {
    onPasswordChanged(
      passwordController: _passwordController,
      strength: strength,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Insets.s20.sp),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Sizes.s40.h,
                  ),
                  Center(child: SvgPicture.asset(SvgAssets.route)),
                  SizedBox(
                    height: Sizes.s40.h,
                  ),
                  CustomTextField(
                    backgroundColor: ColorManager.white,
                    hint: 'enter your full name',
                    label: 'Full Name',
                    textInputType: TextInputType.name,
                    validation: Validator.validateFullName,
                    controller: _nameController,
                    prefixIcon: Icon(
                      Icons.person,
                      color: ColorManager.black,
                    ),
                  ),
                  SizedBox(
                    height: Sizes.s18.h,
                  ),
                  CustomTextField(
                    hint: 'enter your mobile no.',
                    backgroundColor: ColorManager.white,
                    label: 'Mobile Number',
                    validation: Validator.validatePhoneNumber,
                    textInputType: TextInputType.phone,
                    controller: _phoneController,
                    prefixIcon: Icon(
                      Icons.phone_android_rounded,
                      color: ColorManager.black,
                    ),
                  ),
                  SizedBox(
                    height: Sizes.s18.h,
                  ),
                  CustomTextField(
                    hint: 'enter your email address',
                    backgroundColor: ColorManager.white,
                    label: 'E-mail address',
                    validation: Validator.validateEmail,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    prefixIcon: Icon(
                      Icons.mail_outline_outlined,
                      color: ColorManager.black,
                    ),
                  ),
                  SizedBox(
                    height: Sizes.s18.h,
                  ),
                  CustomTextField(
                    hint: 'enter your password',
                    backgroundColor: ColorManager.white,
                    label: 'password',
                    validation: Validator.validatePassword,
                    isObscured: true,
                    textInputType: TextInputType.text,
                    controller: _passwordController,
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: Validator.validatePassword == null
                          ? ColorManager.error
                          : ColorManager.black,
                    ),
                  ),
                  SizedBox(
                    height: Sizes.s24.h,
                  ),
                  _passwordStrengthBar(),
                  SizedBox(
                    height: Sizes.s24.h,
                  ),
                  Center(
                    child: SizedBox(
                      height: Sizes.s60.h,
                      width: MediaQuery.sizeOf(context).width * .9,
                      child: BlocListener<AuthCubit, AuthStates>(
                        listener: (_, state) {
                          if (state is RegisterLoading) {
                            UIUtils.showLoading(context);
                          } else if (state is RegisterSuccess) {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.home);
                          } else if (state is RegisterError) {
                            UIUtils.hideLoading(context);
                            UIUtils.showMessage(state.message);
                          }
                        },
                        child: CustomElevatedButton(
                          label: 'Register',
                          backgroundColor: ColorManager.white,
                          isStadiumBorder: false,
                          textStyle: getBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s20,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print(Validator.validatePassword);
                              authCubit.register(RegisterRequest(
                                email: _emailController!.text,
                                password: _passwordController!.text,
                                phone: _phoneController!.text,
                                name: _nameController!.text,
                              ));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: getSemiBoldStyle(color: ColorManager.white)
                            .copyWith(fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        width: Sizes.s8.w,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed(Routes.login),
                        child: Text(
                          'Login',
                          style: getSemiBoldStyle(color: ColorManager.white)
                              .copyWith(fontSize: FontSize.s16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
    _phoneController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }
}
