import 'package:dio/dio.dart';

extension HttpStatusCodeDescription on DioException {
  static Map<int, String> statusCodes = {
    // Códigos de status comuns e suas descrições
    200: 'OK',
    400: 'Requisição incorreta',
    401: 'Não autorizado',
    403: 'Proibido',
    404: 'Não encontrado',
    500: 'Erro interno do servidor',
    // ... (adicione mais códigos de status HTTP e suas descrições)
  };

  String get getHttpStatusDescription {
    if (statusCodes.containsKey(response?.statusCode)) {
      return statusCodes[response?.statusCode]!;
    } else if (response?.statusCode == null && type == DioExceptionType.connectionTimeout) {
      return 'Ops! Parece que a consulta está demorando mais do que o esperado. Tente novamente em alguns instantes.';
    } else {
      return 'Código de status HTTP ${response?.statusCode} não reconhecido.';
    }
  }
}
