import 'package:appflowy_board/appflowy_board.dart';

class CardItem extends AppFlowyGroupItem {
  @override
  final String id;

  final String title;

  CardItem(this.id, this.title);

  String get getId => id;
}
