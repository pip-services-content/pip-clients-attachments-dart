import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';

import 'package:pip_services_attachments/pip_services_attachments.dart';
import './IAttachmentsClientV1.dart';

class AttachmentsDirectClientV1 extends DirectClient<dynamic>
    implements IAttachmentsClientV1 {
  AttachmentsDirectClientV1() : super() {
    dependencyResolver.put('controller',
        Descriptor('pip-services-attachments', 'controller', '*', '*', '1.0'));
  }

  /// Gets an attachment by its unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [attachmentId]                an id of attachment to be retrieved.
  /// Return         Future that receives attachment or error.
  @override
  Future<BlobAttachmentV1> getAttachmentById(
      String correlationId, String attachmentId) async {
    var timing = instrument(correlationId, 'attachments.get_attachment_by_id');
    var attachment =
        await controller.getAttachmentById(correlationId, attachmentId);
    timing.endTiming();
    return attachment;
  }

  /// Adds reference to attachments by ids and return list of these attachments.
  ///
  /// - [correlationId]    (optional) transaction id to trace execution through call chain.
  /// - [reference]              a reference to be added.
  /// - [ids]              an attachments ids to be added to.
  /// Return         (optional) Future that receives list of attachment or error.
  @override
  Future<List<BlobAttachmentV1>> addAttachments(
      String correlationId, ReferenceV1 reference, List<String> ids) async {
    var timing = instrument(correlationId, 'attachments.add_attachments');
    var attachments =
        await controller.addAttachments(correlationId, reference, ids);
    timing.endTiming();
    return attachments;
  }

  /// Updates reference in all attachments by their ids.
  ///
  /// - [correlationId]    (optional) transaction id to trace execution through call chain.
  /// - [reference]              a reference to be added.
  /// - [oldIds]              an old attachments ids to be updated.
  /// - [newIds]              an new attachments ids to be updated.
  /// Return         (optional) Future that receives list of attachment or error.
  @override
  Future<List<BlobAttachmentV1>> updateAttachments(String correlationId,
      ReferenceV1 reference, List<String> oldIds, List<String> newIds) async {
    var timing = instrument(correlationId, 'attachments.update_attachments');
    var attachments = await controller.updateAttachments(
        correlationId, reference, oldIds, newIds);
    timing.endTiming();
    return attachments;
  }

  /// Removes reference in attachments by their ids and return list of these attachments.
  ///
  /// - [correlationId]    (optional) transaction id to trace execution through call chain.
  /// - [reference]              a reference to be removed.
  /// - [ids]              an attachments ids to be removed to.
  /// Return         (optional) Future that receives list of attachment or error.
  @override
  Future<List<BlobAttachmentV1>> removeAttachments(
      String correlationId, ReferenceV1 reference, List<String> ids) async {
    var timing = instrument(correlationId, 'attachments.remove_attachments');
    var attachments =
        await controller.removeAttachments(correlationId, reference, ids);
    timing.endTiming();
    return attachments;
  }

  /// Deletes an attachment by it's unique id.
  ///
  /// - [correlationId]    (optional) transaction id to trace execution through call chain.
  /// - [attachmentId]                an id of the attachment to be deleted
  /// Return                Future that receives deleted attachment
  /// Throws error.
  @override
  Future<BlobAttachmentV1> deleteAttachmentById(
      String correlationId, String attachmentId) async {
    var timing =
        instrument(correlationId, 'attachments.delete_attachment_by_id');
    var attachment =
        await controller.deleteAttachmentById(correlationId, attachmentId);
    timing.endTiming();
    return attachment;
  }
}
