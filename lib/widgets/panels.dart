import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
class MyPanel extends StatefulWidget {
  ScrollController scrollController;
  SlidingUpPanelController panelController;
  MyPanel({required this.scrollController,required this.panelController,super.key});

  @override
  State<MyPanel> createState() => _MyPanelState();
}

class _MyPanelState extends State<MyPanel> {
  double minBound = 0;

  double upperBound = 1.0;
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanelWidget(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
                blurRadius: 5.0,
                spreadRadius: 2.0,
                color: const Color(0x11000000))
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                    ),
                  ),
                  Text(
                    'click or drag',
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              height: 50.0,
            ),
            Divider(
              height: 0.5,
              color: Colors.grey[300],
            ),
            Flexible(
              child: Container(
                child: ListView.builder(

                  controller: widget.scrollController,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('list item $index'),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: 20,
                ),
                color: Colors.white,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      controlHeight: 0,
      anchor: 0.4,
      minimumBound: minBound,
      upperBound: upperBound,
      panelController: widget.panelController,
      onTap: () {
        ///Customize the processing logic
        if (SlidingUpPanelStatus.expanded == widget.panelController.status) {
          widget.panelController.collapse();
        } else {
          widget.panelController.expand();
        }
      },
      enableOnTap: true,
      //Enable the onTap callback for control bar.
      dragDown: (details) {
        print('dragDown');
      },
      dragStart: (details) {
        print('dragStart');
      },
      dragCancel: () {
        print('dragCancel');
      },
      dragUpdate: (details) {
        print('dragUpdate,${widget.panelController.status == SlidingUpPanelStatus.dragging ? 'dragging' : ''}');
      },
      dragEnd: (details) {
        print('dragEnd');
      },
    );
  }
}
