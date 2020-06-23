# <img src="https://github.com/pip-services/pip-services/raw/master/design/Logo.png" alt="Pip.Services Logo" style="max-width:30%"> <br/> Attachments Microservice Client SDK for Dart

This is a Dart client SDK for [pip-services-attachments](https://github.com/pip-services-content/pip-services-attachments-dart) microservice.

## Download

Right now the only way to get the microservice is to check it out directly from github repository
```bash
git clone git@github.com:pip-services-content/pip-clients-attachments-dart.git
```

Pip.Service team is working to implement packaging and make stable releases available for your 
as zip downloadable archieves.

## Contract

Logical contract of the microservice is presented below. For physical implementation (HTTP/REST),
please, refer to documentation of the specific protocol.

```dart
class ReferenceV1 {
  String id;
  String type;
  String name;
}

class BlobAttachmentV1 implements IStringIdentifiable {
  String id;
  List<ReferenceV1> references;
}

abstract class IAttachmentsV1 {
  Future<BlobAttachmentV1> getAttachmentById(
      String correlationId, String attachmentId);
  
  Future<List<BlobAttachmentV1>> addAttachments(
      String correlationId, ReferenceV1 reference, List<String> ids);

  Future<List<BlobAttachmentV1>> updateAttachments(String correlationId,
      ReferenceV1 reference, List<String> oldIds, List<String> newIds);

  Future<List<BlobAttachmentV1>> removeAttachments(
      String correlationId, ReferenceV1 reference, List<String> ids);

  Future<BlobAttachmentV1> deleteAttachmentById(
      String correlationId, String attachmentId);
}
```

## Use

The easiest way to work with the microservice is to use client SDK. 

Define client configuration parameters that match the configuration of the microservice's external API
```dart
// Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = AttachmentsHttpClientV1(config);

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
```

Now the client is ready to perform operations
```dart
    // Create the attachment
    try {
      var attachments = await client.addAttachments('123', ReferenceV1(
              id: '000000000000000000000011', type: 'goal', name: 'Goal 1'),
              ['1', '2']);
      // Do something with the returned attachments...
    } catch(err) {
      // Error handling...     
    }
```

```dart
// Authenticated
try {
var attachment =
          await controller.getAttachmentById('123', '1');
    // Do something with attachment...

    } catch(err) { // Error handling}
```

## Acknowledgements

This microservice was created and currently maintained by
- **Sergey Seroukhov**
- **Nuzhnykh Egor**.
