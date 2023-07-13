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
        // memoService로 부터 memoList 가져오기
        List<Memo> memoList = memoService.memoList;

        return Scaffold(
          appBar: AppBar(
            title: Text("Todo List"),
          ),
          body: memoList.isEmpty
              ? Center(child: Text("할일을 작성해 주세요"))
              : ListView.builder(
                  itemCount: memoList.length,
                  itemBuilder: (context, index) {
                    Memo memo = memoList[index];
                    return Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              memo.content,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                          ),
                        ),
                        IconButton(
                          icon: memo.isChecked
                              ? Icon(
                                  Icons.check_box,
                                  color: Colors.green,
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
                      ],
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // + 버튼 클릭시 메모 생성 및 수정 페이지로 이동
              memoService.createMemo(content: '');
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
