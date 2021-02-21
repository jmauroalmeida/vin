# VIN

A Ruby on Rails application to validate VIN codes.

Reference: [`https://en.wikipedia.org/wiki/Vehicle_identification_number`](https://en.wikipedia.org/wiki/Vehicle_identification_number)

_____________________
### Working Demo

A working demo of this application can be found at the URL:
 [` https://powerful-coast-18805.herokuapp.com/`]( https://powerful-coast-18805.herokuapp.com/)

_____________________
### About the provided script...

The Wikipedia page, section [`Check Digit Calculation`](https://en.wikipedia.org/wiki/Vehicle_identification_number#Check-digit_calculation) says:

_If the calculated value is 0–9, the check digit must match the calculated value.
 If the calculated value is 10, the check digit must be X._

The mentioned range `(0-9)` didn't seem in compliance with the variable `map` declared by the script.
Maybe it was some mistyping. Anyway, I fixed it to match the conditions presented at Wikipedia.

_____________________
### Setting up environment

  * Clone this project
  * Setup project `rake db:setup`
  * Start server `rails s`
  * Execute it locally on base url [`localhost:3000`](http://localhost:3000).

____________________________
## Project Structure

### Controllers
```sh
Name            Description
-------------------------------
Vins            Implements action 'index' to display VIN validity information
```

### Managers
```sh
Name            Description
-------------------------------
Vins            Implements logic that deals with all tasks related to VIN validation (including
                the initial script provided by the challenge PDF)
```

### Validation Engine - Steps
1. Verify whether there is/are any of the forbidden characters (I/O/Q)
 -- If so, display an error message
2. Calculate check digit (using provided script)

 -- If valid, returns a success message

 -- If invalid, display an error message explaining why

##### Valid VIN Message - Example:
```json
{
  "provided_vin": "1XPTD40X6JD456115",
  "check_digit": 6,
  "check_digit_valid": true,
  "message": "This looks like a VALID VIN!",
  "error": [],
  "suggested_vins": []
}
```

##### Invalid VIN Message - Examples:
```json
{
  "provided_vin": "INKDLUOX33R385016",
  "check_digit": null,
  "check_digit_valid": false,
  "message": "Contains invalid characters (I, O or Q)",
  "error": ["Incorrect character 'I' at position 1", "Incorrect character 'O' at position 7"],
  "suggested_vins": []
}
```

```json
{
  "provided_vin": "JBDCUB16657005393",
  "check_digit": 6,
  "check_digit_valid": false,
  "message": "This looks like an INVALID VIN!",
  "error": ["Check digit 6 is incorrect. Correct value is 8."],
  "suggested_vins": ["JBDCUB16857005393"]
}
```


## SHAME WALL

Although I really wanted to complete section `Bonus Activity`, I didn't fully understand what you guys expected me to
 do. I understood that you wanted me to suggest and display VINs based on its attributes by accessing `Global Assets 
 API`, but I failed to get a `cliend_id` and `secret` to request a token. I've read API docs lots of times trying to 
 generate one, tried to get resources online that my app could consume in order to display some attributes but nothing 
 really worked.

 Sorry. :(


