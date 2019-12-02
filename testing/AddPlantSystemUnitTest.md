#### Planted!
#### Release 1.0 
#### **Team Name: Planted**
#### **Date Revised: December 2, 2019**

------

# Add Plant System Unit Test Report 
by Alyssa Melton
--------------------------------------------------------------------------------

Test 1: Add an image while using 'Add Plant' function.
  1) User: Navigate to “add plant” tab in bottom nav.
  2) System: Screen should show options to add plant image + add plant info.
  3) User: Select 'add plant image'
  4) System: Opens device camera
  5) User: takes photo + confirms
  6) System: Photo should be displayed above 'Add plant image' and 'add plant info' buttons.

Result 1: PASS

--------------------------------------------------------------------------------

Test 2: Change image after adding an initial one while using 'Add Plant' function.
  1) User: Complete actions from Test 1
  3) User: Select 'add plant image' again
  4) System: Opens device camera
  5) User: takes photo + confirms
  6) System: Photo should be updated above 'Add plant image' and 'add plant info' buttons.

  Result 2: PASS

--------------------------------------------------------------------------------

  Test 3: Add plant info while using 'Add Plant' function. All fields empty show error message.
  1) User: Navigate to “add plant” tab in bottom nav.
  2) System: Screen should show options to add plant image + add plant info.
  3) User: Select 'add plant info'
  4) System: A pop up window should appear that shows options to enter Name, Genus, and light requirement.
  5) User: Select 'Submit' without entering any data
  6) System: Red messages asking user to enter Name Genus and Light Requirement should appear
     below the entry boxes.

  Result 3: FAIL
  - error messages appear briefly, but the box disappears so they can't be read.

--------------------------------------------------------------------------------

Test 4: Submit plant with info and no image within 'Add Plant' function.
1) User: Navigate to “add plant” tab in bottom nav.
2) System: Screen should show options to add plant image + add plant info.
3) User: Select 'add plant info'
4) System: A pop up window should appear that shows options to enter Name, Genus, and light requirement.
5) User: Enter all fields and select 'Submit'
6) System: Messages asking user to select an image should appear.

Result 4: Pass

--------------------------------------------------------------------------------

Test 5: Submit plant with info and image within 'Add Plant' function and route
user to 'My Plants' page.
1) User: Add plant image as in Test 1.
2) System: Screen should show options to add plant image + add plant info.
3) User: Select 'add plant info'
4) System: A pop up window should appear that shows options to enter Name, Genus, and light requirement.
5) User: Enter all fields and select 'Submit'
6) System: Route user to 'My Plants' page.

Result 5: FAIL
- Window closes, user is not routed to 'My Plants' page

--------------------------------------------------------------------------------

Test 5: Submit plant with info and image within 'Add Plant' function and add plant
to database.
1) User: Add plant image as in Test 1.
2) System: Screen should show options to add plant image + add plant info.
3) User: Select 'add plant info'
4) System: A pop up window should appear that shows options to enter Name, Genus, and light requirement.
5) User: Enter all fields and select 'Submit'
6) System: Plant is pushed to database.

Result 5: PASS

--------------------------------------------------------------------------------

Test 6: Submit plant with image and info excluding plant name within 'Add Plant' function.
1) User: Add plant image is in Test 1.
2) User: Navigate to “add plant” tab in bottom nav.
3) System: Screen should show options to add plant image + add plant info.
4) User: Select 'add plant info'
5) System: A pop up window should appear that shows options to enter Name, Genus, and light requirement.
6) User: Enter all fields except plant name and select 'Submit'
7) System: Messages asking user to enter a 'plant name' should appear.

Result 6: Pass

--------------------------------------------------------------------------------

Test 7: Submit plant with image and info excluding plant genus within 'Add Plant' function.
1) User: Add plant image is in Test 1.
2) User: Navigate to “add plant” tab in bottom nav.
3) System: Screen should show options to add plant image + add plant info.
4) User: Select 'add plant info'
5) System: A pop up window should appear that shows options to enter Name, Genus, and light requirement.
6) User: Enter all fields except genus and select 'Submit'
7) System: Messages asking user to enter a 'genus' should appear.

Result 7: Pass

--------------------------------------------------------------------------------

Test 8: Submit plant with image and info excluding plant light requirement within 'Add Plant' function.
1) User: Add plant image is in Test 1.
2) User: Navigate to “add plant” tab in bottom nav.
3) System: Screen should show options to add plant image + add plant info.
4) User: Select 'add plant info'
5) System: A pop up window should appear that shows options to enter Name, Genus, and light requirement.
6) User: Enter all fields except light requirement and select 'Submit'
7) System: Messages asking user to enter a 'light requirement' should appear.

Result 8: Pass
