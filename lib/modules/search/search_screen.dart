import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/component.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefix: Icon(
                      Icons.search,
                    ),
                    labelText: 'Search',
                  ),
                  controller: textController,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  // decoration: const InputDecoration(
                  //   labelText: 'Search',
                  //   prefix: Icon(
                  //     Icons.search,
                  //   ),
                ),
              ),
              Expanded(child: articleBuilder(list, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
