import 'package:client/core/theme/app_pallet.dart';
import 'package:client/core/theme/loading.dart';
import 'package:client/features/auth/modelview/auth_viewmodel.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widget/custom_button.dart';
import 'package:client/features/auth/view/widget/custom_field.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: isLoading
          ? Loading()
          : ListView(
              padding: const EdgeInsets.only(top: 20),
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/signin_image.png',
                          height: 250,
                        ),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: 'Email',
                          icon: Icons.email,
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: 'Password',
                          icon: Icons.lock,
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          buttonText: 'Sign In',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final authViewModel =
                                  ref.read(authViewModelProvider.notifier);

                              final response = await authViewModel.logIn(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              if (response['success'] == true) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Pallete.borderColor,
                                    content: Center(
                                      child: Text(
                                        response['errorMessage'] ??
                                            'Unknown error occurred.',
                                        style: TextStyle(
                                            color: Pallete.whiteColor),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Pallete.gradient1,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
