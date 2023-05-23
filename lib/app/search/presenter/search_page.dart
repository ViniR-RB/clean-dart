import 'package:clean_dart/app/search/presenter/search_bloc.dart';
import 'package:clean_dart/app/search/presenter/states/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/entities/result_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc bloc = Modular.get<SearchBloc>();
  final _searchText = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Search'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0),
              child: TextFormField(
                controller: _searchText,
                onChanged: (String searchText) => bloc.add(searchText),
                decoration: const InputDecoration(
                    labelText: "Search...", border: OutlineInputBorder()),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    final state = bloc.state;
                    print("State ->>>> $state");
                    if (state is SearchStartState) {
                      return const Center(
                        child: Text('Digite um Texto'),
                      );
                    }
                    if (state is SearchErrorState) {
                      return const Center(
                        child: Text('Houve um Error'),
                      );
                    }
                    if (state is SearchLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is SearchSucessState) {
                      final list = state.list;
                      print("Lista =>>>>>>>>>>>>>>>>>>> $list");
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            final ResultSearch item = list[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(item.img),
                              ),
                              title: Text(item.title),
                            );
                          });
                    }
                    return Container();
                  }),
            ),
          ],
        ));
  }
}
