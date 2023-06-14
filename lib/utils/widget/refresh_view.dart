import 'package:flutter/material.dart';

class RefreshView extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onRefesh;
  final VoidCallback? onLoadMore;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final NullableIndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final int itemCount;

  RefreshView({
    this.padding,
    this.onRefesh,
    this.onLoadMore,
    this.controller,
    this.physics,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
  });

  @override
  _RefreshViewState createState() => _RefreshViewState();
}

class _RefreshViewState extends State<RefreshView> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.controller ?? ScrollController();
    scrollController.addListener(_onBottomList);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onBottomList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onRefesh == null) return _child;

    return RefreshIndicator(
      child: _child,
      onRefresh: () async {
        widget.onRefesh?.call();
      },
    );
  }

  Widget get _child {
    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        height: constraints.maxHeight,
        child: ListView.separated(
          shrinkWrap: true,
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(parent: widget.physics),
          padding: widget.padding,
          itemBuilder: widget.itemBuilder,
          separatorBuilder: widget.separatorBuilder,
          itemCount: widget.itemCount,
        ),
      );
    });
  }

  void _onBottomList() {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels != 0) {
        widget.onLoadMore?.call();
      }
    }
  }
}
