import 'package:auto_route/auto_route.dart';
import 'package:dateballon/components/errorDialog.dart';
import 'package:dateballon/components/loginFunc.dart';
import 'package:dateballon/route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
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
                    print("error");
                    showDialog(
                      context: context,
                      builder: (context) => const ErrorDialog(
                          message: "メールアドレスまたはパスワードの形式が正しくありません"),
                    );
                    return;
                  }
                  try {
                    final email = emailController.text.trim();
                    final response = await signUp(
                      email,
                      passwordController.text.trim(),
                    );
                    final calenderlist = await supabase
                        .from('calenders_lists')
                        .select()
                        .eq('user_id', response!.user!.id)
                        .maybeSingle();
                    await supabase.from('users').upsert({
                      'user_id': response.user!.id,
                      'mail': email,
                    }, onConflict: 'mail', ignoreDuplicates: true);
                    if (calenderlist == null) {
                      await supabase
                          .from('calenders_lists')
                          .insert(
                            {'user_id': response.user!.id},
                          )
                          .select()
                          .single();
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SimpleDialog(
                          title: Text('確認'),
                          children: [
                            Text('Supabase Authから認証メールを配信しました'),
                          ],
                        );
                      },
                    );
                    context.router.replace(const BottombarRoute());
                  } catch (e) {
                    print(e);
                    showDialog(
                      context: context,
                      builder: (context) => const ErrorDialog(
                        message: "SignUpに失敗しました",
                      ),
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
