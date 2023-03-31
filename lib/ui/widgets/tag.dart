import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Container tag(value) => Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: TEXT(
        fontStyle: FontStyle.normal,
        text: value,
        fontFamily: 'Gilroy-light',
        fontSize: 16,
        edgeInset: EdgeInsets.zero,
        color: value == 'processing'
            ? Color.fromRGBO(13, 21, 234, 1)
            : value == 'pending'
                ? Color.fromRGBO(112, 72, 49, 1)
                : value == 'completed'
                    ? Color.fromRGBO(51, 113, 56, 1)
                    : value == 'failed'
                        ? Color.fromRGBO(228, 44, 102, 1)
                        : value == 'disbursed'
                            ? Color.fromRGBO(100, 106, 134, 1)
                            : Colors.white,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: value == 'processing'
              ? Color.fromRGBO(182, 207, 255, 1)
              : value == 'pending'
                  ? Color.fromRGBO(255, 234, 182, 1)
                  : value == 'completed'
                      ? Color.fromRGBO(209, 247, 196, 1)
                      : value == 'failed'
                          ? Color.fromRGBO(255, 205, 199, 1)
                          : value == 'disbursed'
                              ? Color.fromRGBO(241, 241, 241, 1)
                              : Colors.greenAccent.shade700),
    );
