import 'dart:async';

import 'package:pip_services_attachments/pip_services_attachments.dart';
import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_attachments/pip_clients_attachments.dart';
import './AttachmentsClientFixtureV1.dart';

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  3000
]);

void main() {
  group('AttachmentsHttpClientV1', () {
    AttachmentsHttpClientV1 client;
    AttachmentsClientFixtureV1 fixture;
    AttachmentsMemoryPersistence persistence;
    AttachmentsController controller;
    AttachmentsHttpServiceV1 service;

    setUp(() async {
      persistence = AttachmentsMemoryPersistence();
      persistence.configure(ConfigParams());

      controller = AttachmentsController();
      controller.configure(ConfigParams());

      service = AttachmentsHttpServiceV1();
      service.configure(httpConfig);

      client = AttachmentsHttpClientV1();
      client.configure(httpConfig);
      var references = References.fromTuples([
        Descriptor('pip-services-attachments', 'persistence', 'memory',
            'default', '1.0'),
        persistence,
        Descriptor('pip-services-attachments', 'controller', 'default',
            'default', '1.0'),
        controller,
        Descriptor(
            'pip-services-attachments', 'service', 'http', 'default', '1.0'),
        service,
        Descriptor(
            'pip-services-attachments', 'client', 'http', 'default', '1.0'),
        client
      ]);
      controller.setReferences(references);
      service.setReferences(references);
      client.setReferences(references);
      fixture = AttachmentsClientFixtureV1(client);
      await persistence.open(null);
      await service.open(null);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
      await service.close(null);
      await persistence.close(null);
      await Future.delayed(Duration(milliseconds: 2000));
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });
  });
}
