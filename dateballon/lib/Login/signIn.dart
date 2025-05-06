import 'package:auto_route/auto_route.dart';
import 'package:dateballon/components/errorDialog.dart';
import 'package:dateballon/components/loginFunc.dart';
import 'package:dateballon/route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                controller: passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.trim().isEmpty ||
                        passwordController.text.trim().isEmpty ||
                        !isValidEmail(
                          emailController.text.trim(),
                        ) ||
                        !isValidPassword(passwordController.text.trim())) {
                      showDialog(
                        context: context,
                        builder: (context) => const ErrorDialog(
                          message: "メールアドレスまたはパスワードの形式が正しくありません",
                        ),
                      );
                      return;
                    }
                    try {
                      final response = await signIn(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                      if (response != null) {
                        //bottombarFuncに遷移
                        context.replaceRoute(const BottombarRoute());
                      } else {
                        //エラー処理
                        showDialog(
                          context: context,
                          builder: (context) => const ErrorDialog(
                            message: "認証が失敗しました",
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                      showDialog(
                        context: context,
                        builder: (context) => const ErrorDialog(
                          message: "SignInに失敗しました",
                        ),
                      );
                    }
                  },
                  child: const Text('Sign in')),
            ),
          ],
        ),
      ),
    );
  }
}
