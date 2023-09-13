import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:provider/provider.dart';

class CustomViewModelBuilder<T extends BusyAndErrorStateHelper> extends StatelessWidget {
  const CustomViewModelBuilder({
    required this.child,
    super.key,
    this.circularProgressIndicator,
  });

  final Widget child;

  final Widget? circularProgressIndicator;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (context.select<T, bool>((value) => value.initialised)) ...[
          child,
        ],
        if (context.select<T, bool>((value) {
          return value.isBusy;
        })) ...[
          Center(child: circularProgressIndicator ?? const CircularProgressIndicator.adaptive()),
        ],
      ],
    );
  }
}
