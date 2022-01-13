import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          SizedBox(child: CircularProgressIndicator(), width: 24, height: 24,),
          SizedBox(width: 10,),
          Text('loading...')
        ],
      ),
    );
  }
}
