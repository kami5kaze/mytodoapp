import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<AuthResponse?> signUp(String email, String password) async {
  final response = await supabase.auth.signUp(email: email, password: password);
  if (response.user != null) {
    print('Signed up successfully');
    return response;
  } else {
    print('Failed to sign up');
    return null;
  }
}

Future<AuthResponse?> signIn(String email, String password) async {
  final response =
      await supabase.auth.signInWithPassword(email: email, password: password);
  if (response.user != null) {
    print('Signed in successfully');
    print(response.user);
    return response;
  } else {
    print('Failed to sign in');
    return null;
  }
}

Future<void> signOut() async {
  await supabase.auth.signOut();

  print('Signed out');
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  return password.length >= 6;
}
