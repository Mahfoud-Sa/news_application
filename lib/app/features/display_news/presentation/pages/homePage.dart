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
              return NewsCardWidget();
            },
          )
        ],
      ),
    );
  }
}

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        //color: Colors.amber,
        height: 150,
        child: ListTile(
          leading: Icon(Icons.newspaper),
        ),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 61, 39, 39),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Color(0xff1d1617).withOpacity(0.07),
                offset: Offset(0, 10),
                blurRadius: 0,
                spreadRadius: 0,
              )
            ]),
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
