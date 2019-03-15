import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/main/home/effect.dart';
import 'package:gitbbs/ui/main/home/item/adapter.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';
import 'package:gitbbs/ui/main/home/reducer.dart';
import 'view.dart';

class HomePage extends Page<PageState, GlobalKey<ScaffoldState>> {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PageState>(
              adapter: IssueListAdapter(),
              slots: <String, Dependent<PageState>>{}),
        );
}
