import 'package:flutter/material.dart';
import 'package:hacker_news/src/bloc/bloc_provider.dart';
import 'package:hacker_news/src/bloc/stories_bloc.dart';
import 'package:hacker_news/src/data/models/item_model.dart';
import 'package:hacker_news/src/widgets/loading_list_item.dart';

class NewsListItem extends StatelessWidget {
  final int itemId;

  NewsListItem({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoriesBloc>(context);

    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: bloc.items,
          builder:
              (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
            if (!snapshot.hasData) {
              return LoadingListItem();
            } else {
              final items = snapshot.data;

              return FutureBuilder(
                future: items[itemId],
                builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                  if (!itemSnapshot.hasData) {
                    return LoadingListItem();
                  } else {
                    return _buildListItem(itemSnapshot.data);
                  }
                },
              );
            }
          },
        ),
        Divider(),
      ],
    );
  }

  Widget _buildListItem(ItemModel item) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text('${item.score} points'),
      trailing: Column(
        children: [
          Icon(Icons.message),
          Text("${item.descendants}"),
        ],
      ),
    );
  }
}
