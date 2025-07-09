import 'package:flutter/material.dart';

class DropdownFilterOption extends StatelessWidget {
  const DropdownFilterOption({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: DropdownButton<bool?>(
        value: value,
        items: const [
          DropdownMenuItem(value: null, child: Text('Any')),
          DropdownMenuItem(value: true, child: Text('Yes')),
          DropdownMenuItem(value: false, child: Text('No')),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
