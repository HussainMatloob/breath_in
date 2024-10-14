import 'package:audioplayers/audioplayers.dart';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/audio_controller.dart';
import 'package:breath_in/models/messages_model.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReceiverVoiceWidget extends StatefulWidget {
  final MessagesModel?  messagesModel;
  const ReceiverVoiceWidget({super.key, this.messagesModel,  });

  @override
  State<ReceiverVoiceWidget> createState() => _ReceiverVoiceWidgetState();
}

class _ReceiverVoiceWidgetState extends State<ReceiverVoiceWidget> {
  @override
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isSeeking = false; // Add this to prevent rebuild during seek

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Listen for audio duration changes
    _audioPlayer.onDurationChanged.listen((Duration newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listen for audio position changes
    _audioPlayer.onPositionChanged.listen((Duration newPosition) {
      if (!isSeeking) {
        setState(() {
          position = newPosition;
        });
      }
    });

    // Reset on completion
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  Future<void> _seek(double seconds) async {
    final newPosition = Duration(seconds: seconds.toInt());
    await _audioPlayer.seek(newPosition);
  }

  // Play the audio
  Future<void> _play() async {
    await _audioPlayer.play(UrlSource(widget.messagesModel!.message!));
    setState(() {
      isPlaying = true;
    });
  }

  // Pause the audio
  Future<void> _pause() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  // Format duration to mm:ss
  String _formatDuration(Duration d) {
    String minutes = d.inMinutes.toString().padLeft(2, '0');
    String seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
  AudioController audioController=Get.put(AudioController());
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only( right: 50.0.w,top: 8.h,bottom: 8.h),
      padding: EdgeInsets.only( left:8.w, right: 8.0.w,top: 8.h,bottom: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200, // Style the container
      ),
      child: Row(
        children: [
          // Play / Pause Button

          InkWell(
              onTap: (){
                if(isPlaying){
                  _pause();
                }else{
                  _play();
                }

              },
              child: Icon( isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 30,
                color: Colors.blue)),

          // Audio Progress
          Expanded(
            child: Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  isSeeking = true;
                  position = Duration(seconds: value.toInt()); // Smooth update without rebuilding the entire widget
                });
              },
              onChangeEnd: (value) async {
                setState(() {
                  isSeeking = false; // Disable seeking state after user finishes dragging
                });
                await _seek(value); // Seek to the new position
              },
            ),
          ),
          // Current Time and Total Duration
          Text(
            '${_formatDuration(position)} / ${_formatDuration(duration)}',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
