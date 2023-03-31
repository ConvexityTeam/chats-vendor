import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyDialog extends StatelessWidget {
  PolicyDialog({Key? key, this.radius = 8, required this.mdFileName})
      : assert(mdFileName.contains('.md'),
            "The file must contain the .md extension"),
        super(key: key);
  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(
                Duration(milliseconds: 150),
              ).then((value) => rootBundle.loadString('assets/$mdFileName')),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data as String);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TEXT(
              text: 'Ok',
            ),
          )
        ],
      ),
    );
  }
}
