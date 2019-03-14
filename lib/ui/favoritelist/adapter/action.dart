import 'package:fish_redux/fish_redux.dart';

enum FavoriteItemAction { getDetail }

class FavoriteItemActionCreator {
  static Action getDetailAction() => const Action(FavoriteItemAction.getDetail);
}
