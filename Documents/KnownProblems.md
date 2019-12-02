# Known Problems Report
**Planted!**

**Team Name: Planted**

**Date Revised: November 29, 2019**
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

