import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/entry/midddle_issues_data.dart';
import 'package:gitbbs/ui/main/home/action.dart';

class LoadMiddleComponent extends Component<MiddleIssuesData> {
  LoadMiddleComponent() : super(view: _buildView);
}

Widget _buildView(
  MiddleIssuesData middleIssueData,
  Dispatch dispatch,
  ViewService viewService,
) {
  return GestureDetector(
    onTap: () {
      if (!middleIssueData.refreshing) {
        dispatch(PageActionCreator.loadMiddleDataAction(middleIssueData));
      }
    },
    child: Container(
      height: 40,
      child: Center(
        child: middleIssueData.refreshing ? CircularProgressIndicator(strokeWidth: 3,):Text(
          '点击加载更多',
          style: TextStyle(color: app_primary),
        ),
      ),
    ),
  );
}
