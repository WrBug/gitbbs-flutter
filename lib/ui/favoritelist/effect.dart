import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/UserCacheManager.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/ui/favoritelist/action.dart';
import 'package:gitbbs/ui/favoritelist/state.dart';

Effect<FavoriteListState> buildEffect() {
  return combineEffects(<Object, Effect<FavoriteListState>>{
    Lifecycle.initState: _init,
    FavoriteListAction.refreshData: _refreshData
  });
}

void _init(Action action, Context<FavoriteListState> ctx) async {
  var list = await UserCacheManager.getFavoriteList();
  ctx.dispatch(FavoriteListActionCreator.updateDataAction(list));
}

void _refreshData(Action action, Context<FavoriteListState> ctx) async {
  GitHttpRequest request = GitHttpRequest.getInstance();
  await request.getFavoriteGist();
  var list = await UserCacheManager.getFavoriteList();
  ctx.dispatch(FavoriteListActionCreator.updateDataAction(list));
}
