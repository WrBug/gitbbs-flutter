import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class DivideComponent extends Component {
  DivideComponent() : super(view: _buildView);
}

Widget _buildView(
  Object gitIssue,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Divider();
}
