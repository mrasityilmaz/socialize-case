import 'package:flutter/material.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/likes_and_saves/likes_and_saves_viewmodel.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/widgets/post_widget/post_widget.dart';
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

    final List<PostModel> items = context.select<LikesAndSavesViewModel, List<PostModel>>((value) => value.posts);

    return Scaffold(
      body: CustomViewModelBuilder<LikesAndSavesViewModel>(
        onViewModelReady: () async {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await viewModel.init();
          });
        },
        child: SafeArea(
          bottom: false,
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
                        child: PostWidget(
                          postModel: currentData,
                          onRemove: () {
                            viewModel.removePostFromList(currentData.id);
                          },
                          onSave: () {
                            viewModel.addPostToList(currentData);
                          },
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
    );
  }
}
