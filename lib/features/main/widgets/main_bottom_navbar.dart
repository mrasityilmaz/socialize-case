import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/features/main/main_viewmodel.dart';
import 'package:provider/provider.dart';

final class MainBottomNavbarWidget extends StatelessWidget {
  const MainBottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isBottomNavBarVisible = context.select<MainViewModel, bool>((value) => value.isBottomNavBarVisible);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Transform.translate(offset: Offset(0, isBottomNavBarVisible ? 0 : 100)).transform,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        padding: context.paddingNormalHorizontal,
        child: const SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _BottomBarButton(Icons.home, 0),

              _BottomBarButton(Icons.search, 1),
              SizedBox(width: 40), // The dummy child
              _BottomBarButton(Icons.bookmarks_rounded, 2),
              _BottomBarButton(CupertinoIcons.profile_circled, 3),
            ],
          ),
        ),
      ),
    );
  }
}

final class _BottomBarButton extends StatelessWidget {
  const _BottomBarButton(this.icon, this.index);
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    final MainViewModel viewModel = context.read<MainViewModel>();
    final int selectedIndex = context.select<MainViewModel, int>((value) => value.selectedIndex);

    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        viewModel.selectedIndex = index;
      },
      color: selectedIndex == index ? context.colors.primary : context.colors.onBackground.withOpacity(0.2),
      isSelected: selectedIndex == index,
    );
  }
}
