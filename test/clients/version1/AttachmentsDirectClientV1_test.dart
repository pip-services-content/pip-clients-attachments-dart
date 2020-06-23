import 'dart:async';
import 'package:test/test.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services_attachments/pip_services_attachments.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_attachments/pip_clients_attachments.dart';
import './AttachmentsClientFixtureV1.dart';

void main() {
  group('AttachmentsDirectClientV1', () {
    AttachmentsDirectClientV1 client;
    AttachmentsClientFixtureV1 fixture;
    AttachmentsMemoryPersistence persistence;
    AttachmentsController controller;

    setUp(() async {
      var logger = ConsoleLogger();
      persistence = AttachmentsMemoryPersistence();
      controller = AttachmentsController();
      var references = References.fromTuples([
        Descriptor('pip-services', 'logger', 'console', 'default', '1.0'),
        logger,
        Descriptor('pip-services-attachments', 'persistence', 'memory',
            'default', '1.0'),
        persistence,
        Descriptor('pip-services-attachments', 'controller', 'default',
            'default', '1.0'),
        controller
      ]);
      controller.setReferences(references);

      client = AttachmentsDirectClientV1();
      client.setReferences(references);

      fixture = AttachmentsClientFixtureV1(client);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
      await Future.delayed(Duration(milliseconds: 2000));
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });
  });
}
