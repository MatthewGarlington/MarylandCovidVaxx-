# MarylandCovidVaxx-
This SwiftUI Application showcases stats for Covid 19 for the State of Maryland in the U.S. The data provided is from the Maryland State Government's Open Data source for Covid 19 found at https://opendata.maryland.gov. The information provided in this application is not for medical or clinical determination. 


This application showcases the latest data for Testing Amounts, Cases, Hospitalizations, Deaths, and Vaccine Distribution for Covid 19 in the State of Maryland.

![giphy](https://user-images.githubusercontent.com/61671107/110367766-1c750900-8016-11eb-8ff2-792614b569c0.gif)
![giphy](https://user-images.githubusercontent.com/61671107/110368156-a329e600-8016-11eb-9c82-dafe9a649323.gif)


The cards for each row display the data related to the title in that card as well as a list button in the top right of the card that can be tapped to present a list of historical data broken down by day since the data was collected. The list card that presents can be tapped by the user to enlarge the list or swiped to dismiss the list card all together. To close the list card the user can either swipe or tap outside of the card.

![giphy](https://user-images.githubusercontent.com/61671107/110370905-47f9f280-801a-11eb-92b5-701b221df51d.gif)

In the Second Tab view a Lottie animation was added in order to give time for the data to load as well as showcase the use of lottie animations as part of the UI

![giphy](https://user-images.githubusercontent.com/61671107/110371588-2fd6a300-801b-11eb-8057-d7d8a62de2b8.gif)

The Vaccine Phase at the bottom of the Vaccine Tab View can be tapped to reveal info for the current vaccine phase as well as all the information for all the vaccine phases for the state of Maryland. The View that is expanded on tap can be dismissed with a swipe gesture. 

![giphy](https://user-images.githubusercontent.com/61671107/110372333-2bf75080-801c-11eb-98e1-53d337223c1d.gif)


The Map pin Button in the upper right of the screen will take the user to a MapView showcasing All Vaccine or Testing Locations depending on which tab the user is in. These Map views are able to present information broken down into more specific categories (i.e Testing Locations that have rapid testing) selected in the tab bar for the mapview. The map will start on the region of Maryland when the toggle is not activated. If the toggle is activated, permission will be asked for the user's location in order to center the coordinates on the user's current location to see the nearest testing or vaccination site. 

For each map view, there is a list button in the right of the screen that can be tapped to present a list of all the locations on that specfic tab of the Map view with a navigation link to a detialed view holding more extensive details of that specific location. 

![giphy](https://user-images.githubusercontent.com/61671107/110374171-5813d100-801e-11eb-95cc-212401c42a1f.gif)
![giphy](https://user-images.githubusercontent.com/61671107/110374176-59dd9480-801e-11eb-95f7-f6c7ecad1e15.gif)



