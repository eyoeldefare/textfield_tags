## [2.0.1] - 6/22/2022
* Remove the space entered by default when pressing the submit button
## [2.0.0+1] - 5/1/2022
* Remove the space entered by default when pressing the submit button

## [2.0.0] - 3/26/2022
* Breaking changes to the overall application that removed static customization for the tags and textfields
* Added ability to use the `AutoComplete()` widget provided by the flutter API
* Users can now extend their own custom controller class to use their own implementations

## [1.4.4] - 3/14/2022
* Implemented a custom controller to manage the textfield and tags

## [1.4.3] - 3/7/2022
* Exposed the controller of the textfield for developers
* Updated the whole example to use newer version of flutter
* Added newer properties of Textfield widget such as readOnly, showHelper, keyboardType, controller
* Added letter case functionality

## [1.4.2] - 8/8/2021
* Fix the issue of tags obsecurity when using non final initial tags
* Change the onchange and onsubmit of textfields to reflect using Set instead of List to store tags

## [1.4.1] - 8/1/2021
* Added functionality that allows users to add custom tag seperators

## [1.4.0] - 7/18/2021
* Added prefix Icon inside the textfield
* Fixed the issue that returned null whenever users remove validator function
* Optimised for memory using smaller widgets when appropriate
* Add additional example and also fix the example gif that was not working

## [1.3.1] - 6/5/2021.
* Don't show validator warning once user deletes tag or enters tag

## [1.3.0] - 6/5/2021.
* Added validator to validate tags
* Added comma seperation

## [1.2.0+2] - 6/4/2021.
* More examples
* Improve sytax

## [1.2.0+1] - 6/2/2021.
* Fix comment errors
* Make textFieldBorder nullable for open borders

## [1.2.0] - 5/21/2021.
* Migrating to null safety
* Added tagsDistanceFromBorderEnd, scrollableTagsPadding and scrollableTagsMargin for more customization
* Spelling and formattings

## [1.1.2] - 5/20/2021.
* Fix issue #18
* Fix issue #22

## [1.1.1] - 3/6/2021.
* Update and change the InputDecorator widget properties of type InputBorder 
* Add hashtags to show infront of the values entered inside textfield
* Formatting 

## [1.1.0+1] - 12/5/2020.
* Update documentations
* Formatting 

## [1.1.0] - 12/5/2020.
* Major changes  in all files
* Breaking change on onTag and onDelete where they are required and shall not be null
* A feature of optional tags implemented to enable initial tags to be entered
* More examples and documentes showing usage

## [1.0.4] - 11/14/2020.
* Put the main and models file inside a source folder to optimise usability

## [1.0.3] - 10/25/2020.
* Make tags variable private so it doesn't conflict with developers variable and gets overrided

## [1.0.2] - 10/23/2020.
* Require the entry of tagsStyler and textFieldStyler

## [1.0.1] - 10/18/2020.
* Add onDelete callback capability
* Add capability to manipulate padding of tag text and cancel icon

## [1.0.0] - 10/15/2020.
* Fixed the First tag not showing when user enters a tag
* Fixed animation issue with tag offset dragging when it reaches the end
* Added more example demo

## [0.9.0] - 9/15/2020.
* Released first project.
