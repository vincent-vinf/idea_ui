import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:idea/entity/user.dart';
import 'package:idea/util/space_header.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _count = 4;
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      header: SpaceHeader(),
      footer: BezierBounceFooter(),
      onRefresh: () async {},
      onLoad: () async {},
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GFListTile(
                avatar: GFAvatar(
                  // backgroundImage: AssetImage(
                  //     user == null ? UserHolder.blankUser.avatar : user!.avatar),
                  backgroundImage: AssetImage(UserHolder.blankUser.avatar),
                  size: GFSize.SMALL,
                ),
                titleText: "fas",
              );
            },
            childCount: _count,
          ),
        ),
      ],
    );
  }
}
