import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessageError extends StatefulWidget {
  final String text;
  const MessageError({Key? key, required this.text}) : super(key: key);

  @override
  State<MessageError> createState() => _MessageErrorState();
}

class _MessageErrorState extends State<MessageError> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 60,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            widget.text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}