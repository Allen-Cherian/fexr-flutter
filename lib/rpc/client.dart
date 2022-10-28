import 'package:fexr/protogen/sky.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:fexr/sync-v1/signature/gen_sign.dart';

class Client {
  late SkyServiceClient stub;
  late ClientChannel channel;

  Future<ChallengeRes> challenge(ChallengeReq req, String proxyIP) async {
    final channel = ClientChannel(
      proxyIP,
      port: 6942,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        codecRegistry:
            CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      ),
    );
    stub = SkyServiceClient(channel,
        options: CallOptions(timeout: Duration(seconds: 10)));
    try {
      ChallengeRes result = await stub.challenge(req);
      String challengePayload = result.challengePayload;
      String signature = await GenerateSign().sign(challengePayload);
      return ChallengeRes(challengePayload: signature);

//      return await stub.challenge(req);
    } catch (e) {
      return ChallengeRes();

    }
  }
  Future<HostRes> host(HostReq req, String proxyIp) async {
    final channel = ClientChannel(
      proxyIp,
      port:6942,
      options: ChannelOptions(
        credentials:ChannelCredentials.insecure(),
        codecRegistry:
        CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),

      ),
    );
    stub = SkyServiceClient(channel,
        options: CallOptions(timeout: Duration(seconds: 10)));
    try {
      HostRes result = await stub.host(req);
      return result;
    } catch (e) {
      return HostRes();
    }
  }
}