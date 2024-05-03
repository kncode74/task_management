import 'package:flutter/material.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';

class BoardViewScreen extends StatefulWidget {
  const BoardViewScreen({Key? key}) : super(key: key);

  @override
  State<BoardViewScreen> createState() => _BoardViewScreenState();
}

class _BoardViewScreenState extends State<BoardViewScreen> {
  BoardViewController boardViewController = BoardViewController();
  late List<BoardItem> boardItemList;

  @override
  void initState() {
    super.initState();
    boardItemList = [
      BoardItem(
        onStartDragItem:
            (int? listIndex, int? itemIndex, BoardItemState state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState state) {},
        onTapItem:
            (int? listIndex, int? itemIndex, BoardItemState state) async {},
        item: const Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Board Item"),
          ),
        ),
      ),
      BoardItem(
        onStartDragItem:
            (int? listIndex, int? itemIndex, BoardItemState state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState state) {},
        onTapItem:
            (int? listIndex, int? itemIndex, BoardItemState state) async {},
        item: const Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Board Item"),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<BoardList> boardLists = [
      BoardList(
        onStartDragList: (int? listIndex) {},
        onTapList: (int? listIndex) async {},
        onDropList: (int? listIndex, int? oldListIndex) {},
        headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
        backgroundColor: Color.fromARGB(255, 235, 236, 240),
        header: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "List Item 1",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
        items: boardItemList,
      ),
      BoardList(
        onStartDragList: (int? listIndex) {},
        onTapList: (int? listIndex) async {},
        onDropList: (int? listIndex, int? oldListIndex) {},
        headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
        backgroundColor: Color.fromARGB(255, 235, 236, 240),
        header: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "List Item 2",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
        items: boardItemList,
      ),
      BoardList(
        onStartDragList: (int? listIndex) {},
        onTapList: (int? listIndex) async {},
        onDropList: (int? listIndex, int? oldListIndex) {},
        headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
        backgroundColor: Color.fromARGB(255, 235, 236, 240),
        header: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "List Item 3",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
        items: boardItemList,
      ),
      BoardList(
        onStartDragList: (int? listIndex) {},
        onTapList: (int? listIndex) async {},
        onDropList: (int? listIndex, int? oldListIndex) {},
        headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
        backgroundColor: Color.fromARGB(255, 235, 236, 240),
        header: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "List Item 4",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
        items: boardItemList,
      ),
    ];

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        child: BoardView(
          lists: boardLists,
          boardViewController: boardViewController,
          middleWidget: Icon(Icons.add),
        ),
      ),
    );
  }
}
