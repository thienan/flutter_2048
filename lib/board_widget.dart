import 'package:flutter/material.dart';
import 'board.dart';
import 'cell_widget.dart';


class BoardWidget extends StatefulWidget {
  final Board board;
  final bool background;

  BoardWidget(this.board, this.background);

  @override
  BoardWidgetState createState() => new BoardWidgetState();
}

class BoardWidgetState extends State<BoardWidget> {
  Widget build(BuildContext context) {

    var children = <Widget>[];
    for (int x = 0; x <= 3; x++) {
      for (int y = 0; y <= 3; y++) {
        var piece = widget.board.get(x, y);
        if ( widget.background || ( piece != null && piece.value != null ) ) {
          children.add(new CellWidget(piece));
        }
      }
    }

    return new Container(
        width: CellWidth * 4,
        height: CellWidth * 4,
        child: new Stack(children: children));
  }
}
