import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../util/colors.dart';

class DividerWidget extends StatefulWidget {
  final double altura;
  const DividerWidget({Key? key, required this.altura}) : super(key: key);

  @override
  State<DividerWidget> createState() => _DividerWidgetState();
}

class _DividerWidgetState extends State<DividerWidget> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: ColorsProject.whiteSilverLow,
        ),
        width: 330.0,
        height: widget.altura,
      ),
    );
  }
}