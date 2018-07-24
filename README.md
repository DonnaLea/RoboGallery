# Robo Gallery
Technical project for Jyve.

## About the code

- Written in Swift 4.1 with Xcode 9.4.1 as this is the current stable release for Xcode and Swift.
- UI code is written with Autolayout programmatically (not using Storyboards). This allows for easier reviewing of UI code and better handling in git and comparison of UI changes with code reviews. I find using autolayout anchors very descriptive of what is happening to the layout.
- CocoaPods was used for adding 3rd party libraries. This makes it very easy to add/remove/update libraries as needed.
- AlamofireImage is used for fetching the image from the robohash.org api. Alamofire is a highly regarded 3rd party library for networking and having AlamofireImage library made it very simple to request an image. 
- Realm was used for persisting the data between launches. This choice was mostly based on there being "bonus points" for doing so :)
- UISearchBar used for entering text to request a robot. This had a lot of preferred UI built in such as a search button for the keyboard by default, cancel button in the search bar, search icon in the search bar.
- Stored image data instead of re-requesting the image based on the stored text. This was done mostly due to lack of experience with Realm. Ideally the images would be re-reqested and not stored themselves, however, due to the images being of a reasonably small size this was easier to use Realm to do this.
- UISegmentedControl in the UIToolbar of the view controller was a geat easy way of having the user select a set. It limits the user to only one selection which is perfect for this use case. 
- Used UINavigationItem and UIToolbar to display necessary extra UI elements (search bar and segmented control). This allowed me to still used a UICollectionViewController subclass without having to mess around with laying out the collection view and other elements on the view. 

## Improvements

If I had all the time in the world, this is what I'd improve:

- Error handling. Currently there is limited information given to the user if an error occurs. An improvement would be displaying an error image for the robot image if there was an error fetching it. Other more serious errors might involve popups.
- I would love to use a custom transition to the RobotViewController from the collection view cell. This is not something I have had the opportunity to do before, but a quick look at how to do it was a bit more involved for the limited time I chose to complete the project.
- I would like to request and display a larger image of the robot to be displayed in the RobotViewController for a better quality viewing of the robot.
- I would like to hide other UI elements (navigation bar and label) on the RobotViewController if the user taps the image/screen (aka Photos app).
- Allow deleting a specific robot. This was mentioned as a bonus point and I did not have enough time to address this. This is an obvious benefit to the user experience.
- Currently my lack of Realm experience means that I followed the My First Realm app tutorial in the Realm docs which only covered having a user being an admin. Switching to admin = false allowed for separate apps to have separate lists, but as a new realm user it was unclear if this was stored in the cloud or just locally and since I had limited experience I just stuck with what the tutorial covered :D Clearly though, separate users should have a separate list!
