import 'dart:async';

import 'package:flutter/services.dart';

import 'enum_nfc.dart';

/// Event data model for NFC reader state updates
class NfcReaderEvent {
  /// The current state of the NFC reader
  final ICNFCReaderState state;

  /// Progress percentage (0-100)
  final int progress;

  /// Error message (empty if no error)
  final String error;

  const NfcReaderEvent({
    required this.state,
    required this.progress,
    required this.error,
  });

  /// Factory constructor to parse from native event map
  factory NfcReaderEvent.fromMap(Map<dynamic, dynamic> map) {
    return NfcReaderEvent(
      state: ICNFCReaderState.fromInt(map['state'] as int? ?? 0),
      progress: map['progress'] as int? ?? 0,
      error: map['error'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'NfcReaderEvent(state: $state, progress: $progress%, error: $error)';
  }
}

/// Service class for managing NFC event stream from native layer
class NfcEventChannel {
  /// Channel name must match iOS EventChannel name
  static const EventChannel _eventChannel = EventChannel(
    'flutter.sdk.ic.nfc/events',
  );

  const NfcEventChannel();

  /// Stream of NFC reader state events
  ///
  /// This is a broadcast stream, allowing multiple listeners.
  /// Remember to cancel your subscription when done to prevent memory leaks:
  ///
  /// ```dart
  /// final subscription = ICNfc.instance.nfcReaderStateStream.listen(
  ///   (event) => print('State: ${event.state}'),
  /// );
  ///
  /// // Later, when done:
  /// await subscription.cancel();
  /// ```
  Stream<NfcReaderEvent> get readerStateStream {
    return _eventChannel.receiveBroadcastStream().map((dynamic event) {
      try {
        if (event is Map) {
          return NfcReaderEvent.fromMap(event);
        }
        // Fallback for unexpected data format
        return NfcReaderEvent(
          state: ICNFCReaderState.started,
          progress: 0,
          error: 'Invalid event format: $event',
        );
      } catch (e) {
        // Handle parsing errors gracefully
        return NfcReaderEvent(
          state: ICNFCReaderState.didError,
          progress: 0,
          error: 'Failed to parse event: $e',
        );
      }
    });
  }
}
