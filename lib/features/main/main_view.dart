import 'package:flutter/material.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/home/home_view.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/likes_and_saves/likes_and_saves_view.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/profile/profile_view.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/search/search_view.dart';
import 'package:my_coding_setup/features/main/main_viewmodel.dart';
import 'package:my_coding_setup/features/main/widgets/fab.dart';
import 'package:my_coding_setup/features/main/widgets/main_bottom_navbar.dart';
import 'package:provider/provider.dart';

final class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainViewModel viewModel = context.read<MainViewModel>();

    return Scaffold(
      bottomNavigationBar: const MainBottomNavbarWidget(),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomFloatingActionButton(),
      body: Listener(
        onPointerMove: (asd) {
          if (asd.delta.dy > 2) {
            viewModel.isBottomNavBarVisible = false;
          } else if (asd.delta.dy < -2) {
            viewModel.isBottomNavBarVisible = true;
          }
        },
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: viewModel.pageController,
          children: const [
            HomeView(),
            SearchView(),
            LikesAndSavesView(),
            ProfileView(),
          ],
        ),
      ),
    );
  }
}
