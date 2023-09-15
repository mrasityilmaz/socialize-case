import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';

class CustomPageRefreshIndicator extends StatelessWidget {
  const CustomPageRefreshIndicator({required this.onRefresh, required this.child, super.key});
  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CheckMarkIndicator(
      onRefresh: onRefresh,
      child: child,
    );
  }
}

class CheckMarkIndicator extends StatefulWidget {
  const CheckMarkIndicator({
    required this.child,
    required this.onRefresh,
    super.key,
  });
  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  _CheckMarkIndicatorState createState() => _CheckMarkIndicatorState();
}

class _CheckMarkIndicatorState extends State<CheckMarkIndicator> with SingleTickerProviderStateMixin {
  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        return Future.delayed(
          const Duration(milliseconds: 500),
          () async {
            await widget.onRefresh();
          },
        );
      },
      offsetToArmed: kMinInteractiveDimension,
      onStateChanged: (change) {
        if (change.currentState == IndicatorState.armed) {
          HapticFeedback.lightImpact();
        }
      },
      child: widget.child,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        double animValue = controller.value;
        if (animValue > 1.0) {
          animValue = 1.0;
        } else if (animValue < 0.0) {
          animValue = 0.0;
        }

        return Column(
          children: <Widget>[
            if (!controller.isIdle) ...[
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  height: kMinInteractiveDimension * 1.2 * animValue,
                  child: controller.isLoading
                      ? CupertinoActivityIndicator(
                          color: context.colors.primary,
                          radius: 13,
                        )
                      : CupertinoActivityIndicator.partiallyRevealed(
                          color: context.colors.primary,
                          progress: animValue,
                          radius: 13,
                        ),
                ),
              ),
            ],
            Expanded(
              child: child,
            ),
          ],
        );
      },
    );
  }
}
