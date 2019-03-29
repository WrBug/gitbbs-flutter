import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class HeaderComponent extends Component {
  HeaderComponent() : super(view: _buildView);
}

Widget _buildView(
  Object gitIssue,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Padding(
    padding: EdgeInsets.all(8),
  );
}
