import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/ui/screen/sight_search/redux/actions.dart';
import 'package:places/ui/screen/sight_search/redux/search_state.dart';

class HistoryListTile extends StatelessWidget {
  final String title;

  const HistoryListTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<SearchState, VoidCallback>(
      converter: (store) {
        return () => store.dispatch(FetchPlacesAction(request: title));
      },
      builder: (ctx, callback) {
        return ListTile(
          onTap: callback,
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.secondary2Kit),
          ),
          trailing: StoreConnector<SearchState, VoidCallback>(
            converter: (store) {
              return () =>
                  store.dispatch(RemovePlaceFromHistoryAction(name: title));
            },
            builder: (ctx, callback) {
              return IconButton(
                onPressed: callback,
                icon: const Icon(
                  Icons.clear,
                  color: AppColors.secondary2Kit,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
