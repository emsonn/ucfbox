import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ucfbox/game_data.dart' as game_data;

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _selectedItem;

  @override
  void initState() {
    super.initState();
    _list = ListModel<int>(
      listKey: _listKey,
      /// This determines how many players are in the game but only displays on the Item # in textbox
      initialItems: <int>[0,1,2,3,4,5,6,7,8,9],
      removedItemBuilder: _buildRemovedItem,
    );
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
      return CardItem(
        animation: animation,
        item: _list[index],
        selected: _selectedItem == _list[index],
        onTap: () {
          setState(() {
            _selectedItem = _selectedItem == _list[index] ? null : _list[index];
          });
        },
      );
    }

  // Used to build an item after it has been removed from the list. This method is
  // needed because a removed item remains  visible until its animation has
  // completed (even though it's gone as far this ListModel is concerned).
  // The widget will be used by the [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedList'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }
}

/// Keeps a Dart List in sync with an AnimatedList.
///
/// The [insert] and [removeAt] methods apply to both the internal list and the
/// animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that mutate the
/// list must make the same changes to the animated list in terms of
/// [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        assert(game_data.globalNumPlayers != 0),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

//  AnimatedListState get _animatedList => listKey.currentState;

  int get length => game_data.globalNumPlayers + 1;
//  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
        @required this.animation,
        this.onTap,
        @required this.item,
        this.selected: false})
      : assert(animation != null),
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 128.0,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text('lol im stupid', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
