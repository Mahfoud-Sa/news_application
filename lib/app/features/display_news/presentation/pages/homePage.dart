import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Application'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: ListView(
        children: [
          SearchWidget(),
          SizedBox(
            height: 40,
          ),
          _categorySection(),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10),
            child: Text(
              'Last News',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 100,
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) {
              return NewsCardWidget(
                newsTitle: 'News Title',
                newsCategory: 'News Category',
              );
            },
          )
        ],
      ),
    );
  }
}

class NewsCardWidget extends StatelessWidget {
  final String newsTitle;
  final String newsCategory;

  NewsCardWidget({
    super.key,
    required this.newsTitle,
    required this.newsCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blueGrey,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        child: Row(
          children: [
            Image.asset(
              'assets/images/error_image.jpg',
              fit: BoxFit.fill,
              height: 100,
              width: 120,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsTitle,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  newsCategory,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _categorySection extends StatelessWidget {
  const _categorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 10),
          child: Text(
            'Category',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 150,
          //color: Colors.green,
          child: ListView.separated(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
            itemBuilder: (context, index) {
              return categoryWidget();
            },
          ),
        ),
      ],
    );
  }
}

class categoryWidget extends StatelessWidget {
  const categoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.newspaper,
                color: Colors.black,
              ),
            ),
          ),
          const Text(
            'Sport',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}
