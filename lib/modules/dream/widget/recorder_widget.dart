// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helmy_project/modules/dream/controller/dream_controller.dart';
import 'package:record/record.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:permission_handler/permission_handler.dart';

class RecorderExample extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  const RecorderExample({super.key, localFileSystem})
      : localFileSystem = localFileSystem ?? const LocalFileSystem();

  @override
  State<StatefulWidget> createState() => RecorderExampleState();
}

class RecorderExampleState extends State<RecorderExample> {

  bool isClickedBtn = false;
  final record = AudioRecorder();
  late String customPathRecord = '';

  late String statusText = "";
  bool isComplete = false;
  late String recordFilePath;

  final DreamController dreamController = Get.find<DreamController>();

  @override
  void initState() {
    super.initState();
  }

  Future<String> _getPath() async {
    String customPath = '/helmy_audio_recorder_';
    io.Directory appDocDirectory;
    //  io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = (await getExternalStorageDirectory())!;
    }

    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString();
    return customPath;
  }


   Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }


  void _startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await _getPath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void _stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {
        dreamController.voiceRecord.value = recordFilePath;
      });
    } else {
      statusText = "Failed to stop recording";
    }
  }


  @override
  void dispose() {
    record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isClickedBtn = !isClickedBtn;
              if (isClickedBtn) {
                _startRecord();
              } else {
                _stopRecord();
              }
            });
          },
          child: isClickedBtn == false
                  ? Container(
            width: 64.sp,
            height: 64.sp,
            decoration: const BoxDecoration(
              // color: isClickedBtn
              //     ? ColorsManager.primaryTxt1LightGrey.withOpacity(0.25)
              //     : Colors.transparent,
              shape: BoxShape.circle,
              image:  DecorationImage(
                  image: AssetImage(
                    AssetsManager.micRecorder,
                  ),
                  fit: BoxFit.cover),
            ),
          ): Container(
             width: 64.sp,
            height: 64.sp,
            decoration: const BoxDecoration(
               shape: BoxShape.circle,
               color: ColorsManager.buttonDarkColor
            ),
            child: const Icon(Icons.stop,color: Colors.white,size: 45,),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
       
      ],
    );
   
  }

  void onPlayAudio({required String path}) async {
    AudioPlayer audioPlayer = AudioPlayer();
    // await audioPlayer.setSourceAsset(path);
    await audioPlayer.play(
      UrlSource(path),
    );
  }
}
