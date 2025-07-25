import '../../base/core/core.dart';

Future<void> sleep(Duration duration) async {
  await Future.delayed(duration);
}

class Polling {
  Map sync = { "talk": {} };

  BaseClient client;
  Polling(this.client);

  Stream<dynamic> listenSquareEvents({required Map options}) async* {
    dynamic signal = options["signal"];
    Function? onError = options["onError"];
    int pollingInterval = options["pollingInterval"] ?? 1000;

    String? continuationToken;
    while (true) {
      try {
        dynamic response = await client.square.fetchMyEvents(
          sync["square"],
          continuationToken,
          100,
        );
        sync["square"] = response["syncToken"];
        continuationToken = response["continuationToken"];
        for (dynamic event in response["events"]) {
          yield event;
        }
      } catch (error) {
        if (onError != null) {
          onError(error);
        }
      }
      await sleep(Duration(milliseconds: pollingInterval));
      if (signal != null && signal.isClosed) {
        break;
      }
    }
  }

  Stream<dynamic> listenTalkEvents({ required Map options }) async* {
    dynamic signal = options["signal"];
    Function? onError = options["onError"];
    int pollingInterval = options["pollingInterval"] ?? 1000;
    while (true) {
      try {
        Map param = { "limit": 100 };
        param.addAll(sync["talk"]);
        dynamic response= await client.talk.sync(param);
        if (response["fullSyncResponse"].isNotEmpty && response["fullSyncResponse"]["nextRevision"] != null) {
          sync["talk"]["revision"] = response["fullSyncResponse"]["nextRevision"];
        }
        if (response["operationResponse"].isNotEmpty && response["operationResponse"]["glovalEvents"].isNotEmpty && response["operationResponse"]["glovalEvents"]["lastRevision"] != null) {
          sync["talk"]["glovalRev"] = response["operationResponse"]["glovalEvents"]["lastRevision"];
        }
        if (response["operationResponse"].isNotEmpty && response["operationResponse"]["individualEvents"].isNotEmpty && response["operationResponse"]["individualEvents"]["lastRevision"] != null) {
          sync["talk"]["individualRev"] = response["operationResponse"]["individualEvents"]["lastRevision"];
        }
        if (!(response["operationResponse"].isNotEmpty && response["operationResponse"]["operations"].isNotEmpty)) {
          continue;
        }
        for (dynamic event in response["operationResponse"]["operations"]) {
          sync["talk"]["revision"] = event["revision"];
          yield event;
        }
      } catch (error) {
        if (onError != null) {
          onError(error);
        }
      }
      await sleep(Duration(milliseconds: pollingInterval));
      if (signal != null && signal.isClosed) {
        break;
      }
    }
  }
}