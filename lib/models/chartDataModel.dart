class ChartData {
  int earning=0;
  String date;
  String day;

  ChartData(this.date,this.earning,this.day);
  ChartData.p();
  ChartData.fromJson(Map<String, dynamic> json) {
    try {
      earning = json['amount'] != null ? int.parse('${json['amount']}') : null;
      date = json['date'] != null ? json['date'] : null;
      day = json['day'] != null ? json['day'] : "m ";
    } catch (e) {
      print("Exception - chartDataModel.dart - ChartDataModel.fromJson():" + e.toString());
    }
  }
}
