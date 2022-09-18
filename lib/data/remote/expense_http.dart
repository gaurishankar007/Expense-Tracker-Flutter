import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../log_status.dart';
import '../model/expense_model.dart';
import '../urls.dart';

class ExpenseHttp {
  final baseUrl = ApiUrls.baseUrl;
  final token = LogStatus.token;

  Future<Map> addExpense(ExpenseData expenseDetail) async {
    try {
      Map<String, String> expenseData = {
        "name": expenseDetail.name!,
        "amount": expenseDetail.amount!.toString(),
        "category": expenseDetail.category!,
      };

      final response = await post(
        Uri.parse(baseUrl + ExpenseUrls.addExpense),
        body: expenseData,
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

  Future<ExpenseDWM> getExpenseDWM() async {
    try {
      final response = await get(
        Uri.parse(baseUrl + ExpenseUrls.getExpenseDWM),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      final resData = jsonDecode(response.body);

      return ExpenseDWM.fromJson(resData);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ExpenseSpecific> getExpenseSpecific(
      String startDate, String endDate) async {
    try {
      final response = await post(
        Uri.parse(baseUrl + ExpenseUrls.getExpenseSpecific),
        body: {"startDate": startDate, "endDate": endDate},
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      final resData = jsonDecode(response.body);

      return ExpenseSpecific.fromJson(resData);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> removeExpense(String expenseId) async {
    try {
      final response = await delete(
        Uri.parse(baseUrl + ExpenseUrls.removeExpense),
        body: {"expenseId": expenseId},
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return jsonDecode(response.body) as Map;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> editExpense(ExpenseData expense) async {
    try {
      Map<String, String> expenseData = {
        "expenseId": expense.id!,
        "name": expense.name!,
        "amount": expense.amount!.toString(),
        "category": expense.category!,
      };

      final response = await put(
        Uri.parse(baseUrl + ExpenseUrls.editExpense),
        body: expenseData,
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

  Future<List<ExpenseData>> getCategorizedExpense(String category) async {
    try {
      final response = await post(
        Uri.parse(baseUrl + ExpenseUrls.getCategorizedExpense),
        body: {
          "category": category,
        },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      List resData = jsonDecode(response.body);

      return resData.map((e) => ExpenseData.fromJson(e)).toList();
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<ExpenseData>> getCategorizedSpecificExpense(
      String category, String startDate, String endDate) async {
    try {
      Map<String, String> expenseData = {
        "startDate": startDate,
        "endDate": endDate,
        "category": category,
      };

      final response = await post(
        Uri.parse(baseUrl + ExpenseUrls.getCategorizedSpecificExpense),
        body: expenseData,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      List resData = jsonDecode(response.body);

      return resData.map((e) => ExpenseData.fromJson(e)).toList();
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<String> getCategoryStartDate(String category) async {
    try {
      final response = await post(
        Uri.parse(baseUrl + ExpenseUrls.getCategoryStartDate),
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
