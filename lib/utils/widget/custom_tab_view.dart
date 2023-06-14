import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/theme/colors.dart';

class CustomTabView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder? tabBuilder;
  final IndexedWidgetBuilder? pageBuilder;
  final ValueChanged<int>? onPositionChange;
  final ValueChanged<double?>? onScroll;
  final int initPosition;
  final Color? backgroundColor;
  final JumpingTabController? jumpingController;
  final double? elevation;
  final bool isTabScrollable;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? unselectedLabelColor;
  final Color? bgColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? tabbarPadding;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final AlignmentGeometry? aligment;
  final BoxDecoration? indicator;
  final EdgeInsetsGeometry? padding;

  const CustomTabView({
    Key? key,
    this.itemCount = 0,
    @required this.tabBuilder,
    this.pageBuilder,
    this.onPositionChange,
    this.onScroll,
    this.initPosition = 0,
    this.backgroundColor,
    this.jumpingController,
    this.elevation,
    this.isTabScrollable = false,
    this.selectedColor,
    this.unselectedColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelStyle,
    this.aligment,
    this.tabbarPadding,
    this.indicator,
    this.bgColor,
    this.borderColor,
    this.padding,
  }) : super(key: key);

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView>
    with TickerProviderStateMixin {
  late TabController _controller;
  PageController? _pageController;
  late int _currentCount;
  late int _currentPosition;
  Worker? _listener;

  bool _tabChanging = false;

  @override
  void initState() {
    _tabChanging = false;
    _currentPosition = widget.initPosition;
    _currentCount = widget.itemCount;
    if (_currentCount != 0 && _currentPosition > _currentCount - 1) {
      _currentPosition = _currentCount - 1;
    }

    if (widget.pageBuilder != null) {
      _pageController = PageController(initialPage: _currentPosition);
    }
    _controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    _controller.addListener(onPositionChange);
    _controller.animation?.addListener(onScroll);

    if (widget.jumpingController != null) {
      widget.jumpingController
        ?..setListener((pos) {
          if (pos >= 0 && pos < _currentCount) {
            _controller.animateTo(pos);
          }
        });
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.animation?.removeListener(onScroll);
    _controller.removeListener(onPositionChange);
    _controller.dispose();
    _pageController?.dispose();
    _listener?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomTabView oldWidget) {
    _controller.animation?.removeListener(onScroll);
    _controller.removeListener(onPositionChange);
    _controller.dispose();
    _pageController?.dispose();

    if (_currentPosition >= widget.itemCount) {
      _currentPosition = widget.initPosition;
    }
    _currentCount = widget.itemCount;
    _controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    _controller.addListener(onPositionChange);
    _controller.animation?.addListener(onScroll);
    if (widget.pageBuilder != null) {
      _pageController = PageController(initialPage: _currentPosition);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          elevation: widget.elevation ?? 0,
          color: widget.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          child: Stack(
            alignment: widget.aligment ?? Alignment.bottomLeft,
            children: <Widget>[
              if (widget.itemCount != 0) _buildIndicator(),
              _buildTabbar(context),
            ],
          ),
        ),
        if (widget.pageBuilder != null) _buildTabBarView(context),
      ],
    );
  }

  Widget _buildTabbar(BuildContext context) {
    return Container(
      margin: widget.padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: widget.bgColor ?? AppColors.linkWater,
        borderRadius: BorderRadius.circular(
          100,
        ),
        border: Border.all(
          color: widget.borderColor ?? Colors.transparent,
          width: 4,
        ),
      ),
      child: TabBar(
        indicator: widget.indicator,
        isScrollable: widget.isTabScrollable,
        controller: _controller,
        labelStyle: widget.labelStyle,
        labelColor: widget.selectedColor,
        unselectedLabelStyle: widget.unselectedLabelStyle,
        labelPadding: widget.labelPadding,
        unselectedLabelColor: widget.unselectedLabelColor,
        padding: widget.tabbarPadding,
        tabs: List.generate(
          widget.itemCount,
              (index) => widget.tabBuilder!(context, index),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Divider(
      color: widget.unselectedColor ?? Colors.transparent,
      height: 1,
      thickness: 1,
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: widget.pageBuilder!,
        itemCount: widget.itemCount,
        onPageChanged: (value) {
          if (!_tabChanging) _controller.animateTo(value);
        },
      ),
    );
  }

  Future<void> onPositionChange() async {
    if (!_controller.indexIsChanging) {
      _currentPosition = _controller.index;

      widget.onPositionChange?.call(_currentPosition);

      if (widget.pageBuilder != null) {
        _tabChanging = true;
        await _pageController?.animateToPage(
          _currentPosition,
          duration: kTabScrollDuration,
          curve: Curves.ease,
        );
        _tabChanging = false;
      }
    }
  }

  void onScroll() => widget.onScroll?.call(_controller.animation?.value);
}

class JumpingTabController extends ValueNotifier<int> {
  JumpingTabController([
    int pos = 0,
    this.onChangeRequested,
  ]) : super(pos);

  PositionChangedCallback? onChangeRequested;

  int get pos => super.value;

  void jumpTo(int pos) {
    super.value = pos;
    onChangeRequested?.call(pos);
  }

  void setListener(PositionChangedCallback? onChangeRequested) {
    this.onChangeRequested = onChangeRequested;
  }
}

typedef PositionChangedCallback = void Function(int pos);
