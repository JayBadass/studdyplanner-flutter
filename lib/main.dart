import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_page.dart';
import 'memo_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemoService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        List<Memo> memoList = memoService.memoList;

        return Scaffold(
          backgroundColor: Color.fromRGBO(249, 244, 236, 1.0),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.5,
            backgroundColor: Color.fromRGBO(249, 244, 236, 1.0),
            title: Text(
              "오늘의 할 일",
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
          body: memoList.isEmpty
              ? Center(child: Text("할 일을 입력하세요"))
              : ListView.builder(
                  itemCount: memoList.length,
                  itemBuilder: (context, index) {
                    Memo memo = memoList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, top: 16.0, bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    memo.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    memo.content,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: memo.isChecked
                                  ? Icon(
                                      Icons.check_box,
                                      color: Colors.green[300],
                                    )
                                  : Icon(
                                      CupertinoIcons.square,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                setState(() {
                                  memo.isChecked = !memo.isChecked;
                                });
                              },
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            height: 0.5,
                          ),
                        ],
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromRGBO(250, 221, 175, 1),
            child: Icon(Icons.add),
            onPressed: () {
              memoService.createMemo(title: '제목을 입력하세요', content: '내용을 입력하세요');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    index: memoService.memoList.length - 1,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
