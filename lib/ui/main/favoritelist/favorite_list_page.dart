import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/main/favoritelist/adapter/favorite_list_adapter.dart';
import 'package:gitbbs/ui/main/favoritelist/effect.dart';
import 'package:gitbbs/ui/main/favoritelist/reducer.dart';
import 'package:gitbbs/ui/main/favoritelist/state.dart';
import 'view.dart';

class FavoriteListPage
    extends Page<FavoriteListState, GlobalKey<ScaffoldState>> {
  FavoriteListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FavoriteListState>(
                adapter: FavoriteListAdapter(),
                slots: <String, Dependent<FavoriteListState>>{}));
}
