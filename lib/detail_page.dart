import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'memo_service.dart';

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
        title: Text("수정하기", style: TextStyle(color: Colors.grey[500])),
        backgroundColor: Color.fromRGBO(249, 244, 236, 1.0),
        iconTheme: IconThemeData(color: Colors.grey[500]), // 뒤로가기 버튼 색상 설정
        actions: [
          IconButton(
            onPressed: () {
              // 삭제 버튼 클릭시
              showDeleteDialog(context, memoService);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.grey[500],
            ),
          )
        ],
      ),
      body: Container(
        color: Color.fromRGBO(249, 244, 236, 1.0),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "제목",
                  hintText: "할 일을 입력하세요",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey[500]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Colors.grey[700]!, width: 2.0),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                cursorColor: Colors.grey[700],
                style: TextStyle(
                  color: Colors.grey[700], // 선택된 상태일 때 텍스트 색상
                ),
                autofocus: true,
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
            Flexible(
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: "할 일",
                  hintText: "세부사항을 입력하세요",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[500]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Colors.grey[700]!, width: 2.0),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                cursorColor: Colors.grey[700],
                autofocus: false,
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
