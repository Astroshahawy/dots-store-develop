import 'package:dots/app/components/card_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';

class ExpandableWidget extends StatelessWidget {
  const ExpandableWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpandablePanel(
          header: Text(title, style: Theme.of(context).textTheme.titleMedium)
              .boldGx(),
          collapsed: Text(
            description,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          expanded: Text(
            description,
            softWrap: true,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          theme: const ExpandableThemeData(
            tapHeaderToExpand: true,
            hasIcon: true,
          ),
        ),
      ),
    );
  }
}
