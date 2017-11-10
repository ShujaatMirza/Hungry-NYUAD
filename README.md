# Hungry-NYUAD
# Purpose and Goal of this Project

Students at NYUAD often pool together to make orders for delivery to Saadiyat on a Facebook page named Hungry@NYUAD. However the facebook has various drawbacks, including but not limited to:

* Students cannot configure their notifications based on their interests.
* Not all students are on facebook, or want to use facebook.
* Too much back and forth communication, especially for large groups.
* Restaurant menu items, prices, and minimum orders are not shown on the facebook page.

Our iOS app by the same name, Hungry@NYUAD, aims to eradicate the above problems faced by our beloved student body.

# User stories and Use Cases:

### As a student, I want to sign up using my email so I can access the service.

#### Acceptance Criteria
* Validate email address.
* Verify email address exists.
* Verify email address does not belong to another user.
* Validate password.
* Notify user on failed validation.
* Notify user via email on successful sign up.
* User can exit sign up process.
* No user data is saved unless all verification and validation succeeds.

#### Definition of Done
* Passes all testing related to acceptance criteria.

#### Use Case
	
_Primary Actors_: 
* Students
_Preconditions_: 
* Active internet connection.
_Basic Flow of events_:
* The student clicks the sign up button.
* The app responds by presenting a sign up screen with fields for name, email address, and password.
* The student enters their name, email address, and password, and clicks submit.
* The email address is validated.
* The password is validated.
* The user account is created.
* User is sent a confirmation email.

_Alternative flows_:
* Email address validation fails.
  * User is prompted to enter a correct email address.
* Password validation fails.
  * User is prompted to enter a password that meets requirements.
* Confirmation email cannot be delivered.
	* User is prompted to enter an existing email address. 

---------------------------

### As a member of an order group, I want to be able to contact other members in my group so that I can coordinate the pick up location of the order. 

#### Acceptance Criteria
* Only valid locations on campus premises can be selected. 
* Every member of the group has the fair ability to participate in setting up the location.
* Notification about the chosen pickup location is sent to all members including those who did not participate in the process

#### Definition of Done
* The option with most votes is set as the pick up location for the order.
* Passes testing as per acceptance criteria

#### Use Case

_Primary Actors_: 
* Order Owner
* Members of the ordering group

_Preconditions_: 
* A member should be part of the specified ordering group.

_Basic flow of events_: 
* Any member of the group clicks the default location (Welcome Center).
* The member proposes a different pick up location
* The new proposed pick up location along with the default location are added as options for a poll in the conversation.
* Other members of the group can add further options.
* Members of the ordering group select one, multiple or none of the multiple available options
* The poll for location is closed as the Order Owner finalizes the order for processing.
* The option with most votes is chosen as the pick up location for the order.
* The app includes the designated pick up location in the notification sent out when the order is placed.

_Alternative flows_:
* There is a tie between two or more locations.
* Order Owner selects one of the competing options. 
* Location is not validated.
* The app discards the option and prompts the user to enter again.

---------------------------

### As the person paying for the order upon delivery (that is, the order owner), I want to send notifications to everyone that hasn’t paid me back, so that everyone pays their fair share and  compensation is easy and efficient 

#### Acceptance Criteria
* See outstanding payments, if any
* Send push notification
* Receive notification by student with outstanding payment
* See outstanding amount and to whom in notification
* Validate that payment completed by both students

#### Definition of Done 
*  Passes all test as per acceptance criteria item
* Able to demo feature

#### Use Case 

_Primary Actors_: 
* Order owner 
* students who place orders with the order owner

_Preconditions_:  
* Part of specific ordering group
* Food has been delivered
* Outstanding payments exist 

_Basic flow of events_:
* Order has been delivered
* Order owner opens Hungry@NYUAD and looks at the details of their order
* The app will present the details of everyone in the order group, including whether they have paid what they have owed to the order owner
* If there are outstanding orders in the group, an option will appear called ‘notify’
* Upon clicking notify, a notification will be sent to users with outstanding payments. Notifications will give information on the amount owed, group, and order owner
* The owing student will then pay back the order in real cash and confirm that they paid through the app.
* A notification will then be sent to the order owner that the amount has been paid. 
* Upon confirming receipt the order details will be modified to show the new user state.				  





