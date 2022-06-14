class MotorReportModel {
  String reportId;
  String userId;
  String purchaseId;
  String plateNumber;
  DateTime purchaseDate;
  String paymentMethod;

  String make;
  String model;
  int year;
  String subModel;

  MotorReportModel(
      {this.reportId,
      this.userId,
      this.purchaseId,
      this.plateNumber,
      this.purchaseDate,
      this.make,
      this.model,
      this.year,
      this.subModel,
      this.paymentMethod});
}
