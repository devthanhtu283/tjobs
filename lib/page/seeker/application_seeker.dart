import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplicationSeekerPage extends StatefulWidget {
  @override
  _ApplicationSeekerPageState createState() => _ApplicationSeekerPageState();
}

class _ApplicationSeekerPageState extends State<ApplicationSeekerPage> {
  int _selectedSegment = 0; // 0: 7 ngày, 1: 30 ngày, 2: Tất cả

  final List<Map<String, String>> applications = [
    {
      'title': 'Lập trình viên Flutter',
      'company': 'Công ty A',
      'avatar': 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw',
      'salary': '15 - 20 triệu',
      'location': 'Hà Nội',
      'appliedDate': '2023-10-01',
    },
    {
      'title': 'Nhân viên Marketing',
      'company': 'Công ty B',
      'avatar': 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw',
      'salary': '10 - 15 triệu',
      'location': 'TP.HCM',
      'appliedDate': '2023-09-25',
    },
    {
      'title': 'Kế toán tổng hợp',
      'company': 'Công ty C',
      'avatar': 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw',
      'salary': '8 - 12 triệu',
      'location': 'Đà Nẵng',
      'appliedDate': '2023-09-15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Việc làm đã ứng tuyển'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // SlidingSegmentedControl để chọn khoảng thời gian
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoSlidingSegmentedControl<int>(
                groupValue: _selectedSegment,
                children: {
                  0: Text('7 ngày'),
                  1: Text('30 ngày'),
                  2: Text('Tất cả'),
                },
                onValueChanged: (value) {
                  setState(() {
                    _selectedSegment = value!;
                  });
                },
              ),
            ),

            // Danh sách các công việc đã ứng tuyển
            Expanded(
              child: ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  final application = applications[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tiêu đề công việc
                          Text(
                            application['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),

                          // Tên công ty và avatar
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(application['avatar']!),
                                radius: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                application['company']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Lương và địa điểm
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.money_dollar_circle,
                                size: 16,
                                color: CupertinoColors.systemGreen,
                              ),
                              SizedBox(width: 4),
                              Text(
                                application['salary']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                CupertinoIcons.location_solid,
                                size: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                application['location']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Ngày ứng tuyển
                          Text(
                            'Ứng tuyển: ${application['appliedDate']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          SizedBox(height: 16),

                          // Nút Gửi tin nhắn và Xem lại CV
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                color: CupertinoColors.systemBlue,
                                child: Text('Gửi tin nhắn'),
                                onPressed: () {
                                  // Xử lý gửi tin nhắn
                                  print('Gửi tin nhắn cho ${application['company']}');
                                },
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                color: CupertinoColors.systemGrey,
                                child: Text('Xem lại CV'),
                                onPressed: () {
                                  // Xử lý xem lại CV
                                  print('Xem lại CV cho ${application['title']}');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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

