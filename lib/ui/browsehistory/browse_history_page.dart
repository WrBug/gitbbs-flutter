import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/browsehistory/adapter.dart';
import 'package:gitbbs/ui/browsehistory/reducer.dart';
import 'package:gitbbs/ui/browsehistory/effect.dart';
import 'package:gitbbs/ui/browsehistory/state.dart';
import 'view.dart';

class BrowseHistoryPage extends Page<BrowseHistoryPageState, dynamic> {
  BrowseHistoryPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BrowseHistoryPageState>(
              adapter: BrowseHistoryListAdapter()),
        );

  static Future start(BuildContext context) async {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BrowseHistoryPage().buildPage(null)));
  }
}
