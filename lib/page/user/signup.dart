import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole = "Ứng viên";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _taxCodeController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Xử lý đăng ký
      print("Role: $_selectedRole");
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordController.text}");
      if (_selectedRole == 'Ứng viên') {
        print("Phone: ${_phoneController.text}");
        print("Date of Birth: ${_dobController.text}");
      } else if (_selectedRole == 'Nhà tuyển dụng') {
        print("Company Name: ${_companyNameController.text}");
        print("Tax Code: ${_taxCodeController.text}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                Image.network(
                  'https://play-lh.googleusercontent.com/Shy9VB3CKUYUzyzcuJwmDiYZElFJsKYwj5v5X2s3fGfIlL6SzkbAz_sMX6ZX9Sk8JQ=w240-h480-rw', // Thay bằng URL logo của bạn
                  height: 100.0,
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
                    return Icon(Icons.error, color: Colors.red, size: 100.0);
                  },
                ),
                SizedBox(height: 24.0),
                // Tiêu đề
                Text(
                  'Đăng Ký',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.label,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                // Chọn role
                Text(
                  'Bạn là:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.label,
                  ),
                ),
                SizedBox(height: 8.0),
                CupertinoSlidingSegmentedControl<String>(
                  groupValue: _selectedRole,
                  children: {
                    'Ứng viên': Text('Ứng viên'),
                    'Nhà tuyển dụng': Text('Nhà tuyển dụng'),
                  },
                  onValueChanged: (String? value) {
                    setState(() {
                      _selectedRole = value;

                    });
                  },
                ),
                SizedBox(height: 24.0),
                // Email Field
                CupertinoTextField(
                  controller: _emailController,
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
                  controller: _passwordController,
                  placeholder: 'Mật khẩu',
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.extraLightBackgroundGray,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                // Confirm Password Field
                CupertinoTextField(
                  controller: _confirmPasswordController,
                  placeholder: 'Xác nhận mật khẩu',
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.extraLightBackgroundGray,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24.0),
                // Hiển thị các trường phù hợp với role
                if (_selectedRole == 'Ứng viên') ...[
                  // Phone Field
                  CupertinoTextField(
                    controller: _phoneController,
                    placeholder: 'Số điện thoại',
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.extraLightBackgroundGray,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.0),
                  // Date of Birth Field
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: CupertinoTextField(
                        controller: _dobController,
                        placeholder: 'Ngày sinh',
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: CupertinoColors.extraLightBackgroundGray,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffix: Icon(
                          CupertinoIcons.calendar,
                          color: CupertinoColors.label,
                        ),
                      ),
                    ),
                  ),
                ] else if (_selectedRole == 'Nhà tuyển dụng') ...[
                  // Company Name Field
                  CupertinoTextField(
                    controller: _companyNameController,
                    placeholder: 'Tên công ty',
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.extraLightBackgroundGray,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Tax Code Field
                  CupertinoTextField(
                    controller: _taxCodeController,
                    placeholder: 'Mã số thuế',
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.extraLightBackgroundGray,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
                SizedBox(height: 32.0),
                // Submit Button
                CupertinoButton(
                  onPressed: _submitForm,
                  color: CupertinoColors.activeBlue,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Text(
                    'Đăng Ký',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}