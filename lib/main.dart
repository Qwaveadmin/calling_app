import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video Call Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VideoCallPage(title: 'Flutter Video Call Demo'),
    );
  }
}

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key, required this.title});

  final String title;

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  // สมมติว่าเรามี PeerConnection และสตรีมแล้ว
  // RTCPeerConnection? _peerConnection;
  // MediaStream? _localStream;

  @override
  void initState() {
    super.initState();
    initRenderers();
    // initializePeerConnection(); // คุณจะต้องเขียนฟังก์ชันนี้เพื่อตั้งค่าการเชื่อมต่อ
  }

  Future<void> initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  // สมมติว่ามีฟังก์ชันสำหรับการตั้งค่า PeerConnection และการจัดการสตรีม

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: RTCVideoView(_localRenderer),
          ),
          Expanded(
            child: RTCVideoView(_remoteRenderer),
          ),
        ],
      ),
    );
  }
}
