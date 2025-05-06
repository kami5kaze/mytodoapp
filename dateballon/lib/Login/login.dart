import 'package:auto_route/auto_route.dart';
import 'package:dateballon/route/auto_route.dart';
import 'package:flutter/material.dart';

//メール：kami1234@gmail.com
//pass: kami1234

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  context.router.push(const SignInRoute());
                },
                child: const Text('Sign in'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  context.router.push(const SignUpRoute());
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
