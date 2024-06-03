import 'package:capstone/page/homepage/DetailItemPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle1;
  final String subtitle2;

  BookListItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 클릭되었을 때 다른 페이지로 이동
        Get.to(DetailItemPage());
      },
      child: Column(
        children: [
          Divider(),
          Row(
            children: [
              SizedBox(
                width: 100, // 이미지 너비 고정
                height: 100, // 이미지 높이 고정
                child: Image(image: NetworkImage(imagePath), fit: BoxFit.cover),
              ), // AssetImage 대신 NetworkImage 사용
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start),
                  Text(subtitle1),
                  Text(subtitle2),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                      ),
                      Row(
                        children: [
                          Image(
                              image: AssetImage('assets/icons/icon_chat.png')),
                          Text('3')
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image(
                          width: 20,
                          image: AssetImage('assets/icons/icon_heart.png')),
                      Text('3')
                    ],
                  )
                ],
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

class Book {
  final String imagePath;
  final String title;
  final String subtitle1;
  final String subtitle2;

  Book({
    required this.imagePath,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });
}

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  Future<List<Book>> getBooks() async {
    List<Book> books = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('books').get();
    snapshot.docs.forEach((doc) {
      books.add(Book(
        imagePath: doc['imagePath'],
        title: doc['title'],
        subtitle1: doc['subtitle1'],
        subtitle2: doc['subtitle2'],
      ));
    });
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List Page'),
      ),
      body: FutureBuilder<List<Book>>(
        future: getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return BookListItem(
                  imagePath: book.imagePath,
                  title: book.title,
                  subtitle1: book.subtitle1,
                  subtitle2: book.subtitle2,
                );
              },
            );
          }
        },
      ),
    );
  }
}
