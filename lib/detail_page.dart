import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'memo_service.dart';

// 메모 생성 및 수정 페이지
class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.index}) : super(key: key);

  final int index;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[index];

    titleController.text = memo.title;
    contentController.text = memo.content;

    return Scaffold(
      appBar: AppBar(
        title: Text("수정하기"),
        actions: [
          IconButton(
            onPressed: () {
              // 삭제 버튼 클릭시
              showDeleteDialog(context, memoService);
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                "제목",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "제목을 입력하세요",
                  border: UnderlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: null,
                expands: false,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  // 타이틀 값이 변할 때
                  memoService.updateMemo(
                    index: index,
                    title: value,
                    content: memo.content,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                "내용",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: "내용을 입력하세요",
                  border: UnderlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: null,
                expands: false,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  // 내용 값이 변할 때
                  memoService.updateMemo(
                    index: index,
                    title: memo.title,
                    content: value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, MemoService memoService) {
    showDialog(
      context: context,
      builder: (context) {
        return Builder(
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text("정말로 삭제하시겠습니까?"),
              actions: [
                // 취소 버튼
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text("취소"),
                ),
                // 확인 버튼
                TextButton(
                  onPressed: () {
                    memoService.deleteMemo(index: index);
                    Navigator.pop(dialogContext); // 팝업 닫기
                    Navigator.pop(context); // HomePage 로 가기
                  },
                  child: Text(
                    "확인",
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
