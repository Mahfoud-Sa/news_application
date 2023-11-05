import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:news_app/app/core/resources/category.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({
    super.key,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _formKey = GlobalKey<FormState>();
  final categoryList = [
    Category(
      name: 'All',
      icon: const Icon(
        Icons.category,
        color: Colors.black,
      ),
      color: const Color.fromARGB(255, 68, 255, 146),
    ),
    Category(
      name: 'Sport',
      icon: const Icon(
        FontAwesome.space_shuttle,
        color: Colors.black,
      ),
      color: const Color.fromARGB(255, 68, 255, 146),
    ),
    Category(
      name: 'Technology',
      icon: const Icon(
        FontAwesome.laptop,
        color: Colors.black,
      ),
      color: Colors.amber,
    ),
    Category(
      name: 'Health',
      icon: const Icon(
        FontAwesome.hospital_o,
        color: Colors.black,
      ),
      color: Colors.blueAccent,
    ),
    Category(
      name: 'Funds',
      icon: const Icon(
        FontAwesome.money,
        color: Colors.black,
      ),
      color: Colors.orange,
    ),
  ];

  final _searchController = TextEditingController();
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: const Color(0Xff1d1617).withOpacity(0.11),
              blurRadius: 40,
              spreadRadius: 0.0)
        ]),
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _searchController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'do not leave it Empty';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Search News',
                prefixIcon: IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<RemoteArticleBloc>(context).add(
                            GetSearchArticles(
                                categoryList[selectedCategory].name,
                                _searchController.text));
                      }
                    },
                    icon: const Icon(Icons.search)),
                suffixIcon: SizedBox(
                  width: categoryList[0].name.length.toDouble() + 130,
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const VerticalDivider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: DropdownButton(
                              value: selectedCategory,
                              items: [
                                DropdownMenuItem(
                                    value: 0,
                                    child: Text(categoryList[0].name)),
                                DropdownMenuItem(
                                    value: 1,
                                    child: Text(categoryList[1].name)),
                                DropdownMenuItem(
                                    value: 2,
                                    child: Text(
                                      categoryList[2].name,
                                      overflow: TextOverflow.fade,
                                    )),
                                DropdownMenuItem(
                                    value: 3,
                                    child: Text(categoryList[3].name)),
                                DropdownMenuItem(
                                    value: 4,
                                    child: Text(categoryList[4].name)),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value!;
                                });
                              },
                              icon: categoryList[selectedCategory].icon),
                        ),
                      ],
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none)),
          ),
        ));
  }
}
