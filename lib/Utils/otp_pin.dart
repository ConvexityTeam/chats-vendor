library pin_entry_text_field;

import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// library pin_entry_text_field;

class OTPPin extends StatefulWidget {
  final String? lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  OTPPin(
      {this.lastPin,
      this.fields: 4,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  State createState() {
    return OTPPinState();
  }
}

class OTPPinState extends State<OTPPin> {
  List<String>? _pin;
  List<FocusNode>? _focusNodes;
  List<TextEditingController>? _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String>.generate(widget.fields, (_) => '', growable: true);
    _focusNodes = List<FocusNode>.generate(widget.fields, (_) => FocusNode(),
        growable: true);
    _textControllers = List<TextEditingController>.generate(
        widget.fields, (_) => TextEditingController(),
        growable: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin!.length; i++) {
            _pin![i] = widget.lastPin![i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers?.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    // ignore: unnecessary_null_comparison
    if (_pin!.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes?[0]); // [0] - edited
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: textFields,
    );
  }

  void clearTextFields() {
    _textControllers!.forEach(
        (TextEditingController tEditController) => tEditController.clear());
    _pin!.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (_focusNodes?[i] == null) {
      _focusNodes![i] = FocusNode();
    }
    // ignore: unnecessary_null_comparison
    if (_textControllers?[i] == null) {
      _textControllers![i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers?[i].text = widget.lastPin![i];
      }
    }

    _focusNodes![i].addListener(() {
      if (_focusNodes![i].hasFocus) {}
    });

    final String lastDigit = _textControllers![i].text;

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers?[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        cursorColor: Constants.usedGreen,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: widget.fontSize,
        ),
        focusNode: _focusNodes?[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
            counterText: "",
            focusedBorder: new UnderlineInputBorder(
                borderSide: BorderSide(color: Constants.usedGreen)),
            border: widget.showFieldAsBox
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.0, color: Constants.usedGreen))
                : null),
        onChanged: (String str) {
          setState(() {
            _pin?[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes![i].unfocus();
            // ignore: unnecessary_null_comparison
            if (lastDigit != null && _pin?[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes![i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes![i + 1]);
            }
          } else {
            _focusNodes![i].unfocus();
            // ignore: unnecessary_null_comparison
            if (lastDigit != null && _pin![i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes![i - 1]);
            }
          }
          // ignore: unnecessary_null_comparison
          if (_pin!.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin!.join());
          }
        },
        onSubmitted: (String str) {
          // ignore: unnecessary_null_comparison
          if (_pin!.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin?.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}
