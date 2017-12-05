import 'package:flutter/material.dart';
import 'board.dart';
import 'package:flutter/foundation.dart';
import 'position.dart';

class EmptyAppearTransition extends StatefulWidget {
  final Widget child;

  EmptyAppearTransition(this.child);

  @override
  EmptyAppearState createState() => new EmptyAppearState();
}

class EmptyAppearState extends State<EmptyAppearTransition> with SingleTickerProviderStateMixin {
  AnimationController controller;

  EmptyAppearState() {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new ScaleTransition(
        scale: controller,
        child: widget.child
    );

  }
}

class NewPieceTransition extends StatefulWidget {
  final Widget child;

  NewPieceTransition(this.child);

  @override
  NewPieceState createState() => new NewPieceState();
}

class NewPieceState extends State<NewPieceTransition> with SingleTickerProviderStateMixin {
  AnimationController controller;

  NewPieceState() {
    controller = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000)
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    var animation = new CurvedAnimation(parent: controller, curve: Curves.elasticOut);

    return new ScaleTransition(scale: animation, child: widget.child);
  }
}

class AbsolutePositionedTransition extends AnimatedWidget {
  /// Uses static size for the Positioned, (not the container, like RelativePositionedTransition does)
  const AbsolutePositionedTransition({
    Key key,
    @required Animation<Offset> offset,
    @required this.size,
    @required this.child,
  }) : super(key: key, listenable: offset);

  Animation<Offset> get offset => listenable;

  /// The widget below this widget in the tree.
  final Widget child;
  final Size size;

  @override
  Widget build(BuildContext context) {
    // debugPrint("building with [${offset.value.dx},${offset.value.dy}]");
    return new Positioned(
      width: size.width,
      height: size.height,
      top: offset.value.dy,
      left: offset.value.dx,
      child: child,
    );
  }
}

class SlideTransition extends StatefulWidget {
  final Widget child;
  final Position source;
  final Position target;
  final double cellWidth;

  SlideTransition({ @required this.child, @required this.source, @required this.target, @required this.cellWidth});

  @override
  SlideState createState() => new SlideState();
}

class SlideState extends State<SlideTransition> with SingleTickerProviderStateMixin {
  AnimationController controller;

  SlideState() {
    controller = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000)
    );
    controller.forward();
  }

  Widget build(BuildContext context) {

    var source = new Offset(widget.source.x * widget.cellWidth, widget.source.y * widget.cellWidth);
    var target = new Offset(widget.target.x * widget.cellWidth, widget.target.y * widget.cellWidth);

    // debugPrint("sliding from $source to $target");

    Animation<Offset> offset = new Tween<Offset>(
      begin: source,
      end: target,
    ).animate(controller);

    return new AbsolutePositionedTransition(
      child: widget.child,
      size: new Size(widget.cellWidth,widget.cellWidth),
      offset: offset
    );
  }
}
