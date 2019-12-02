#### Planted!
#### Release 1.0 
#### **Team Name: Planted**
#### **Date Revised: November 29, 2019**

------

# Planted! 1.0

It can be difficult for beginner plant owners to learn about the characteristics of their plants and take the necessary steps to properly care for them. Planted! is an application that provides users with proper plant care information and suggestions for a wide array of plants. It also serves as a reminder app to ensure that users provide the appropriate amount of water, fertilizer, and sunlight for their plants.

## Table of contents
* [General info](#general-info)
* [Features and Functionality](#features-and-functionality)
* [Technologies](#technologies)

## General info
Keeping up with your plants' requirements is now at your fingertips! Save plant data, set reminders, and never miss a watering again!

## Features and Functionality
The first release includes functionality for the following user stories: 

#### As a basic user, I want to be able to create a profile, so I can have my data saved.
- Upon launch, the user can create a profile.
- Enter a valid email
- Enter a password.
- Select 'Sign Up'

#### As a basic user, I want to be able to log into my profile, so I can have my data saved.
- Upon launch, the user can sign in to an existing profile.
- Enter a valid email previously signed up with
- Enter the corresponding password
- Select 'Login'

#### As a basic user, I want to be able to add a plant to my profile, so I can keep track of how many / what I have.
- Upon signing in, the user can select 'Add Plant' and follow the prompts to add a plant.
- Select the middle navigation button 'Add Plant'
- Select 'Add Plant Image'
- Take a photo' 
- Confirm photo
- Select 'Add Plant Info'
- Enter Plant Info
- Select 'Submit'

#### As a basic user, I want to be able to see plants on my profile, so I can keep track of how many / what I have.
- Upon signing in, the user can select 'My Plants' to see a list view of their plants.
- Select the right navigation button 'My Plants'
- If plants have been added, plants will appear here. 
- If plants have not been added, the list is empty.

#### As a basic user, I want to be able to keep track of the care information for my plants, so I can care for them correctly.
- Upon adding a plant, the user can enter the plant's light requirement.
- Upon viewing 'My Plants' list, the user can see the light requirement previously entered when creating a plant. 
- The user can set up reminders so the user can water or fertilize their plant.
- Select the right navigation button 'My Plants'
- Select an existing plant
- Select the '+' on the top right corner to add a notification
- Input the data
- Select Submit

#### As a basic user, I want to be able to be reminded to water so that I don’t underwater
- The user can set up reminders so the user can water or fertilize their plant.
- Select the right navigation button 'My Plants'
- Select an existing plant
- Select the '+' on the top right corner to add a notification
- Input the data
- Select Submit


## Known Problems
The current known problems of the software that have been identified. We describe the expectation and beneath is the cause of the error, the location of the fault, and possible actions to remove the fault.

#### After submitting a plant with an image, the image should disappear
- Input/action: When the user inputs an image for the new plant to store into their profile, the image doesn’t disappear from view after submitting the plant into the profile.
- Location of fault: This bug may be located in the AddPlant.dart file.
- Possible action for removal of fault: When the user selects ‘Submit’ on the form to add a plant, 
implement a function to remove the display of the previously submitted photo.

#### No form validation for add reminder form - able to submit an empty form
- Input/action: If the user were to add a reminder to a plant they’ve previously stored, they could possibly submit an empty form. This empty reminder isn’t stored into the user’s profile so there won’t be an empty reminder showing on the ‘View and add reminders’ and ‘Reminders’ page. But the user shouldn’t be able to submit an empty form.
- Location of fault: This bug may be located in the addReminders.dart file.
- Possible action for removal of fault: We could possibly implement a separate validator function to fix this bug.


	
## Technologies
Project is created with:
* Android Studio
* Flutter Software Development Kit
