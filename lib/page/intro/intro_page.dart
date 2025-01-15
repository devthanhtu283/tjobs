import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job/page/user/login.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _slides = [
    Slide(
      image: 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw',
      title: 'Chào mừng đến với ứng dụng tuyển dụng',
      description: 'Tìm kiếm công việc phù hợp một cách dễ dàng.',
    ),
    Slide(
      image: 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw',
      title: 'Kết nối với nhà tuyển dụng',
      description: 'Gặp gỡ và trao đổi trực tiếp với các nhà tuyển dụng hàng đầu.',
    ),
    Slide(
      image: 'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw',
      title: 'Bắt đầu ngay hôm nay',
      description: 'Đăng ký hoặc đăng nhập để bắt đầu tìm kiếm công việc.',
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _navigateToAuth() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Tiếp tục với'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                // Xử lý tiếp tục với tài khoản khách
                print('Tiếp tục với tài khoản khách');
              },
              child: Text('Tài khoản khách'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder:  (context) => LoginPage(),));
                print('Đi đến trang đăng nhập/đăng ký');
              },
              child: Text('Đăng nhập / Đăng ký'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _slides.length,
            itemBuilder: (ctx, i) => _slides[i],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _slides.map((slide) {
                int index = _slides.indexOf(slide);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray,
                  ),
                );
              }).toList(),
            ),
          ),
          if (_currentPage == _slides.length - 1)
            Positioned(
              bottom: 60.0,
              left: 0,
              right: 0,
              child: Center(
                child: CupertinoButton(
                  onPressed: _navigateToAuth,
                  color: CupertinoColors.activeBlue,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Text(
                    'Bắt đầu',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Slide extends StatelessWidget {
  final String image; // URL của ảnh
  final String title;
  final String description;

  Slide({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            image, // Sử dụng URL của ảnh
            height: 200,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child; // Trả về ảnh khi đã tải xong
              }
              return Center(
                child: CupertinoActivityIndicator(),
              ); // Hiển thị tiến trình tải ảnh
            },
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return Icon(CupertinoIcons.exclamationmark_circle, color: CupertinoColors.systemRed, size: 50); // Hiển thị icon lỗi nếu không tải được ảnh
            },
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: CupertinoColors.label),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: CupertinoColors.secondaryLabel),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}