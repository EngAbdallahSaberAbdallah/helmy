// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
// import 'package:file/file.dart';
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
  // FlutterVoiceRecorder? _recorder;
  // Recording? _current;
  // RecordingStatus _currentStatus = RecordingStatus.Unset;
  
  //TODO: recorder video
  //https://www.youtube.com/watch?v=j4mX0jtxWpA
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

  // _start() async {
  //   // Check and request permission if needed
  //   if (await record.hasPermission()) {
  //     // Start recording to file
  //     final String pathRecord = await _getPath();
  //     await record.start(const RecordConfig(), path: '$pathRecord.m4a');

  //     // ... or to stream
  //     // final stream = await record.startStream(const RecordConfig(AudioEncoder.pcm16bits));
  //   }
  // }

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

  // _stop() async {
  //   // Stop recording...
  //   final path = await record.stop();
  //   setState(() {
  //     customPathRecord = path.toString();
  //     dreamController.voiceRecord.value =  path.toString();

  //   });
  // }

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
        // (isClickedBtn)
        //     ? Text(
        //         'نسجيل',
        //         style: getRegularStyle(color: ColorsManager.primaryDarkPurple),
        //       )
        //     : const SizedBox(),
        // InkWell(
        //   onTap: () {
        //     onPlayAudio(path: customPathRecord);
        //   },
        //   child: Text(
        //     'تشغيل',
        //     style: getRegularStyle(color: ColorsManager.primaryDarkPurple),
        //   ),
        // )
      ],
    );
    // Center(
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child:
    //         Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: MaterialButton(
    //               onPressed: () {
    //                 switch (_currentStatus) {
    //                   case RecordingStatus.Initialized:
    //                     {
    //                       _start();
    //                       break;
    //                     }
    //                   case RecordingStatus.Recording:
    //                     {
    //                       _pause();
    //                       break;
    //                     }
    //                   case RecordingStatus.Paused:
    //                     {
    //                       _resume();
    //                       break;
    //                     }
    //                   case RecordingStatus.Stopped:
    //                     {
    //                       _init();
    //                       break;
    //                     }
    //                   default:
    //                     break;
    //                 }
    //               },
    //               color: Colors.lightBlue,
    //               child: _buildText(_currentStatus),
    //             ),
    //           ),
    //           MaterialButton(
    //             onPressed:
    //                 _currentStatus != RecordingStatus.Unset ? _stop : null,
    //             color: Colors.blueAccent.withOpacity(0.5),
    //             child:
    //                 const Text("Stop", style: TextStyle(color: Colors.white)),
    //           ),
    //           const SizedBox(
    //             width: 8,
    //           ),
    //           MaterialButton(
    //             onPressed: onPlayAudio,
    //             color: Colors.blueAccent.withOpacity(0.5),
    //             child:
    //                 const Text("Play", style: TextStyle(color: Colors.white)),
    //           ),
    //         ],
    //       ),
    //       Text("Status : $_currentStatus"),
    //       Text('Avg Power: ${_current?.metering.averagePower}'),
    //       Text('Peak Power: ${_current?.metering.peakPower}'),
    //       Text("File path of the record: ${_current?.path}"),
    //       Text("Format: ${_current?.audioFormat}"),
    //       Text("isMeteringEnabled: ${_current?.metering.isMeteringEnabled}"),
    //       Text("Extension : ${_current?.extension}"),
    //       Text("Audio recording duration : ${_current?.duration.toString()}")
    //     ]),
    //   ),
    // );
  }

//   _init() async {
//     try {
//       if (await FlutterVoiceRecorder.hasPermissions) {
//         String customPath = '/helmy_audio_recorder_';
//         io.Directory appDocDirectory;
// //        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
//         if (io.Platform.isIOS) {
//           appDocDirectory = await getApplicationDocumentsDirectory();
//         } else {
//           appDocDirectory = (await getExternalStorageDirectory())!;
//         }

//         // can add extension like ".mp4" ".wav" ".m4a" ".aac"
//         customPath = appDocDirectory.path +
//             customPath +
//             DateTime.now().millisecondsSinceEpoch.toString();

//         // .wav <---> AudioFormat.WAV
//         // .mp4 .m4a .aac <---> AudioFormat.AAC
//         // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
//         _recorder =
//             FlutterVoiceRecorder(customPath, audioFormat: AudioFormat.WAV);

//         await _recorder?.initialized;
//         // after initialization
//         var current = await _recorder?.current(channel: 0);
//         print('current and current status is $current and ${current!.status}');
//         // should be "Initialized", if all working fine
//         setState(() {
//           _current = current;
//           _currentStatus = current!.status;
//           print(_currentStatus);
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("You must accept permissions")));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

  // _start() async {
  //   try {
  //     print('I am in start record');
  //     await _recorder!.start();
  //     print('I am in start record after record started');
  //     var recording = await _recorder!.current(channel: 0);
  //     setState(() {
  //       _current = recording;
  //     });

  //     const tick = Duration(milliseconds: 50);
  //     Timer.periodic(tick, (Timer t) async {
  //       if (_currentStatus == RecordingStatus.Stopped) {
  //         t.cancel();
  //       }

  //       var current = await _recorder!.current(channel: 0);
  //       print('current status is ${current!.status}');
  //       setState(() {
  //         _current = current;
  //         _currentStatus = _current!.status;
  //       });
  //       print('current status is ${current.status}');
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // _resume() async {
  //   await _recorder!.resume();
  //   setState(() {});
  // }

  // _pause() async {
  //   await _recorder!.pause();
  //   setState(() {});
  // }

  // _stop() async {
  //   var result = await _recorder!.stop();
  //   print("Stop recording: ${result!.path}");
  //   print("Stop recording: ${result.duration}");
  //   File file = widget.localFileSystem.file(result.path);
  //   print("File length: ${await file.length()}");
  //   setState(() {
  //     _current = result;
  //     _currentStatus = _current!.status;
  //   });
  //   print('current status in stop is ${_current!.status}');
  // }

  // Widget _buildText(RecordingStatus status) {
  //   var text = "";
  //   switch (_currentStatus) {
  //     case RecordingStatus.Initialized:
  //       {
  //         text = 'Start';
  //         break;
  //       }
  //     case RecordingStatus.Recording:
  //       {
  //         text = 'Pause';
  //         break;
  //       }
  //     case RecordingStatus.Paused:
  //       {
  //         text = 'Resume';
  //         break;
  //       }
  //     case RecordingStatus.Stopped:
  //       {
  //         text = 'Init';
  //         break;
  //       }
  //     default:
  //       break;
  //   }
  //   return Text(text, style: const TextStyle(color: Colors.white));
  // }

  void onPlayAudio({required String path}) async {
    AudioPlayer audioPlayer = AudioPlayer();
    // await audioPlayer.setSourceAsset(path);
    await audioPlayer.play(
      UrlSource(path),
    );
  }
}
