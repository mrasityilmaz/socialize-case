import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/core/utils/debouncer.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/search/search_viewmodel.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';
import 'package:my_coding_setup/features/components/widgets/text_field/text_field.dart';
import 'package:provider/provider.dart';

final class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer = Debouncer(milliseconds: 700);
    final SearchViewModel viewModel = context.read<SearchViewModel>();
    final bool isSearching = context.select<SearchViewModel, bool>((value) => value.isSearching);
    return Scaffold(
      appBar: AppBar(
        title: CustomTextFieldWidget(
          controller: viewModel.searchController,
          hintText: 'Search',
          onChanged: (p0) async {
            if (p0.trim().isNotEmpty) {
              viewModel.setIsSearching(true);
              debouncer.run(() async {
                await viewModel.search(p0);
              });
            } else {
              viewModel.setIsSearching(false);
            }
          },
          prefixIcon: Icon(Icons.search, color: context.colors.onBackground.withOpacity(.3)),
          suffixIcon: !isSearching
              ? null
              : GestureDetector(
                  onTap: () {
                    viewModel.searchController.clear();
                    viewModel.setIsSearching(false);
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.onBackground.withOpacity(.1),
                      borderRadius: context.borderRadiusLow * .5,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Center(
                        child: Icon(
                          CupertinoIcons.clear,
                          color: context.colors.onBackground.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
      body: const CustomViewModelBuilder<SearchViewModel>(child: SafeArea(child: _Body())),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final SearchViewModel viewModel = context.watch<SearchViewModel>();
    final List<UserDataModel> searchedUsers = context.select<SearchViewModel, List<UserDataModel>>((value) => value.searchedUsers);

    return CustomScrollView(
      slivers: [
        if (searchedUsers.isEmpty && !viewModel.isBusy) ...[
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.search,
                    size: context.mediaQuery.size.width * .2,
                  ),
                  const SizedBox(height: 10),
                  CustomTextWidget(text: 'Search for users', style: CustomTextStyleEnum.s20w500, textColor: context.colors.onBackground.withOpacity(.3)),
                ],
              ),
            ),
          ),
        ] else ...[
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverList.builder(
            itemBuilder: (context, index) {
              final UserDataModel user = searchedUsers[index];
              return Padding(
                padding: context.paddingNormalHorizontal + context.paddingLowBottom,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: context.borderRadiusLow,
                      child: Image.network(
                        user.profileImageUrl,
                        fit: BoxFit.cover,
                        height: kMinInteractiveDimension,
                        width: kMinInteractiveDimension,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextWidget(text: user.fullname ?? '', style: CustomTextStyleEnum.s16w500),
                            CustomTextWidget(text: '@${user.username}', style: CustomTextStyleEnum.s14w500, textColor: context.colors.onBackground.withOpacity(.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: searchedUsers.length,
          ),
        ],
      ],
    );
  }
}
