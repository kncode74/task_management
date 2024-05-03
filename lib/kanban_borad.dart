import 'package:flutter/material.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';

class Kanban extends StatefulWidget {
  const Kanban({super.key});

  @override
  State<Kanban> createState() => _KanbanState();
}

class _KanbanState extends State<Kanban> {
  List<CardContent> cardList = [];

  @override
  void initState() {
    generateCardListData();
    super.initState();
  }

  void generateCardListData() {
    for (int i = 0; i < 8; i++) {
      cardList.add(CardContent(
        'Name: Unikwan$i',
        'Last Name : Mobile$i',
        20 + i,
      ));
    }
  }

  void deleteCard(int index) {
    setState(() {
      cardList.removeAt(index);
    });
    print(cardList.length);
  }

  @override
  Widget build(BuildContext context) {
    return KanbanBoard(
      List.generate(
        8,
        (index) => BoardListsData(
            header: const Row(
              children: [
                Text('TODO'),
              ],
            ),
            footer: const Row(
              children: [
                Icon(Icons.add),
                Text('Add card'),
              ],
            ),
            items: List.generate(cardList.length, (index) {
              var card = cardList[index];
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    )),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text("${card.name}"),
                        Text("${card.lastName}"),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            deleteCard(index);
                          },
                          child: Icon(Icons.delete),
                        )
                      ],
                    )
                  ],
                ),
              );
            })),
      ),
      onItemLongPress: (cardIndex, listIndex) {},
      onItemReorder:
          (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {},
      onListLongPress: (listIndex) {},
      onListReorder: (oldListIndex, newListIndex) {},
      onItemTap: (cardIndex, listIndex) {},
      onListTap: (listIndex) {},
      onListRename: (oldName, newName) {},
      backgroundColor: Colors.white,
      displacementY: 124,
      displacementX: 100,
      textStyle: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}

class CardContent {
  final String name;
  final String lastName;
  final int age;

  CardContent(this.name, this.lastName, this.age);
}
