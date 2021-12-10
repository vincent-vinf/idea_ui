import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/entity/user.dart';
import 'package:idea/entity/user_info.dart';
import 'package:timelines/timelines.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // User user = getUser(widget.idea.userId);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // color: Colors.blueGrey,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 300.0,
              // color: Colors.white,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/test.jpg"),
                  fit: BoxFit.cover,
                ),
              ),

              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 100.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(4.0),
                      child: GFImageOverlay(
                        height: 100,
                        width: 100,
                        shape: BoxShape.circle,
                        image: AssetImage('assets/image/user.png'),
                        boxFit: BoxFit.cover,
                      ),
                    ))
                  ],

                  //        GFCard(
                  //     height: 350.0,
                  // boxFit: BoxFit.cover,
                  // showOverlayImage: true,
                  // imageOverlay: AssetImage("assets/image/test.jpg"),

                  // title: GFListTile(
                  //
                  //   avatar: GFAvatar(
                  //     backgroundImage: AssetImage("assets/image/user.jpg"),
                  //     // size: GFSize.SMALL,
                  //   ),
                  //   titleText: "思考者",
                  //   subTitle: Text("思考者"),
                  //   padding: EdgeInsets.all(0),
                  // ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(4.0),
                      height: 30.0,
                      child: Text(
                        "思考者1678288号",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      height: 20.0,
                      child: Text(
                        "思考者1678288号",
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ))
                  ],
                ),
                // Row(
                //   children: [
                //     Expanded(
                //         child: Container(
                //       alignment: Alignment.centerLeft,
                //       // width: 20.0,
                //       // height: 20.0,
                //       margin: const EdgeInsets.all(4.0),
                //       child: Text(
                //         "26",
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20.0),
                //       ),
                //     )),
                //     Expanded(
                //         child: Container(
                //       alignment: Alignment.centerLeft,
                //
                //       // width: 20.0,
                //       // height: 20.0,
                //       // margin: const EdgeInsets.all(4.0),
                //       child: Text(
                //         "10月",
                //         style: TextStyle(color: Colors.black, fontSize: 15.0),
                //       ),
                //     )),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //         child: GFCard(
                //       color: Colors.white30,
                //       height: 150.0,
                //       titlePosition: GFPosition.start,
                //       title: GFListTile(
                //         subTitle: Text("个人资料0%"),
                //       ),
                //       buttonBar: GFButtonBar(
                //         children: [
                //           GFButton(
                //             onPressed: () {},
                //             text: '点子',
                //           ),
                //         ],
                //       ),
                //     )),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //         child: GFCard(
                //       color: Colors.white,
                //       height: 200.0,
                //       content: Text(
                //           "hi~我是思考者1678288号,2021年12月6日是我降落的第1天.希望遇到和我同频率的脑电波~"),
                //       // title: GFListTile(
                //       //   title: Text("新人报道",style: TextStyle(color: Colors.black,fontSize: 15.0),),
                //       //   subTitle: Text("11:04:02公开",style: TextStyle(color: Colors.grey,fontSize: 10.0),),
                //       // ),
                //     )),
                //   ],
                // )
              ]),
            ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Timeline.tileBuilder(
                      builder: TimelineTileBuilder.fromStyle(
                    contentsAlign: ContentsAlign.alternating,
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('Timeline Event $index'),
                    ),
                    itemCount: 10,
                  )),
                ],
              ),

          ],
        ),
      ),
    );
  }
}
