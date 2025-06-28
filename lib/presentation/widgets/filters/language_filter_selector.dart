import 'package:flutter/material.dart';

class LanguageFilterSelector extends StatefulWidget {
  const LanguageFilterSelector({
    super.key,
    required this.selectedLanguages,
    required this.onSelectionChanged,
  });

  final List<String> selectedLanguages;
  final ValueChanged<List<String>> onSelectionChanged;

  @override
  State<LanguageFilterSelector> createState() => _LanguageFilterSelectorState();
}

class _LanguageFilterSelectorState extends State<LanguageFilterSelector> {
  late List<String> _selectedLanguages;
  final List<String> allLanguages = ['EN', 'DE'];

  @override
  void initState() {
    super.initState();
    _selectedLanguages = List.from(
      widget.selectedLanguages.map((e) => e.toUpperCase()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Host Languages'),
      children: [
        CheckboxListTile(
          title: const Text('Any'),
          value: _selectedLanguages.isEmpty,
          onChanged: (_) {
            setState(() {
              _selectedLanguages.clear();
              widget.onSelectionChanged([]);
            });
          },
        ),
        ...allLanguages.map((lang) {
          final isSelected = _selectedLanguages.contains(lang);
          return CheckboxListTile(
            value: isSelected,
            title: Text(lang),
            onChanged: (val) {
              setState(() {
                if (val == true) {
                  _selectedLanguages.add(lang);
                } else {
                  _selectedLanguages.remove(lang);
                }
                widget.onSelectionChanged(_selectedLanguages);
              });
            },
          );
        }),
      ],
    );
  }
}
