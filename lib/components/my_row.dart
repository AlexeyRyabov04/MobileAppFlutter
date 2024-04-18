import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  const MyRow({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(labelText, style: const TextStyle(fontSize: 18),),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: hintText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
