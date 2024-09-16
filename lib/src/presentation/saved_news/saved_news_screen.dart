import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/src/core/common_widgets/news_card.dart';
import 'package:news_app/src/core/theme/app_colors.dart';
import 'package:news_app/src/presentation/news_list/widgets/scroll_button.dart';
import 'package:news_app/src/presentation/saved_news/providers/saved_news_list_provider.dart';
import 'package:news_app/src/presentation/saved_news/providers/view_mode_provider.dart';
import 'package:news_app/src/presentation/saved_news/widgets/news_list_tile.dart';

class SavedNewsScreen extends ConsumerStatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends ConsumerState<SavedNewsScreen> {
  final _pageController = PageController();
  final _transitionDuration = const Duration(milliseconds: 300);
  final _transitionCurve = Curves.easeInOut;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final savedNewsList = ref.watch(savedNewsListProvider);
    final viewModeNotifier = ref.watch(viewModeStateProvider.notifier);
    final viewMode = ref.watch(viewModeStateProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SAVED",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(),
                SegmentedButton<ViewMode>(
                  selected: <ViewMode>{viewMode},
                  showSelectedIcon: false,
                  onSelectionChanged: (Set<ViewMode> newSelection) {
                    viewModeNotifier.state = newSelection.first;
                  },
                  style: SegmentedButton.styleFrom(
                    visualDensity: const VisualDensity(vertical: -1, horizontal: -3),
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: AppColors.veryLightGray,
                    foregroundColor: AppColors.darkGray,
                    selectedForegroundColor: AppColors.darkGray,
                    selectedBackgroundColor: AppColors.primary,
                  ),
                  segments: const <ButtonSegment<ViewMode>>[
                    ButtonSegment<ViewMode>(value: ViewMode.list, icon: Icon(Icons.list_alt)),
                    ButtonSegment<ViewMode>(value: ViewMode.page, icon: Icon(Icons.view_agenda)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: switch (savedNewsList) {
              AsyncData(:final value) => value.isEmpty
                  ? Center(
                      child: Text(
                        "Looks like you haven't saved any news.\nExplore and save the stories that interest you!",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : viewMode == ViewMode.page
                      ? PageView.builder(
                          controller: _pageController,
                          itemCount: value.length,
                          scrollDirection: Axis.vertical,
                          allowImplicitScrolling: true,
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (index > 0)
                                ScrollButton(
                                  title: "Previous",
                                  icon: Icons.keyboard_double_arrow_up_rounded,
                                  onPressed: () {
                                    _pageController.previousPage(
                                      duration: _transitionDuration,
                                      curve: _transitionCurve,
                                    );
                                  },
                                ),
                              Expanded(
                                child: NewsCard(
                                  news: value[index],
                                  hideTopLine: index == 0,
                                  hideBottomLine: index == value.length - 1,
                                ),
                              ),
                              if (index < value.length - 1)
                                ScrollButton(
                                  title: "Next",
                                  icon: Icons.keyboard_double_arrow_down_rounded,
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: _transitionDuration,
                                      curve: _transitionCurve,
                                    );
                                  },
                                ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: value.length,
                          itemBuilder: (_, index) {
                            return NewsListTile(
                              news: value[index],
                              isSaved: true,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                        ),
              AsyncError() => const Center(child: Text('Oops, something unexpected happened')),
              _ => Center(
                  child: LoadingAnimationWidget.stretchedDots(
                    color: AppColors.darkGray,
                    size: 50,
                  ),
                ),
            },
          ),
        ],
      ),
    );
  }
}
