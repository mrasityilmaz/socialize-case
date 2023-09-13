import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:svg_flutter/svg.dart';

class SignScreenBackgroundDesignWidget extends StatelessWidget {
  const SignScreenBackgroundDesignWidget({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/logos/back.svg',
            fit: BoxFit.cover,
            height: context.mediaQuery.size.height,
          ),
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  'assets/logos/front.svg',
                ),
              ),
              Container(
                margin: context.paddingNormalTop,
                decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: context.borderRadiusNormal.topLeft), color: Colors.white),
                padding: context.paddingNormalHorizontal * 2 + context.paddingNormalTop * 2 + context.paddingLowBottom + EdgeInsets.only(bottom: context.mediaQuery.viewPadding.bottom),
                child: child,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
