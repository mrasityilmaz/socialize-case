import 'package:flutter/material.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/home/home_viewmodel.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/likes_and_saves/likes_and_saves_viewmodel.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:my_coding_setup/features/components/infinite_scroll/infinite_scroll.dart';
import 'package:my_coding_setup/features/components/widgets/post_widget/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final List<PostModel> items = context.select<HomeViewModel, List<PostModel>>((value) => value.posts);
    final bool isLoadingMore = context.select<HomeViewModel, bool>((value) => value.busy(value.refreshIndicatorKey));
    super.build(context);
    final HomeViewModel viewModel = context.read<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: kToolbarHeight,
          child: FractionallySizedBox(
            heightFactor: .8,
            widthFactor: .5,
            child: SvgPicture.asset(
              'assets/logos/SOCIALIZE.svg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
      body: CustomViewModelBuilder<HomeViewModel>(
        onViewModelReady: () async {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await viewModel.init();
          });
        },
        child: SafeArea(
          bottom: false,
          child: ScrollEndListener(
            onScrollEnd: () async {
              await viewModel.loadMore();
            },
            child: CustomPageRefreshIndicator(
              onRefresh: () async {
                await viewModel.refresh();
              },
              child: CustomScrollView(
                controller: viewModel.scrollController,
                slivers: [
                  SliverList.builder(
                    itemBuilder: (context, index) {
                      final PostModel currentData = items[index];
                      if (index == items.length - 1) {
                        return SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: kMinInteractiveDimension),
                            child: Column(
                              children: [
                                PostWidget(
                                  postModel: currentData,
                                  onRemove: () {
                                    context.read<LikesAndSavesViewModel>().removePostFromList(currentData.id);
                                  },
                                  onSave: () {
                                    context.read<LikesAndSavesViewModel>().addPostToList(currentData);
                                  },
                                ),
                                if (isLoadingMore) ...[
                                  const CircularProgressIndicator.adaptive(),
                                ],
                              ],
                            ),
                          ),
                        );
                      } else {
                        return PostWidget(
                          postModel: currentData,
                          onRemove: () {
                            context.read<LikesAndSavesViewModel>().removePostFromList(currentData.id);
                          },
                          onSave: () {
                            context.read<LikesAndSavesViewModel>().addPostToList(currentData);
                          },
                        );
                      }
                    },
                    itemCount: items.length,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
