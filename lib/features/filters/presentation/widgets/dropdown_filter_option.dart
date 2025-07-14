import 'package:flutter/material.dart';

class DropdownFilterOption<T> extends StatelessWidget {
  const DropdownFilterOption({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
    required this.options,
    required this.labelBuilder,
  });

  final String title;
  final IconData icon;
  final T? value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: DropdownButton<T>(
        value: value,
        items:
            options.map((option) {
              return DropdownMenuItem<T>(
                value: option,
                child: Text(labelBuilder(option)),
              );
            }).toList(),
        onChanged: (selected) {
          if (selected != null) {
            onChanged(selected);
          }
        },
      ),
    );
  }
}
