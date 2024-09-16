import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/core/theme/app_colors.dart';
import 'package:news_app/src/domain/entity/news_topic.dart';
import 'package:news_app/src/presentation/news_list/providers/news_topic_provider.dart';
import 'package:wheel_picker/wheel_picker.dart';

class TopicSelector extends ConsumerWidget {
  const TopicSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsTopic = ref.watch(newsTopicStateProvider);
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => NewsTopicSelectDialog(),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              newsTopic.name.toUpperCase(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

class NewsTopicSelectDialog extends ConsumerWidget {
  NewsTopicSelectDialog({super.key});
  final items = NewsTopic.values.toList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsTopicNotifier = ref.watch(newsTopicStateProvider.notifier);
    final indexNotifier = ref.watch(_selectedIndexProvider.notifier);
    final selectedIndex = ref.watch(_selectedIndexProvider);
    final textTheme = Theme.of(context).textTheme.titleLarge;

    return Dialog.fullscreen(
      backgroundColor: Colors.black.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                newsTopicNotifier.state = items[selectedIndex];
                context.pop();
              },
              child: Text(
                'Done',
                textAlign: TextAlign.end,
                style: textTheme?.apply(color: AppColors.white),
              ),
            ),
            Expanded(
              child: WheelPicker(
                  looping: false,
                  initialIndex: selectedIndex,
                  itemCount: items.length,
                  selectedIndexColor: AppColors.white,
                  builder: (context, index) => Text(
                        items[index].name.toUpperCase(),
                        style: textTheme.apply(color: AppColors.gray),
                      ),
                  onIndexChanged: (index) {
                    indexNotifier.state = index;
                    // newsTopicNotifier.state = items[index];
                  },
                  style: WheelPickerStyle(
                    itemExtent: textTheme!.fontSize! * textTheme.height!, // Text height
                    // squeeze: 1.55,
                    // diameterRatio: .8,
                    // surroundingOpacity: .25,
                    // magnification: 1.2,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

final _selectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});
