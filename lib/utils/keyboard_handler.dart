import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class KeyboardHandler extends StatefulWidget {
  final Widget child;
  final Function() onShake;

  const KeyboardHandler({
    super.key,
    required this.child,
    required this.onShake,
  });

  @override
  State<KeyboardHandler> createState() => _KeyboardHandlerState();
}

class _KeyboardHandlerState extends State<KeyboardHandler> {
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        widget.onShake();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: widget.child,
    );
  }
}