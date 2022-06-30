class BusI {
  final int id;
  final String uid;

  BusI(this.id, this.uid);

  factory BusI.fromJson(Map<String, dynamic> json) {
    return BusI(
      json['id'],
      json['busUid'],
    );
  }
}
