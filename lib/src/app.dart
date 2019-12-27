import 'package:flutter/material.dart';
import 'package:hacker_news/src/bloc/stories_bloc.dart';

import 'bloc/bloc_provider.dart';
import 'screens/news_list_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: StoriesBloc(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        title: 'Hacker News',
        home: NewsListScreen(),
      ),
    );
  }
}
