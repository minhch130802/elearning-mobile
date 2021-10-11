class CompletionData {
  CompletionData({
    this.state,
    this.timeCompleted,
    this.overrideBy,
    this.valueUsed
  });

  int? state;
  int? timeCompleted;
  String? overrideBy;
  bool? valueUsed;

  CompletionData.fromJSON(Map<String, dynamic> json){
    this.state = json['state'];
    this.timeCompleted = json['timecompleted'];
    this.overrideBy = json['overrideby'];
    this.valueUsed = json['valueused'];
  }
}