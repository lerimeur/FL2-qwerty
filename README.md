# fl2_qwerty_messenger

## Getting Started

This project is the starting point of a messenger app.
With this project you can create an account a discuss with your friends.

## For developers
In order to use the app you can clone the repository execute in your terminal

`flutter run`

if you want to use the server-side localy: `https://github.com/Axoloot/Messengr_backend`

### Architecture

The project  architecture is based on a simple Provider with all of the Api call and data we will need in the app process. 

Next to that the application stucture is only a BottomBar with few screen around in order to match all of the prerequisites.

You will have a ConvList screen in order to render all of your actual conversation and an another one to render the conversation.

You will have a Profile screen in order to change the darkmode or your profile picture / firstname lastname.

Moreover you will have a ConvCreation screen in order to as expected create a conversation.


## External librairies
we use few libraries

animated_splash_screen: as the name of the package we use that package in order to have a simple animation on the splash screen we are using that because we didnt have any designer in our team so we found diferents solution.

dio: Dio this famous package was not our first package because at the beguining we were using http request (native flutter) but we include that one in order to fix somme issue we have Web side.

email_validator: we are using that package to avoid the classic REGEX email issue.

image_picker: we are using this package to simply interact with the phone camera.


## Links

[front web](https://messengr.fundy.cf/)

[backend swagger docs](https://messengerdocs.fundy.cf/)

[grafana](https://grafana.fundy.cf/)
  -> admin:admin
  -> board flutter

[api url](https://flutr.fundy.cf/)
