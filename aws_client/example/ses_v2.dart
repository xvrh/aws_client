import 'package:aws_client/se_sv2_2019_09_27.dart';
import 'package:http/http.dart';

void main() async {
  final api = SesV2(region: 'eu-central-1');

  final response = await api.sendEmail(
    content: EmailContent(
      simple: Message(
        body: Body(text: Content(data: 'Hello, here is a message')),
        subject: Content(data: 'An email from SES'),
      ),
    ),
    destination: Destination(toAddresses: ['user@email.com']),
    fromEmailAddress: 'from@email.com',
  );
  print(response.messageId);

  api.close();
}
