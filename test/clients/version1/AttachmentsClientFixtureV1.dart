import 'package:test/test.dart';
import 'package:pip_services_attachments/pip_services_attachments.dart';
import 'package:pip_clients_attachments/pip_clients_attachments.dart';

class AttachmentsClientFixtureV1 {
  IAttachmentsClientV1 _client;

  AttachmentsClientFixtureV1(IAttachmentsClientV1 client) {
    expect(client, isNotNull);
    _client = client;
  }

  void testCrudOperations() async {
    // Add attachments
    var attachments = await _client.addAttachments(
        null,
        ReferenceV1(
            id: '000000000000000000000011', type: 'goal', name: 'Goal 1'),
        ['1', '2']);

    expect(attachments, isNotNull);

    // Add other attachments
    attachments = await _client.addAttachments(
        null,
        ReferenceV1(
            id: '000000000000000000000012', type: 'goal', name: 'Goal 2'),
        ['2', '3']);

    expect(attachments, isNotNull);

    // Check attachments has references
    var item = await _client.getAttachmentById(null, '2');
    expect(item, isNotNull);
    expect(item.references.length, 2);

    // Remove reference
    attachments = await _client.updateAttachments(
        null,
        ReferenceV1(id: '000000000000000000000011', type: 'goal', name: null),
        ['1', '2'],
        ['1']);

    expect(attachments, isNotNull);

    // Remove another reference
    attachments = await _client.removeAttachments(
        null,
        ReferenceV1(id: '000000000000000000000011', type: 'goal', name: null),
        ['1']);

    expect(attachments, isNotNull);

    // Remove attachments
    item = await _client.deleteAttachmentById(null, '1');

    expect(item, isNull);

    // Get another attachments
    item = await _client.getAttachmentById(null, '2');
    expect(item, isNotNull);
    expect(item.references.length, 1);

    var reference = item.references[0];
    expect(reference.id, '000000000000000000000012');
  }
}
