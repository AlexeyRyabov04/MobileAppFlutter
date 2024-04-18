import 'package:flutter/material.dart';
import 'package:mobileapp/components/my_button.dart';
import 'package:mobileapp/components/my_textfield.dart';

import '../services/AuthService.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onClick;

  const LoginPage({
    super.key,
    required this.onClick
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async{
    final _authService = AuthService();
    try{
      await _authService.signIn(emailController.text, passwordController.text);
    }
    catch(e){
      showDialog(context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "Вход в аккаунт",
                style: TextStyle(
                fontSize: 40,
              )
            ),
            const SizedBox(height: 25),

            MyTextField(
                controller: emailController,
                hintText: "Введите почту",
                obscureText: false
            ),
            const SizedBox(height: 25),
            MyTextField(
                controller: passwordController,
                hintText: "Введите пароль",
                obscureText: true
            ),
            const SizedBox(height: 25),
            MyButton(
                onClick: login,
                text: "Войти"
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Нет аккаунта? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18
                  ),
                ),
                GestureDetector(
                  onTap: widget.onClick,
                  child: Text(
                    "Зарегистрироваться",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                  ),
                )
              ],
            )
          ],
        )
      )
    );
  }
}