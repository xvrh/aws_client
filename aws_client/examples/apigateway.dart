import 'package:aws_client/apis/apigateway/2015-07-09.dart';

void main() async {
  final api = APIGateway(region: 'eu-west-1');
  await api.getExport(exportType: null, restApiId: null, stageName: null);
}
