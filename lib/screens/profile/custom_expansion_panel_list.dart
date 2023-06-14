import 'package:flutter/material.dart';
import 'package:ship_management/theme/colors.dart';

class CustomExpansionPanelList extends StatelessWidget {
  const CustomExpansionPanelList({
    Key? key,
    this.children = const <ExpansionPanel>[],
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
  }) : super(key: key);

  final List<ExpansionPanel> children;

  final ExpansionPanelCallback? expansionCallback;

  final Duration animationDuration;

  bool _isChildExpanded(int index) {
    return children[index].isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = <Widget>[];

    for (int index = 0; index < children.length; index += 1) {
      final header = InkWell(
        onTap: () {
          if (expansionCallback != null) {
            expansionCallback!(index, children[index].isExpanded);
          }
        },
        child: Container(margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: _isChildExpanded(index)
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: AppColors.black),
                  ),
                )
              : null,
          child: Row(
            children: <Widget>[
              Expanded(
                child: AnimatedContainer(
                  duration: animationDuration,
                  curve: Curves.fastOutSlowIn,
                  child: Container(
                    child: children[index].headerBuilder(
                      context,
                      children[index].isExpanded,
                    ),
                  ),
                ),
              ),
              Container(
                // margin: const EdgeInsetsDirectional.only(end: 8.0),
                child: ExpandIcon(
                  isExpanded: _isChildExpanded(index),
                  onPressed: (bool isExpanded) {
                    if (expansionCallback != null) {
                      expansionCallback!(index, isExpanded);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );

      double radiusValue = _isChildExpanded(index) ? 12.0 : 12.0;
      items.add(
        Container(
          key: _SaltedKey<BuildContext, int>(context, index * 2),
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: AppColors.linkWater,
            elevation: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
            child: Column(
              children: <Widget>[
                header,
                AnimatedCrossFade(
                  firstChild: Container(height: 0.0),
                  secondChild: children[index].body,
                  firstCurve:
                      const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                  secondCurve:
                      const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: _isChildExpanded(index)
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: animationDuration,
                ),
              ],
            ),
          ),
        ),
      );

      if (index != children.length - 1) {
        items.add(SizedBox(
          key: _SaltedKey<BuildContext, int>(context, index * 10 + 1),
          height: 15.0,
        ));
      }
    }

    return Column(
      children: items,
    );
  }
}

class _SaltedKey<S, V> extends LocalKey {
  const _SaltedKey(this.salt, this.value);

  final S salt;
  final V value;

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final _SaltedKey<S, V> typedOther = other;

    return salt == typedOther.salt && value == typedOther.value;
  }

  @override
  int get hashCode => hashValues(runtimeType, salt, value);

  @override
  String toString() {
    final String saltString = S == String ? '<\'$salt\'>' : '<$salt>';
    final String valueString = V == String ? '<\'$value\'>' : '<$value>';

    return '[$saltString $valueString]';
  }
}
