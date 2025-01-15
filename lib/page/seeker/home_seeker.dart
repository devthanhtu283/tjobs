import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> categories = [
    {'image': 'assets/job.png', 'text': 'Việc làm'},
    {'image': 'assets/company.png', 'text': 'Công ty'},
    {'image': 'assets/blog.png', 'text': 'Blog'},
    {'image': 'assets/cv.png', 'text': 'Thư viện CV'},
  ];

  final List<Map<String, String>> jobs = [
    {
      'title': 'Lập trình viên Flutter',
      'company': 'Công ty A',
      'location': 'Hà Nội',
      'salary': '15 - 20 triệu',
      'avatar': 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw' // URL hình ảnh công ty
    },
    {
      'title': 'Nhân viên Marketing',
      'company': 'Công ty B',
      'location': 'TP.HCM',
      'salary': '10 - 15 triệu',
      'avatar': 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw' // URL hình ảnh công ty
    },
    {
      'title': 'Kế toán tổng hợp',
      'company': 'Công ty C',
      'location': 'Đà Nẵng',
      'salary': '8 - 12 triệu',
      'avatar': 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw' // URL hình ảnh công ty
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Trang chủ'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Thanh tìm kiếm và icon tìm kiếm nâng cao
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoSearchTextField(
                      placeholder: 'Tìm kiếm việc làm...',
                      onChanged: (value) {
                        // Xử lý tìm kiếm
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.search_circle_fill, size: 40),
                    onPressed: () {
                      // Xử lý tìm kiếm nâng cao
                    },
                  ),
                ],
              ),
            ),

            // Slider chứa các circle image với text
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(categories[index]['image']!),
                        ),
                        SizedBox(height: 4),
                        Text(
                          categories[index]['text']!,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Phần gợi ý việc làm phù hợp
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gợi ý việc làm phù hợp',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      'Xem tất cả',
                      style: TextStyle(color: CupertinoColors.systemBlue),
                    ),
                    onPressed: () {
                      // Xử lý xem tất cả
                    },
                  ),
                ],
              ),
            ),

            // Danh sách các công việc
            Expanded(
              child: ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: CupertinoListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(jobs[index]['avatar']!),
                      ),
                      title: Text(jobs[index]['title']!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${jobs[index]['company']!} - ${jobs[index]['location']!}'),
                          SizedBox(height: 4),
                          Text(
                            'Lương: ${jobs[index]['salary']!}',
                            style: TextStyle(color: CupertinoColors.systemGreen),
                          ),
                        ],
                      ),
                      trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          CupertinoIcons.bookmark,
                          color: CupertinoColors.systemBlue,
                        ),
                        onPressed: () {
                          // Xử lý lưu công việc
                          setState(() {
                            // Thêm logic lưu công việc ở đây
                          });
                        },
                      ),
                      onTap: () {
                        // Xử lý khi nhấn vào công việc
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}