import 'package:auto_route/auto_route.dart';
import 'package:dateballon/components/errorDialog.dart';
import 'package:dateballon/route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<bool> signUp(String email, String password) async {
  final response = await supabase.auth.signUp(email: email, password: password);
  if (response.user != null) {
    print('Signed up successfully');
    return true;
  } else {
    print('Failed to sign up');
    return false;
  }
}

Future<bool> signIn(String email, String password) async {
  final response =
      await supabase.auth.signInWithPassword(email: email, password: password);
  if (response.user != null) {
    print('Signed in successfully');
    print(response.user);
    return true;
  } else {
    print('Failed to sign in');
    return false;
  }
}

Future<void> signOut() async {
  await supabase.auth.signOut();
  print('Signed out');
}

//メール：kami@icloud.com
//pass: kami1234
class SignInFunc extends StatelessWidget {
  const SignInFunc({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Dialog(
      child: SizedBox(
        height: 200,
        width: 400,
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
                    try {
                      final response = await signIn(
                          emailController.text, passwordController.text);
                      if (response == true) {
                        //bottombarFuncに遷移
                        context.replaceRoute(const BottombarFunc());
                      } else {
                        //エラー処理
                        showDialog(
                          context: context,
                          builder: (context) => const Errordialog(),
                        );
                      }
                    } catch (e) {
                      print(e);
                      showDialog(
                        context: context,
                        builder: (context) => const Errordialog(),
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

class SignUpFunc extends StatelessWidget {
  const SignUpFunc({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Dialog(
      child: SizedBox(
        height: 200,
        width: 400,
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
                  try {
                    final response = await signUp(
                        emailController.text, passwordController.text);
                    if (response == true) {
                      //bottombarFuncに遷移
                      context.replaceRoute(const BottombarFunc());
                    } else {
                      //エラー処理
                      showDialog(
                        context: context,
                        builder: (context) => const Errordialog(),
                      );
                    }
                  } catch (e) {
                    print(e);
                    showDialog(
                      context: context,
                      builder: (context) => const Errordialog(),
                    );
                  }
                },
                child: const Text('Sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
