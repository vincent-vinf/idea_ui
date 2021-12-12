import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/sort.dart';

class IdeaSort extends StatefulWidget {
  final Sort sort;

  const IdeaSort({Key? key, required this.sort}) : super(key: key);

  @override
  _IdeaSortState createState() => _IdeaSortState();
}

class _IdeaSortState extends State<IdeaSort> {
  @override
  Widget build(BuildContext context) {
    // return GFCard(
    //   boxFit: BoxFit.cover,
    //   titlePosition: GFPosition.start,
    //   showOverlayImage: true,
    //   imageOverlay: AssetImage(widget.sort.img),
    //   title: GFListTile(
    //     subTitle: Text(widget.sort.content,style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),),
    //   ),
    // );
    return SizedBox(
      // height: flag?null:this.height,
      height: 140,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    widget.sort.img,
                    fit: BoxFit.cover,
                    height: 140,
                    width: double.infinity,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  )
                ],
              )),
          // Positioned(
          //   left: 20,
          //   top: 20,
          //   child:  Icon(this.icon,color:Colors.white,size: 32,),
          // ),
          Positioned(
              left: 80,
              top: 52,
              child: Text(widget.sort.content,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
