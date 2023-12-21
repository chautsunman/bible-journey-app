import 'package:bible_journey_app/app_components/app_extensions.dart';
import 'package:flutter/material.dart';

class TypeColorBlock extends StatelessWidget {
  const TypeColorBlock({Key? key, required this.color, this.onClick}) : super(key: key);

  final String color;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onClick != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          width: 10.0,
          height: 10.0,
          color: HexColor.fromHex(color),
        ),
      ),
    );
  }
}

class TypeColor extends StatelessWidget {
  const TypeColor({Key? key, required this.type, required this.color, this.onClick}) : super(key: key);

  final String type;
  final String color;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(type),
        const SizedBox(width: 8),
        TypeColorBlock(
          color: color,
          onClick: onClick,
        ),
      ],
    );
  }
}

