import 'package:flutter/material.dart';
import 'package:mobileapp/services/AuthService.dart';
import 'package:mobileapp/components/my_button.dart';
import 'package:mobileapp/components/my_textfield.dart';
import 'package:mobileapp/services/UserService.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onClick;

  RegisterPage({
    super.key,
    required this.onClick
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController = TextEditingController();

void register() async{
  final _authService = AuthService();
  if (passwordController.text == retypePasswordController.text){
    try{
      await _authService.signUp(emailController.text, passwordController.text);
      UserService userService = UserService();
      userService.createUser(emailController.text);
    }
    catch(e){
      showDialog(context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }
  else{
    showDialog(context: context,
        builder: (context) => const AlertDialog(
          title: Text("Пароли не совпадают!"),
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
                    "Регистрация",
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
                MyTextField(
                    controller: retypePasswordController,
                    hintText: "Повторите пароль",
                    obscureText: true
                ),
                const SizedBox(height: 25),
                MyButton(
                    onClick: () {
                      register();
                       },
                    text: "Регистрация"
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Есть аккаунт? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onClick,
                      child: Text(
                          "Войти",
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