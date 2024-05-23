# Flask-Flutter-Integration

This project integrates a Flutter app with a Flask web service, both running in Docker containers. The Flutter app runs locally, while the Flask service is hosted on Google Cloud.

## Workflow:
1. The Flutter app runs in Android Studio.
2. A user selects an image for classification within the app.
3. The image is sent to the Flask service, which performs the classification.
4. The classification result is sent back to the Flutter app.
5. The result is displayed in the Flutter app.

## Deployment
The trained model is deployed as part of the Flask service. When an image is received from the Flutter app, the Flask service processes the image and uses the model to predict whether the image is of a cat or a dog. The result is then sent back to the Flutter app.

## Running the Project
### Prerequisites
  i) Docker installed on your local machine.
 ii) Android Studio installed for running the Flutter app.
iii) A Google Cloud account for hosting the Flask service.

## Using the App

### Select an Image: 
Open the Flutter app and select an image from your device.

### Send Image for Classification:
The app will send the selected image to the Flask service.

### View the Result:
The classification result (cat or dog) will be displayed in the app.
