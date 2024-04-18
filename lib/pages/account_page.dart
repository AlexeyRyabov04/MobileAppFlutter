import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/my_row.dart';
import 'package:mobileapp/services/UserService.dart';

import '../components/my_button.dart';
import '../models/user_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController nickController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fillFields();
  }

  Future<void> fillFields() async{
    UserService userService = UserService();
    Person person = await userService.getFields();
    setState(() {
      nickController.text = person.nick;
      nameController.text = person.name;
      surnameController.text = person.surname;
      phoneController.text = person.phone;
    });
  }
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Длительность отображения предупреждения
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyRow(controller: nickController,
              hintText: 'Введите ник',
              labelText: 'Ник:'),
          MyRow(controller: nameController,
              hintText: 'Введите имя',
              labelText: 'Имя:'),
          MyRow(controller: surnameController,
              hintText: 'Введите фамилию',
              labelText: 'Фамилия:'),
          MyRow(controller: phoneController,
              hintText: 'Введите номер телефона',
              labelText: 'Телефон:'),
          const SizedBox(height: 16),
          MyButton(onClick: () {
            UserService userService = UserService();
            userService.saveChanges(nickController.text,
                nameController.text,
                surnameController.text,
                phoneController.text);
            showSnackBar(context, 'Данные сохранены');
          },
              text: "Сохранить изменеия"),
        ],
      ),
    );
  }
}
