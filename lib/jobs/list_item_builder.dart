import 'package:flutter/material.dart';
import 'package:time_tracker/jobs/empty_content.dart';

typedef ItemWidetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder extends StatelessWidget {
  final AsyncSnapshot<List<dynamic>> snapshot;
  final ItemWidetBuilder<dynamic> itemBuilder;

  const ListItemBuilder({Key key, this.snapshot, this.itemBuilder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<dynamic> items = snapshot.data;
      if (items.isNotEmpty) {
        // return ListView
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<dynamic> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(
        context,
        items[index],
      ),
    );
  }
}
