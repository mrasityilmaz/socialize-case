import 'package:flutter/material.dart';

class ScrollEndListener extends StatelessWidget {
  const ScrollEndListener({required this.child, super.key, this.onScrollEnd});
  final Widget child;
  final void Function()? onScrollEnd;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (!notification.metrics.atEdge || notification.metrics.pixels == 0) {
          return true;
        }

        onScrollEnd?.call();

        return true;
      },
      child: child,
    );
  }
}
