import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/ui/widgets/loading_dialog.dart';
import 'package:lushan/utils/app_constant.dart';
import 'package:lushan/utils/config_utils.dart';

class SetAvatarPage extends StatefulWidget {
  const SetAvatarPage({Key? key}) : super(key: key);

  @override
  _SetAvatarPageState createState() => _SetAvatarPageState();
}

class _SetAvatarPageState extends State<SetAvatarPage> {
  bool _previewMode = false;
  final cropKey = GlobalKey<CropState>();

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool _capturing = false;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
        if (null != pickedFile) {
          _previewMode = true;
        }
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _imageFileList = response.files;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Widget _previewImageOnAndroid() {
    return FutureBuilder<void>(
      future: retrieveLostData(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('loading...');
          case ConnectionState.done:
            return _handlePreview();
          default:
            return _buildUserAvatarImage();
        }
      },
    );
  }

  Widget _handlePreview() {
    if (_imageFileList != null)
      return Container(
        color: Colors.black,
        child: Crop(
          alwaysShowGrid: true,
          key: cropKey,
          image: FileImage(File(_imageFileList![0].path)),
          aspectRatio: 4.0 / 3.0,
        ),
      );
    else
      return _buildUserAvatarImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('个人头像'),
        actions: [
          IconButton(
              onPressed: () {
                _showSelectImage();
              },
              icon: Icon(Icons.more_horiz))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                ? _previewImageOnAndroid()
                : _handlePreview(),
          )),
          if (_previewMode)
            Container(
              color: Colors.black87,
              padding: EdgeInsets.fromLTRB(24, 10, 24, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '取消',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {
                        _uploadAvatar();
                      },
                      child: Text('确认',
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.white)))
                ],
              ),
            )
        ],
      ),
    );
  }

  void _uploadAvatar() async {
    late BuildContext dialogContext;
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          dialogContext = context;
          return LoadingDialog();
        });
    // showDialog

    final crop = cropKey.currentState;
    final area = crop!.area;
    if (null == area) {
      print("error: area is null");
      return;
    }

    final sampleFile = await ImageCrop.sampleImage(
      file: File(_imageFileList![0].path),
      preferredWidth: (1024 / crop.scale).round(),
      preferredHeight: (4096 / crop.scale).round(),
    );
    final croppedFile = await ImageCrop.cropImage(
      file: sampleFile,
      area: area,
    );
    // var fileData = await croppedFile.readAsBytes();
    // var avatarUrl = await ApiService().uploadAvatar(fileData);
    var avatarUrl = await UseCaseLocator.uploadAvatarUseCase.execute(croppedFile.path);
    // save avatar url
    var userProfile = ConfigUtils.getUserProfile()!;
    userProfile.avatar = avatarUrl;
    ConfigUtils.saveUserProfile(userProfile);
    // hide dialog and pop
    Navigator.pop(dialogContext);
    Navigator.of(context).pop(userProfile);
  }

  _showSelectImage() {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text('相册'),
            onPressed: () {
              Navigator.of(context).pop();
              _onImageButtonPressed(ImageSource.gallery);
            }),
        BottomSheetAction(
            title: const Text('相机'),
            onPressed: () {
              Navigator.of(context).pop();
              _onImageButtonPressed(ImageSource.camera);
            }),
      ],
      cancelAction: CancelAction(
          title: const Text(
              '取消')), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  Widget _buildUserAvatarImage() {
    var userAvatar = ConfigUtils.getUserProfile()!.avatar;
    if (userAvatar.isEmpty) {
      return Image(
        image: AssetImage(AppConstant.defaultAvatarPath),
      );
    } else {
      // todo 头像先全部使用本地图片
      return Image(
        image: AssetImage(userAvatar),
      );
      // return CachedNetworkImage(imageUrl: userAvatar);
    }
  }
}
