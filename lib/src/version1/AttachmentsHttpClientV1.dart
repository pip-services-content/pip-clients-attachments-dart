import 'dart:async';
import 'dart:convert';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_attachments/pip_services_attachments.dart';
import './IAttachmentsClientV1.dart';

class AttachmentsHttpClientV1 extends CommandableHttpClient
    implements IAttachmentsClientV1 {
  AttachmentsHttpClientV1([config]) : super('v1/attachments') {
    if (config != null) {
      configure(ConfigParams.fromValue(config));
    }
  }

  /// Gets an attachment by its unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [attachmentId]                an id of attachment to be retrieved.
  /// Return         Future that receives attachment or error.
  @override
  Future<BlobAttachmentV1> getAttachmentById(
      String correlationId, String attachmentId) async {
    var result = await callCommand(
        'get_attachment_by_id', correlationId, {'id': attachmentId});
    if (result == null) return null;
    var item = BlobAttachmentV1();
    item.fromJson(json.decode(result));
    return item;
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
    var result = await callCommand(
        'add_attachments', correlationId, {'reference': reference, 'ids': ids});
    if (result == null) return null;
    var items = List<BlobAttachmentV1>.from(json
        .decode(result)
        .map((itemsJson) => BlobAttachmentV1.fromJson(itemsJson)));
    return items;
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
    var result = await callCommand('update_attachments', correlationId,
        {'reference': reference, 'old_ids': oldIds, 'new_ids': newIds});
    if (result == null) return null;
    var items = List<BlobAttachmentV1>.from(json
        .decode(result)
        .map((itemsJson) => BlobAttachmentV1.fromJson(itemsJson)));
    return items;
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
    var result = await callCommand('remove_attachments', correlationId,
        {'reference': reference, 'ids': ids});
    if (result == null) return null;
    var items = List<BlobAttachmentV1>.from(json
        .decode(result)
        .map((itemsJson) => BlobAttachmentV1.fromJson(itemsJson)));
    return items;
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
    var result = await callCommand(
        'delete_attachment_by_id', correlationId, {'id': attachmentId});
    if (result == null) return null;
    var item = BlobAttachmentV1();
    item.fromJson(json.decode(result));
    return item;
  }
}
