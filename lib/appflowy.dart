import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:task_management/card.dart';
import 'package:task_management/constant.dart';


class AppFlowy2 extends StatefulWidget {
  const AppFlowy2({super.key});

  @override
  State<AppFlowy2> createState() => _AppFlowy2State();
}

class _AppFlowy2State extends State<AppFlowy2> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    //TODO Move Column
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    //TODO Move Card
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
      //TODO Move Card to another Column
    },
  );
  List<AppFlowyGroupData> defaultColum = <AppFlowyGroupData>[];
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idColumnController = TextEditingController();
  TextEditingController titleColumnController = TextEditingController();
  List<Object?> groupList = [];
  AppFlowyBoardScrollController boardScrollController =
      AppFlowyBoardScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boardScrollController.scrollToBottom('2');

    defaultColum.addAll(
      [
        AppFlowyGroupData(
          id: MainColumn.todo,
          items: [],
          name: "To do",
        ),
        AppFlowyGroupData(
          id: MainColumn.inProgress,
          items: [],
          name: "In progress",
        ),
        AppFlowyGroupData(
          id: MainColumn.done,
          items: [],
          name: "Done",
        ),
        AppFlowyGroupData(
          id: '',
          items: [],
          name: '',
        ),
      ],
    );
    controller.addGroups(defaultColum);
    groupList.add(controller.props.first);
    print('groupList : ${groupList[0]}');
  }

  Future<void> _addCardDialog(String groupId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'id card',
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'title card',
                  ),
                  onChanged: (value) {
                    nameController.text = value;
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('create'),
              onPressed: () {
                _addCard(groupId, idController.text ?? '',
                    nameController.text ?? '');
                Navigator.pop(context);
                idController.clear();
                nameController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addColumnDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Column'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: idColumnController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'id Column',
                  ),
                ),
                TextField(
                  controller: titleColumnController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'title column',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('create'),
              onPressed: () {
                _addColumn(idColumnController.text, titleColumnController.text);
                Navigator.pop(context);
                idController.clear();
                nameController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  _addCard(String groupId, String id, String title) {
    var cardItem = CardItem(id, title);
    controller.addGroupItem(groupId, cardItem);
  }

  _removeCard(String groupId, String itemId) {
    controller.removeGroupItem(groupId, itemId);
  }

  _addColumn(String idColumn, String titleColumn) {
    AppFlowyGroupData<dynamic> groupData = AppFlowyGroupData(
      id: idColumn,
      name: titleColumn,
    );
    controller.addGroup(groupData);
  }

  _removeColumn(String groupId) {
    controller.removeGroup(groupId);

    groupList.add(controller.props.first);
    print('groupList : ${groupList[0]}');
  }

  Widget _cardContent(
    String id,
    String title,
    String groupId,
    String itemId,
    String? objectId,
  ) {
    return Container(
      key: ObjectKey(objectId),
      margin: EdgeInsets.only(bottom: 3),
      color: Colors.white,
      child: ListTile(
        splashColor: Colors.white,
        title: Text('id : $id'),
        subtitle: Text('title : $title'),
        trailing: InkWell(
          onTap: () {
            _removeCard(groupId, itemId);
          },
          child: Icon(Icons.delete),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: AppFlowyBoard(
          config: const AppFlowyBoardConfig(
            groupBackgroundColor: Color(0xFFEAD8C0),
          ),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          groupConstraints: const BoxConstraints(maxWidth: 320),
          boardScrollController: boardScrollController,
          controller: controller,
          headerBuilder: (context, colum) {
            // ----------HEAD----------
            return Container(
              margin: const EdgeInsets.all(10),
              child: AppFlowyGroupHeader(
                title: Text(colum.headerData.groupName),
                addIcon: const Icon(Icons.add),
                moreIcon: const Icon(Icons.delete),
                onAddButtonClick: () {
                  _addColumnDialog();
                },
                onMoreButtonClick: () {
                  _removeColumn(colum.id);
                },
              ),
            );
          },
          // ----------FOOTER----------
          footerBuilder: (context, colum) {
            print('column : $colum');
            return TextButton(
              onPressed: () {
                _addCardDialog(colum.id);
              },
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text('Card'),
                ],
              ),
            );
          },
          // ----------CARD----------
          cardBuilder: (context, group, groupItem) {
            var textItem = groupItem as CardItem;
            return _cardContent(textItem.id, textItem.title, group.id,
                groupItem.id, textItem.id);
          },
        ),
      ),
    );
  }
}
