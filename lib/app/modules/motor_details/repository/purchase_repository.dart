import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../shared/models/motor_report_model.dart';

class MotorlyticsReportRepository {
  final Dio _client;

  MotorlyticsReportRepository(this._client);

  Future<Either<String, String>> getMotorlyticsReport(
      MotorReportModel motorReport) async {
    try {
      final result = await _client.post(
        "/lemon-check",
        data: {
          "reportId": motorReport.reportId,
          "userId": motorReport.userId,
          "purchaseId": motorReport.purchaseId,
        },
      );
      return Right(result.data["reportLink"]);
    } on Exception {
      return Left("Error when try buy");
    }
  }
}
