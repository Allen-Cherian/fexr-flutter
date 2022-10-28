import 'dart:async';

import 'package:fexr/protogen/sky.pbgrpc.dart';

class SkyService {
  final StreamController<ChallengeReq> _controller;
    
  SkyService() :
        _controller = StreamController<ChallengeReq>();

  void sendToStream() {
    _controller.add(ChallengeReq(

    ));
  



  }

}