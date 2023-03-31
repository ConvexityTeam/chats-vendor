import 'package:flutter/material.dart';

OverlayEntry showOverlay(BuildContext context, Widget child) {
  OverlayState? oState = Overlay.of(context);

  OverlayEntry entry = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.7),
            ),
          ),
          child
        ],
      );
    },
    opaque: false,
  );

  oState.insert(entry);
  return entry;
}
