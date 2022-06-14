import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({
    this.onTap,
    this.camera,
  });
  final Function(XFile image) onTap;
  final CameraDescription camera;

  /// Pass camera object to the [CameraDescription] to able to show camera

  @override
  CameraWidgetState createState() => CameraWidgetState();
}

class CameraWidgetState extends State<CameraWidget>
    with WidgetsBindingObserver {
  CameraController _controller;
  // late Future<void> _initializeControllerFuture;
  double zoom = 1.0;
  double _scaleFactor = 1.0;
  Future<void> _initializeControllerFuture;
  bool _isFlash = false;
  Future<void> _initialize() async {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution veryhigh for better picture quality.
      ResolutionPreset.high,
      enableAudio: false,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _initializeControllerFuture = _controller.initialize();
    _controller.lockCaptureOrientation();

    // _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    this._isFlash = false;
    final CameraController cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      this._controller = CameraController(
        widget.camera,
        // Define the resolution veryhigh for better picture quality.
        ResolutionPreset.veryHigh,
        enableAudio: false,
      );

      if (mounted) {
        setState(() {
          this._initializeControllerFuture = this._controller.initialize();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        //  wait until the controller is initialized before displaying the
        // camera preview.  display a loading spinner until the
        // controller has finished initializing.
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Stack(
                children: [
                  Positioned.fill(
                    child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: CameraPreview(_controller)),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: SvgPicture.asset(
                              "assets/customCamera/back.svg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              if (!_isFlash) {
                                if (mounted) {
                                  setState(() {
                                    _controller.setFlashMode(FlashMode.torch);
                                    _isFlash = true;
                                  });
                                }
                              } else {
                                if (mounted) {
                                  setState(() {
                                    _controller.setFlashMode(FlashMode.off);
                                    _isFlash = false;
                                  });
                                }
                              }
                            },
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: _isFlash
                                  ? SvgPicture.asset(
                                      "assets/customCamera/flash-on.svg",
                                      fit: BoxFit.cover)
                                  : SvgPicture.asset(
                                      "assets/customCamera/flash-off.svg",
                                      fit: BoxFit.cover),
                            )),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment(0, -0.25),
                      child: SizedBox(
                        // height: MediaQuery.of(context).size.height / 2,
                        height: MediaQuery.of(context).size.width * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Image.asset(
                          "assets/customCamera/focus.png",
                        ),
                      )),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 23),
                      child: SizedBox(
                          height: 32,
                          width: 40,
                          child: SvgPicture.asset(
                            "assets/customCamera/logo.svg",
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 120),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 30, right: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: const Text(
                        "Tap button to scan",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                          onTap: () async {
                            // Take the Picture in a try / catch block. If anything goes wrong,
                            // catch the error.
                            try {
                              // Ensure that the camera is initialized.
                              await _initializeControllerFuture;

                              // Attempt to take a picture and get the file `image`
                              // where it was saved.
                              final image = await _controller.takePicture();
                              widget.onTap(image);
                              Navigator.pop(context);
                              // image.readAsBytes().then(
                              //     (value) => debugPrint(value.toString()));
                            } catch (e) {
                              // If an error occurs, log the error to the console.
                              debugPrint(e.toString());
                            }
                          },
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                  "assets/customCamera/button.png"))),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onScaleStart: (details) {
                      zoom = _scaleFactor;
                    },
                    onScaleUpdate: (details) {
                      _scaleFactor = zoom * details.scale;
                      if (_scaleFactor >= 1 && _scaleFactor <= 10) {
                        _controller.setZoomLevel(_scaleFactor);
                      }
                    },
                  ),
                ],
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
