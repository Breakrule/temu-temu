// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Events _$EventsFromJson(Map<String, dynamic> json) {
  return Events(
      user_id: json['user_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      rundown: json['rundown'] as String,
      heldOn: DateTime.parse(json['heldOn'] as String),
      finished: DateTime.parse(json['finished'] as String),
      kode_event: json['kode_event'] as int,
      no_telph: json['no_telph'] as int);
}

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'title': instance.title,
      'description': instance.description,
      'rundown': instance.rundown,
      'heldOn': instance.heldOn.toIso8601String(),
      'finished': instance.finished.toIso8601String(),
      'kode_event': instance.kode_event,
      'no_telph': instance.no_telph
    };
