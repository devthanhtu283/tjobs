import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSeekerPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Thông báo 1',
      'description': 'Bạn đã ứng tuyển thành công vào vị trí Lập trình viên Flutter.',
      'time': '2 giờ trước',
    },
    {
      'title': 'Thông báo 2',
      'description': 'Công ty A đã xem hồ sơ của bạn.',
      'time': '1 ngày trước',
    },
    {
      'title': 'Thông báo 3',
      'description': 'Bạn có một đề xuất việc làm mới từ Công ty B.',
      'time': '3 ngày trước',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Thông báo'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            'Đánh dấu đã đọc',
            style: TextStyle(color: CupertinoColors.systemBlue),
          ),
          onPressed: () {
            // Xử lý khi nhấn nút "Đánh dấu đã đọc"
            print('Đánh dấu tất cả thông báo là đã đọc');
          },
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon thông báo
                      Icon(
                        CupertinoIcons.bell_fill,
                        size: 26,
                        color: CupertinoColors.systemBlue,
                      ),
                      SizedBox(width: 16),
                      // Nội dung thông báo
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification['title']!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              notification['description']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              notification['time']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.systemGrey2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Nút đánh dấu đã đọc
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          CupertinoIcons.checkmark_alt_circle,
                          size: 24,
                          color: CupertinoColors.systemGreen,
                        ),
                        onPressed: () {
                          // Xử lý khi nhấn nút đánh dấu đã đọc
                          print('Đánh dấu thông báo là đã đọc: ${notification['title']}');
                        },
                      ),
                    ],
                  ),
                ),
                // Đường kẻ ngăn cách
                Divider(height: 1, color: CupertinoColors.systemGrey4),
              ],
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(CupertinoApp(
    home: NotificationSeekerPage(),
  ));
}