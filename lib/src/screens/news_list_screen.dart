import 'package:flutter/material.dart';
import 'package:hacker_news/src/bloc/bloc_provider.dart';
import 'package:hacker_news/src/bloc/stories_bloc.dart';
import 'package:hacker_news/src/widgets/news_list_item.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoriesBloc>(context);
    bloc.fetchTopIds(); // Todo TEMP, this is BAD!

    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: _buildList(bloc),
    );
  }

  Widget _buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final List<int> topIds = snapshot.data;
          return ListView.builder(
            itemCount: topIds.length,
            itemBuilder: (context, index) {
              bloc.fetchItem(topIds[index]);
              return NewsListItem(
                itemId: topIds[index],
              );
            },
          );
        }
      },
    );
  }
}
