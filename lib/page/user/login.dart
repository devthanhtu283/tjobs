import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job/page/seeker/dashboard_seeker.dart';
import 'package:job/page/user/signup.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80.0),
              // Logo từ network
              Image.network(
                'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw', // Thay bằng URL logo của bạn
                height: 80.0,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Icon(Icons.error, color: Colors.red, size: 80.0);
                },
              ),
              SizedBox(height: 24.0),
              Text(
                'Đăng Nhập',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              // Email Field
              CupertinoTextField(
                placeholder: 'Email',
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              // Password Field
              CupertinoTextField(
                placeholder: 'Mật khẩu',
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              // Remember Me Checkbox
              Row(
                children: [
                  CupertinoCheckbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Xử lý khi thay đổi trạng thái ghi nhớ đăng nhập
                    },
                  ),
                  Text('Ghi nhớ đăng nhập'),
                ],
              ),
              SizedBox(height: 24.0),
              // Login Button
              CupertinoButton(
                onPressed: () {
                  // Xử lý đăng nhập
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardSeekerPage(),));
                },
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(8.0),
                child: Text('Đăng Nhập'),
              ),
              SizedBox(height: 16.0),
              // Google Login Button
              CupertinoButton(
                onPressed: () {
                  // Xử lý đăng nhập bằng Google
                },
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/800px-Google_%22G%22_logo.svg.png', // Thay bằng URL logo Google
                      height: 24.0,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Icon(Icons.error, color: Colors.red, size: 24.0);
                      },
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Đăng nhập bằng Google',
                      style: TextStyle(color: CupertinoColors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              // Forgot Password Link
              GestureDetector(
                onTap: () {
                  // Xử lý khi nhấn vào "Quên mật khẩu"
                },
                child: Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24.0),
              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Chưa có tài khoản? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                    },
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}