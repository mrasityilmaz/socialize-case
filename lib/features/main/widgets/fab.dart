import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/enums/routes/routes_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/core/services/navigator_service.dart';
import 'package:my_coding_setup/features/main/main_viewmodel.dart';
import 'package:provider/provider.dart';

final class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isBottomNavBarVisible = context.select<MainViewModel, bool>((value) => value.isBottomNavBarVisible);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Transform.translate(offset: Offset(0, isBottomNavBarVisible ? 0 : kMinInteractiveDimension + 100)).transform,
      child: FloatingActionButton(
        onPressed: () {
          GoRouterService.instance.goRouter.pushNamed(RouteNames.createPost.name);
        },
        backgroundColor: context.colors.primary,
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.background, width: 2),
            borderRadius: context.borderRadiusLow,
          ),
          padding: context.paddingLow * .2,
          child: Icon(CupertinoIcons.add, color: context.colors.background),
        ),
      ),
    );
  }
}
