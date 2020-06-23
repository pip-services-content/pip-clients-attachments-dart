# Examples for Attachments Microservice

This is a blob attachments microservice from Pip.Services library. It records all documents that attached to a particilar blob. When last document is disattached, the blob gets removed.

Define configuration parameters that match the configuration of the microservice's external API
```dart
// Service/Client configuration
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

In the help for each class there is a general example of its use. Also one of the quality sources
are the source code for the [**tests**](https://github.com/pip-services-content/pip-clients-attachments-dart/tree/master/test).
