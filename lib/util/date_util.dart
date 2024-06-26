String timestampToDate(int timestamp) {
  //将时间戳转换为DateTime对象
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  // // 使用yyyy-MM-dd HH:mm:ss格式化日期
  // String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
  //     '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';

  String formattedDate = '${date.year}年${date.month.toString().padLeft(2, '0')}月${date.day.toString().padLeft(2, '0')}日';

  return formattedDate;
}