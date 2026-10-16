import 'package:flutter/material.dart';
import 'auth_widgets.dart';

PreferredSizeWidget kheloxAppBar({List<Widget> actions = const []}) {
  return AppBar(
    titleSpacing: 16,
    title: const Row(
      children: [
        KheloxLogo(size: 34),
        SizedBox(width: 10),
        Text(
          'KheloX',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
      ],
    ),
    actions: [...actions, const SizedBox(width: 12)],
  );
}