import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/ui/login/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'view.dart';
class LoginPage extends Page<LoginPageState, dynamic> {
  LoginPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView);
}
