##Changelog 

#### Introduction 

There has been a major push to complete the project on time. As such, the cadence of the contributions to the repository have been very rapid. Most of the basic functionality had already been established, therefore the releases of the past few days have focussed on refining the workflows we have established as paramount (user management, creating and managing order groups, creating and managing orders, and adding content to the restaurants and their menus).

With that said, what follows is the changes that have occurred since the last graded major release.

#### User Management 

* Modified the registration process so that if users do not complete the process, their data is not stored in the database

#### Order Management

##### My Orders

* Created a My Orders view controller where the user can see the orders that they made or are a part of. 
* Within this view controller, buttons appears that changes state depending on the setting: If the user is the owner, it will give the options to place an order and confirm that it was delivered and completed. If the user is not the owner, it will not display the option to place an order, and instead just show the general information along with the option to view group members
* Viewing all the members shows the cost breakdown across members along with the total cost of all the orders within the group
* This VC also shows the status of the order

##### List Of Order Groups 

* The name and restaurant are displayed in the order group list.
* Once a user clicks the order order group, the detail view shows the status of the delivery along with the option to join the group. 
* Clicking "Join Group" kicks off the workflow to place an order. Upon completion, this order is appended to the group and the user is placed as a member
* Only valid groups appear in the list. If the user is a part of a group, it will not show up as a part of the list, neither will groups with placed orders

##### General 

* Styling unified across the app
* Ordering workflow integrated with joining a group
* Displayed more information on the order detail view
* Restaurant is selected, not typed, when creating new order group. Placing an order from menu comes before naming the order group

