import 'package:flutter/material.dart';

import 'main.dart';

// Memo 데이터의 형식을 정해줍니다. 추후 isPinned, updatedAt 등의 정보도 저장할 수 있습니다.
class Memo {
  Memo({
    required this.title,
    required this.content,
    this.isChecked = false,
  });

  String title;
  String content;
  bool isChecked;
}

// Memo 데이터는 모두 여기서 관리
class MemoService extends ChangeNotifier {
  List<Memo> memoList = [
    Memo(title: '18조', content: '화이팅'), // 더미(dummy) 데이터
  ];

  createMemo({required String title, required String content}) {
    Memo memo = Memo(title: title, content: content);
    memoList.add(memo);
    notifyListeners();
  }

  updateMemo(
      {required int index, required String title, required String content}) {
    Memo memo = memoList[index];
    memo.title = title;
    memo.content = content;
    notifyListeners();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
  }
}
