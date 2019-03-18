import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';
import 'package:gitbbs/model/event/refresh_list_event.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/ui/favoritelist/action.dart';
import 'package:gitbbs/ui/favoritelist/state.dart';
import 'package:gitbbs/util/event_bus_helper.dart';

Effect<FavoriteListState> buildEffect() {
  return combineEffects(<Object, Effect<FavoriteListState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    FavoriteListAction.refreshData: _refreshData
  });
}

void _init(Action action, Context<FavoriteListState> ctx) async {
  EventBusHelper.on<LoadFavoriteListEvent>().listen((event) {
    _loadList(ctx);
  });
  _loadList(ctx);
}

void _dispose(Action action, Context<FavoriteListState> ctx) {
}
void _loadList(Context<FavoriteListState> ctx) async {
  var list = await UserCacheManager.getFavoriteList();
  ctx.dispatch(FavoriteListActionCreator.updateDataAction(list));
}

void _refreshData(Action action, Context<FavoriteListState> ctx) async {
  GitHttpRequest request = GitHttpRequest.getInstance();
  await request.getFavoriteGist();
  var list = await UserCacheManager.getFavoriteList();
  ctx.dispatch(FavoriteListActionCreator.updateDataAction(list));
}
