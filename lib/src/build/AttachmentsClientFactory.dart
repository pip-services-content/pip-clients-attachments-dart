import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../version1/AttachmentsNullClientV1.dart';
import '../version1/AttachmentsDirectClientV1.dart';
import '../version1/AttachmentsHttpClientV1.dart';

class AttachmentsClientFactory extends Factory {
  static final NullClientDescriptor =
      Descriptor('pip-services-attachments', 'client', 'null', '*', '1.0');
  static final DirectClientDescriptor =
      Descriptor('pip-services-attachments', 'client', 'direct', '*', '1.0');
  static final CommandableHttpClientDescriptor = Descriptor(
      'pip-services-attachments', 'client', 'commandable-http', '*', '1.0');

  AttachmentsClientFactory() : super() {
    registerAsType(
        AttachmentsClientFactory.NullClientDescriptor, AttachmentsNullClientV1);
    registerAsType(AttachmentsClientFactory.DirectClientDescriptor,
        AttachmentsDirectClientV1);
    registerAsType(AttachmentsClientFactory.CommandableHttpClientDescriptor,
        AttachmentsHttpClientV1);
  }
}
