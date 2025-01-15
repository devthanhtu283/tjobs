import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'CV Profile',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: CVProfilePage(),
    );
  }
}

class CVProfilePage extends StatefulWidget {
  @override
  _CVProfilePageState createState() => _CVProfilePageState();
}

class _CVProfilePageState extends State<CVProfilePage> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CV Profile'),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CupertinoSlidingSegmentedControl<int>(
                    groupValue: _selectedSegment,
                    children: {
                      0: Text('CV'),
                      1: Text('Cover Letter'),
                    },
                    onValueChanged: (int? value) {
                      setState(() {
                        _selectedSegment = value ?? 0;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: _selectedSegment == 0
                      ? _buildCVContent()
                      : _buildCoverLetterContent(),
                ),
              ],
            ),
            // Nút dấu cộng ở góc dưới bên phải
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  // Hiển thị tùy chọn khi nhấn vào nút dấu cộng
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: Text('Tùy chọn'),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                            _createCVOnline();
                          },
                          child: Text('Tạo CV Online'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                            _uploadCV();
                          },
                          child: Text('Tải CV lên'),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Hủy'),
                      ),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCVContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần 1: Thư viện CV
          Text(
            'Thư viện CV',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
          SizedBox(height: 8.0),
          Text(
            'Danh sách các mẫu CV có sẵn.',
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
          SizedBox(height: 16.0),

          // Card với background hình ảnh từ network
          Card(
            elevation: 4.0,
            margin: EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Stack(
              children: [
                // Background hình ảnh từ network
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw', // Thay bằng URL hình ảnh thực tế
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Lớp phủ màu tối
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.black.withOpacity(0.5), // Độ trong suốt 50%
                  ),
                ),
                // Nội dung trên hình ảnh
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tên CV
                      Text(
                        'CV Mẫu - Lập trình viên Flutter',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Thời gian cập nhật gần nhất
                      Text(
                        'Cập nhật lần cuối: 10/10/2023',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      // Nút tải và dấu 3 chấm
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Nút tải
                          CupertinoButton(
                            onPressed: () {
                              // Xử lý khi nhấn nút tải
                              print('Nút tải được nhấn');
                            },
                            child: Text(
                              'Tải',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: CupertinoColors.activeBlue,
                          ),
                          // Dấu 3 chấm (CupertinoActionSheet)
                          CupertinoButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                      title: Text('Chọn tùy chọn'),
                                      actions: [
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _openPDF();
                                          },
                                          child: Text('Xem'),
                                        ),
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            print('Cập nhật CV');
                                          },
                                          child: Text('Cập nhật'),
                                        ),
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            print('Xóa CV');
                                          },
                                          child: Text('Xóa'),
                                        ),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Hủy'),
                                      ),
                                    ),
                              );
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Phần 2: CV đã tải lên
          Text(
            'CV đã tải lên',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
          SizedBox(height: 8.0),
          Text(
            'Danh sách các CV bạn đã tải lên.',
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
          SizedBox(height: 16.0),

          // Danh sách CV đã tải lên
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3, // Số lượng CV đã tải lên
            itemBuilder: (context, index) {
              return Card(
                elevation: 4.0,
                margin: EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CV ${index + 1} - Lập trình viên Flutter',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Cập nhật lần cuối: 10/10/2023',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              // Xử lý khi nhấn nút xem
                              _openPDF();
                            },
                            child: Text('Xem'),
                            color: CupertinoColors.activeBlue,
                          ),
                          CupertinoButton(
                            onPressed: () {
                              // Xử lý khi nhấn nút xóa
                              print('Xóa CV ${index + 1}');
                            },
                            child: Text('Xóa'),
                            color: CupertinoColors.destructiveRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Phần 3: TJob Profile
          Text(
            'TJob Profile',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
          SizedBox(height: 8.0),
          Card(
            elevation: 4.0,
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw'),
                  ),
                  SizedBox(width: 16.0),
                  // Thông tin
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tên dev
                        Text(
                          'Nguyễn Văn A',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        // Công việc
                        Text(
                          'Lập trình viên Flutter',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4.0),
                        // Ngày cập nhật
                        Text(
                          'Cập nhật lần cuối: 10/10/2023',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm mở PDF từ thư mục assets
  void _openPDF() async {
    try {
      final document = await PdfDocument.openAsset('assets/ThanhTuCV.pdf');
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('PDF Viewer'),
            ),
            child: SafeArea(
              child: PdfViewPinch(
                controller: PdfControllerPinch(document: PdfDocument.openAsset('assets/ThanhTuCV.pdf')),
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      print('Lỗi khi mở PDF: $e'); // In lỗi ra console
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Lỗi'),
          content: Text('Không thể mở tệp PDF. Vui lòng kiểm tra lại tệp.'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  // Hàm xử lý khi chọn "Tạo CV Online"
  void _createCVOnline() {
    print('Tạo CV Online');
    // Thêm logic xử lý tạo CV online tại đây
  }

  // Hàm xử lý khi chọn "Tải CV lên"
  void _uploadCV() {
    print('Tải CV lên');
    // Thêm logic xử lý tải CV lên tại đây
  }

  Widget _buildCoverLetterContent() {
    return Center(
      child: Text(
        'Nội dung Cover Letter của bạn sẽ được hiển thị ở đây.',
        style: CupertinoTheme.of(context).textTheme.textStyle,
      ),
    );
  }
}