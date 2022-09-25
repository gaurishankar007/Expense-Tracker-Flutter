import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../local/login_data.dart';
import '../model/income_model.dart';
import '../urls.dart';

class IncomeHttp {
  final base = URL.base;
  final token = LoginData.token;

  Future<Map> addIncome(IncomeData incomeDetail) async {
    try {
      Map<String, String> incomeData = {
        "name": incomeDetail.name!,
        "amount": incomeDetail.amount!.toString(),
        "category": incomeDetail.category!,
      };
      final response = await post(
        Uri.parse(base + IncomeUrls.addIncome),
        body: incomeData,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<IncomeDWM> getIncomeDWM() async {
    try {
      final response = await get(
        Uri.parse(base + IncomeUrls.getIncomeDWM),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      final resData = jsonDecode(response.body);

      return IncomeDWM.fromJson(resData);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<IncomeSpecific> getIncomeSpecific(
      String startDate, String endDate) async {
    try {
      final response = await post(
        Uri.parse(base + IncomeUrls.getIncomeSpecific),
        body: {"startDate": startDate, "endDate": endDate},
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      final resData = jsonDecode(response.body);

      return IncomeSpecific.fromJson(resData);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> removeIncome(String incomeId) async {
    try {
      final response = await delete(
        Uri.parse(base + IncomeUrls.removeIncome),
        body: {"incomeId": incomeId},
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return jsonDecode(response.body) as Map;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> editIncome(IncomeData income) async {
    try {
      Map<String, String> incomeData = {
        "incomeId": income.id!,
        "name": income.name!,
        "amount": income.amount!.toString(),
        "category": income.category!,
      };

      final response = await put(
        Uri.parse(base + IncomeUrls.editIncome),
        body: incomeData,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<IncomeData>> getCategorizedIncome(String category) async {
    try {
      final response = await post(
        Uri.parse(base + IncomeUrls.getCategorizedIncome),
        body: {
          "category": category,
        },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      List resData = jsonDecode(response.body);

      return resData.map((e) => IncomeData.fromJson(e)).toList();
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<IncomeData>> getCategorizedSpecificIncome(
      String category, String startDate, String endDate) async {
    try {
      Map<String, String> incomeData = {
        "startDate": startDate,
        "endDate": endDate,
        "category": category,
      };

      final response = await post(
        Uri.parse(base + IncomeUrls.getCategorizedSpecificIncome),
        body: incomeData,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      List resData = jsonDecode(response.body);

      return resData.map((e) => IncomeData.fromJson(e)).toList();
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<String> getCategoryStartDate(String category) async {
    try {
      final response = await post(
        Uri.parse(base + IncomeUrls.getCategoryStartDate),
        body: {
          "category": category,
        },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return response.body;
    } catch (error) {
      return Future.error(error);
    }
  }
}
