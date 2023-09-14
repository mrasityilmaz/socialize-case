import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:provider/provider.dart';

class CustomViewModelBuilder<T extends BusyAndErrorStateHelper> extends StatefulWidget {
  const CustomViewModelBuilder({
    required this.child,
    super.key,
    this.circularProgressIndicator,
    this.onViewModelReady,
  });

  final FutureOr<void> Function()? onViewModelReady;

  final Widget child;

  final Widget? circularProgressIndicator;

  @override
  State<CustomViewModelBuilder<T>> createState() => _CustomViewModelBuilderState<T>();
}

class _CustomViewModelBuilderState<T extends BusyAndErrorStateHelper> extends State<CustomViewModelBuilder<T>> {
  @override
  void initState() {
    super.initState();

    _onReady();
  }

  Future<void> _onReady() async {
    await widget.onViewModelReady?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (context.select<T, bool>((value) => value.initialised)) ...[
          widget.child,
        ],
        if (context.select<T, bool>((value) {
          return value.isBusy;
        })) ...[
          Center(child: widget.circularProgressIndicator ?? const CircularProgressIndicator.adaptive()),
        ],
      ],
    );
  }
}
