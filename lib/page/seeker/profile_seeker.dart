import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileSeekerPage extends StatefulWidget {
  @override
  _ProfileSeekerPageState createState() => _ProfileSeekerPageState();
}

class _ProfileSeekerPageState extends State<ProfileSeekerPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  File? _avatar;
  String? _selectedProvince;
  String? _selectedDistrict;
  List<dynamic> _provinces = [];
  List<dynamic> _districts = [];
  bool _isLoadingProvinces = false; // Thêm biến để theo dõi trạng thái tải tỉnh/thành
  bool _isLoadingDistricts = false; // Thêm biến để theo dõi trạng thái tải quận/huyện

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchProvinces();
  }

  Future<void> _fetchProvinces() async {
    setState(() {
      _isLoadingProvinces = true; // Bắt đầu tải tỉnh/thành
    });
    final response = await http.get(Uri.parse('https://provinces.open-api.vn/api/p/')); // Lấy danh sách tỉnh/thành
    if (response.statusCode == 200) {
      // Giải mã dữ liệu bằng UTF-8
      final String responseBody = utf8.decode(response.bodyBytes);
      setState(() {
        _provinces = json.decode(responseBody);
        _isLoadingProvinces = false; // Kết thúc tải tỉnh/thành
      });
    } else {
      setState(() {
        _isLoadingProvinces = false; // Kết thúc tải tỉnh/thành (lỗi)
      });
      throw Exception('Failed to load provinces');
    }
  }

  Future<void> _fetchDistricts(int provinceCode) async {
    setState(() {
      _isLoadingDistricts = true; // Bắt đầu tải quận/huyện
    });
    final response = await http.get(Uri.parse('https://provinces.open-api.vn/api/p/$provinceCode?depth=2')); // Lấy danh sách quận/huyện
    if (response.statusCode == 200) {
      // Giải mã dữ liệu bằng UTF-8
      final String responseBody = utf8.decode(response.bodyBytes);
      setState(() {
        _districts = json.decode(responseBody)['districts'];
        _isLoadingDistricts = false; // Kết thúc tải quận/huyện
      });
    } else {
      setState(() {
        _isLoadingDistricts = false; // Kết thúc tải quận/huyện (lỗi)
      });
      throw Exception('Failed to load districts');
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _avatar = File(image.path);
      });
    }
  }

  void _submitForm() {
    // Xử lý khi người dùng nhấn nút lưu
    print("Full Name: ${_fullNameController.text}");
    print("Phone: ${_phoneController.text}");
    print("Address: ${_addressController.text}");
    print("Date of Birth: ${_dobController.text}");
    print("Province: $_selectedProvince");
    print("District: $_selectedDistrict");
    if (_avatar != null) {
      print("Avatar Path: ${_avatar!.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Hồ sơ'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Avatar với hướng dẫn upload
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _avatar != null ? FileImage(_avatar!) : null,
                      child: _avatar == null ? Icon(CupertinoIcons.person, size: 50) : null,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CupertinoIcons.camera,
                        size: 20,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Nhấn để đổi ảnh đại diện',
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.secondaryLabel,
                ),
              ),
              SizedBox(height: 20),
              // Full Name
              CupertinoTextField(
                controller: _fullNameController,
                placeholder: 'Họ và tên',
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SizedBox(height: 16.0),
              // Phone
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
              // Date of Birth
              CupertinoTextField(
                controller: _dobController,
                placeholder: 'Ngày sinh',
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onTap: () async {
                  final DateTime? picked = await showCupertinoModalPopup<DateTime>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
                        color: CupertinoColors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoButton(
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoButton(
                                  child: Text('Chọn'),
                                  onPressed: () {
                                    Navigator.pop(context, DateTime.now());
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(() {
                                    _dobController.text = "${newDate.toLocal()}".split(' ')[0];
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 16.0),
              // Bao phần tỉnh/thành và quận/huyện lại
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity, // Đặt chiều rộng bằng vô cực
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Địa chỉ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      // Province
                      if (_isLoadingProvinces)
                        Center(
                          child: CupertinoActivityIndicator(), // Hiển thị loading khi đang tải tỉnh/thành
                        )
                      else
                        CupertinoButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoActionSheet(
                                  title: Text('Chọn tỉnh/thành'),
                                  actions: _provinces.map<CupertinoActionSheetAction>((province) {
                                    return CupertinoActionSheetAction(
                                      onPressed: () {
                                        setState(() {
                                          _selectedProvince = province['name'];
                                          _fetchDistricts(province['code']); // Truyền province['code'] (kiểu int)
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text(province['name']),
                                    );
                                  }).toList(),
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Hủy'),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(_selectedProvince ?? 'Chọn tỉnh/thành'),
                        ),
                      SizedBox(height: 16.0),
                      // District
                      if (_isLoadingDistricts)
                        Center(
                          child: CupertinoActivityIndicator(), // Hiển thị loading khi đang tải quận/huyện
                        )
                      else
                        CupertinoButton(
                          onPressed: _selectedProvince == null
                              ? null
                              : () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoActionSheet(
                                  title: Text('Chọn quận/huyện'),
                                  actions: _districts.map<CupertinoActionSheetAction>((district) {
                                    return CupertinoActionSheetAction(
                                      onPressed: () {
                                        setState(() {
                                          _selectedDistrict = district['name'];
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text(district['name']),
                                    );
                                  }).toList(),
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Hủy'),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(_selectedDistrict ?? 'Chọn quận/huyện'),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Address
              CupertinoTextField(
                controller: _addressController,
                placeholder: 'Địa chỉ chi tiết',
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SizedBox(height: 32.0),
              // Save Button
              CupertinoButton(
                onPressed: _submitForm,
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(8.0),
                child: Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}