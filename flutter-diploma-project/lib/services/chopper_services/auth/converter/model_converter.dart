import 'package:chopper/chopper.dart';

class ModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    return encodeJson(req);
  }

  Request encodeJson(Request request) {}

  Response decodeJson<BodyType, InnerType>(Response response) {}

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {}
}
