class Result {
  final int total;
  final int count;
  final double average;

  Result(this.total, this.count, this.average);

  Result.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        count = json['count'],
        average = json['average'];

  Map<String, dynamic> toJson() => {
        'total': total,
        'count': count,
        'average': average,
      };
}
