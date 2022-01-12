import 'package:json_annotation/json_annotation.dart';
part 'Events.g.dart';

@JsonSerializable(nullable: false)
class Events {
  int user_id;
  String title;
  String description;
  String rundown;
  DateTime heldOn;
  DateTime finished;
  int kode_event;
  int no_telph;
  
Events( {this.user_id, this.title, this.description, this.rundown, this.heldOn, this.finished, this.kode_event, this.no_telph});
factory Events.fromJson(Map<String, dynamic> json) => _$EventsFromJson(json);

Map<String, dynamic> toJson() => _$EventsToJson(this);
 
  // Map toEvents() {
  //   var map = new Map<String, dynamic>();
  //   map["user_id"] = user_id;
  //   map["title"] = title;
  //   map["description"] = description;
  //   map["rundown"] = rundown;
  //   map["heldOn"] = heldOn;
  //   map["finished"] = finished;
  //   map["kode_event"] = kode_event;
  //   map["no_telph"] = no_telph;
  
  //   return map;
  // }


}