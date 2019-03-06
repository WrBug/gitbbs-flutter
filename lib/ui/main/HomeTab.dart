import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/widget/AvatarImg.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';

class HomeTab extends StatefulWidget {
  List<GitIssue> list = new List();
  GitHttpRequest request = GithubHttpRequest.getInstance();

  @override
  State<StatefulWidget> createState() => _HomeTab();
}

class _HomeTab extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  bool hasNext = false;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('_HomeTab initState');
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      key: _easyRefreshKey,
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.all(10),
            );
          }
          if (index.isOdd) {
            int position = index ~/ 2;
            var gitIssue = widget.list[position];
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    gitIssue.getTitle(),
                    maxLines: 2,
                    style: TextStyle(
                        color: text_title_color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  _bottomInfoBuild(gitIssue)
                ],
              ),
            );
          }
          return Divider();
        },
        itemCount: widget.list.length * 2,
      ),
      autoLoad: hasNext,
      refreshHeader: BezierCircleHeader(
        key: _headerKey,
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
      ),
      refreshFooter: BezierBounceFooter(
        key: _footerKey,
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
      ),
      onRefresh: () {
        widget.request.getIssues(state: IssueState.ALL).then((PagingData data) {
          setState(() {
            widget.list = data.data;
            hasNext = data.hasNext;
          });
        });
      },
      loadMore: hasNext
          ? () {
        if (!hasNext) {
          return;
        }
        widget.request
            .getIssues(
            state: IssueState.ALL,
            after: widget.list.last.getCursor())
            .then((data) {
          setState(() {
            widget.list.addAll(data.data);
            hasNext = data.hasNext;
          });
        });
      }
          : null,
    );
  }

  _bottomInfoBuild(GitIssue gitIssue) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AvatarImg(
              gitIssue.getAuthor().getAvatarUrl(),
              radius: 8,
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
            Text(
              gitIssue.getAuthor().getName(),
              style: TextStyle(fontSize: 12),
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
            Text(
              '${gitIssue.getCommentsCount()} 评论',
              style: TextStyle(fontSize: 12),
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
            Text(
              TimelineUtil.formatByDateTime(
                  DateTime.parse(gitIssue.getCreateTime()),
                  dayFormat: DayFormat.Full),
              style: TextStyle(fontSize: 12),
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
