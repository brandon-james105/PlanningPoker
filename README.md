# Planning Poker

Agile Planning Poker is a method for groups to estimate the effort required to complete work to be done for a project. It can also be used to rate the “business value” (how much value this work will be to the customer). These numbers are then used to prioritize the work so that the items with the least effort but the most business value will be tackled first.


Analog Planning Poker runs as follows:


## Materials

Planning Poker Cards (0, ½, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, coffee mug, and question mark), calculator


Procedure

1.	Each voter is given a set of Planning Poker cards
2.	The facilitator reads out a potential feature for the project
3.	Each voter chooses a card that best represents how much effort the feature would be to work, but does not show the other voters right away
4.	The facilitator waits for everyone to choose their card and then tells the voters to show their votes.
5.	The facilitator or some other assistant calculates the mean (average) of all the voters’ cards. This number becomes the “story points” or estimated effort/business value to for the feature.
Repeat steps 2-5 until all potential features are completed.

## Dependency Management

The project uses Carthage to manage dependencies. In order to download the dependencies for the project you must have the Carthage command line tool installed using Brew or Ports.

### Download the Dependencies with Carthage

Run `carthage update --platform ios --no-use-binaries` in the terminal to download all the dependencies for the project. To download a single dependency run `carthage update <dependency_name> --platform ios --no-use-binaries` in the terminal.

Project Timeline:

* Gather Resources for:
* ~~Creating custom views~~ ([Tutorial](http://randexdev.com/2014/08/uicollectionviewcell/))
* ~~Making transitions w/ parameters~~ 
* ~~Binding~~ ([SwiftBond](https://github.com/SwiftBond/Bond))
* ~~Multipeer connectivity~~ ([Adapted this Tutorial](https://www.ralfebert.de/tutorials/ios-swift-multipeer-connectivity/))
* Different UI for iPhone and iPad
* ~~Architect Project in MVVM w/ DI~~ ([MVVM Tutorial](https://github.com/Swinject/SwinjectMVVMExample))
* Multipeer connectivity
* Create a client service for Voters w/ multipeer library
* Create a host service for Facilitators w/ multipeer library
* Create custom UI
* Cells
* Cards
* Buttons with description
* Create views as defined in the project's PDF
* Implementations for cards
* Complexity
* Business Value
