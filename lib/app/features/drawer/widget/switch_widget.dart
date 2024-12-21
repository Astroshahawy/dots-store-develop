import 'package:flutter/material.dart';

import '../../../components/switcher_widget.dart';

class ToggleSection extends StatelessWidget {
  const ToggleSection({
    Key? key,
    required this.onToggle,
    required this.initIndex,
    required this.title,
    required this.icon,
    required this.firstElementTitle,
    required this.secondElementTitle,
  }) : super(key: key);
  final void Function(int?) onToggle;
  final int initIndex;
  final String title;
  final String firstElementTitle;
  final String secondElementTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // final locale = context.locale.languageCode;
    // final initLang = locale.contains('ar') ? 0 : 1;
    // final localeState = useState<int>(initLang);
    return ListTile(
      // leading: Icon(
      //   icon,
      //   color: Theme.of(context).colorScheme.primary,
      // ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      visualDensity: VisualDensity.compact,
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      trailing:
          // ToggleSection(
          //   onToggle: onToggle,
          //   initIndex: initIndex,
          //   title: title,
          //   icon: icon,
          //   firstElementTitle: firstElementTitle,
          //   secondElementTitle: secondElementTitle,
          // )
          SwitcherWidget(
        firstElement: firstElementTitle,
        secondElement: secondElementTitle,
        onToggle: onToggle,
        initialLabelIndex: initIndex,
      ),
    );
  }
}
