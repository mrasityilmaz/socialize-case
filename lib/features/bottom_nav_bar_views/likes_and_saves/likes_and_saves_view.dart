import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/likes_and_saves/likes_and_saves_viewmodel.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:my_coding_setup/features/components/infinite_scroll/infinite_scroll.dart';
import 'package:my_coding_setup/features/components/widgets/post_widget/post_widget.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';
import 'package:provider/provider.dart';

final class LikesAndSavesView extends StatefulWidget {
  const LikesAndSavesView({super.key});

  @override
  State<LikesAndSavesView> createState() => _LikesAndSavesView();
}

class _LikesAndSavesView extends State<LikesAndSavesView> {
  @override
  Widget build(BuildContext context) {
    final LikesAndSavesViewModel viewModel = context.read<LikesAndSavesViewModel>();
    final bool isLoadingMore = context.select<LikesAndSavesViewModel, bool>((value) => value.busy(value.refreshIndicatorKey));
    final List<PostModel> items = context.select<LikesAndSavesViewModel, List<PostModel>>((value) => value.posts);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomTextWidget(
          text: 'Likes and Saves',
          style: CustomTextStyleEnum.s16w600,
        ),
      ),
      body: CustomViewModelBuilder<LikesAndSavesViewModel>(
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
                                    viewModel.removePostFromList(currentData.id);
                                  },
                                  onSave: () {
                                    viewModel.addPostToList(currentData);
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
                            viewModel.removePostFromList(currentData.id);
                          },
                          onSave: () {
                            viewModel.addPostToList(currentData);
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
}
