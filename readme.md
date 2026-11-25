# Personal Biodata and Account Portal

A ColdFusion web application for creating an account, logging in, and viewing personal biodata.

Built with:

- ColdFusion (CFML)
- SQL Server
- Bootstrap 4.6
- JavaScript
- jQuery

## What It Does

- Lets a person register for an account
- Checks for duplicate email addresses
- Saves personal information and selected hobbies
- Lets a person log in and log out
- Protects the biodata dashboard from unauthorised access
- Displays the person's profession, hobbies, and contact choices

## Main Pages

- `register.cfm` - Account and biodata form
- `register_action.cfm` - Processes registration
- `login.cfm` - Login form
- `login_action.cfm` - Checks login details
- `logout.cfm` - Logs out the user
- `landing.cfm` - Shows the user's biodata
- `Application.cfc` - Handles application settings and session protection

## Requirements

- ColdFusion server
- SQL Server
- A ColdFusion datasource named `CFTrainingDSN`
- A web browser

## Database Setup

Create a database named `CFTrainingDB`, then create the four tables below.

### profession

```sql
CREATE TABLE profession(
    profID INT IDENTITY(1,1) PRIMARY KEY,
    NAME VARCHAR(255)
);
```

### hobbies

```sql
CREATE TABLE hobbies(
    hobbyID INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255),
    location VARCHAR(255)
);
```

### biodata

```sql
CREATE TABLE biodata(
    userID INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    dob DATE,
    aboutme TEXT,
    profID INT,
    IC VARCHAR(12) NOT NULL,
    age INT,
    gender CHAR(1),
    contactMask INT NOT NULL DEFAULT(0),
    CONSTRAINT fk_prof FOREIGN KEY (profID)
        REFERENCES dbo.profession(profID)
);
```

### UserHobbies

```sql
CREATE TABLE UserHobbies(
    userID INT NOT NULL,
    hobbyID INT NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (userID)
        REFERENCES dbo.biodata(userID),
    CONSTRAINT fk_hobby FOREIGN KEY (hobbyID)
        REFERENCES dbo.hobbies(hobbyID),
    CONSTRAINT pk_userHobbies PRIMARY KEY (userID, hobbyID)
);
```

## Running the Project

1. Place the project in the web root of your ColdFusion server.
2. Create the database and tables above.
3. Open ColdFusion Administrator.
4. Add a datasource named `CFTrainingDSN`.
5. Set the datasource to use `CFTrainingDB`.
6. Start the ColdFusion server.
7. Open `register.cfm` in a browser.

## Registration Flow

1. The user opens `register.cfm`.
2. ColdFusion loads professions and hobbies from the database.
3. JavaScript calculates the age and gender from the form values.
4. The user submits the form to `register_action.cfm`.
5. ColdFusion checks the required fields and password confirmation.
6. ColdFusion checks whether the email is already registered.
7. The password is converted to a SHA-256 hash.
8. The selected contact choices are combined into one number.
9. The user and hobby records are saved in a database transaction.
10. The user is sent to the login page.

This project uses the Post/Redirect/Get pattern.

- It keeps form display separate from form processing.
- It prevents form data from being submitted again after refresh.
- It shows success and error messages only once.

## Login Flow

1. The user enters an email and password.
2. ColdFusion finds the matching email in the database.
3. The entered password is hashed with SHA-256.
4. The stored hash and entered hash are compared.
5. A successful login rotates the session ID.
6. ColdFusion stores the user ID and login status in `SESSION`.
7. The user is sent to `landing.cfm`.

On logout, the session is cleared and the user is sent back to the login page.

## Session Handling

ColdFusion stores login information on the server.

The browser receives a session cookie and sends it with later requests.

ColdFusion uses this cookie to find the matching session.

Each session starts with:

- `isLoggedIn = false`
- `userID = 0`
- `userName = ""`

Sessions expire after 30 minutes when there is no activity.

`landing.cfm` is protected by `onRequestStart()` in `Application.cfc`.

If a user is not logged in, the application sends them to `login.cfm`.

## Contact Preferences

Contact preferences are saved as bit flags in `contactMask`.

- `1` - Email
- `2` - SMS or WhatsApp
- `4` - Phone call
- `8` - Push notification

For example:

- Email and phone call use `1 + 4 = 5`
- The dashboard checks each flag to show the selected choices

## Security

- Database values use `<cfqueryparam>`
- Passwords are stored as SHA-256 hashes
- Password checks use case-sensitive `compare()`
- Sessions rotate after a successful login
- The dashboard is protected from unauthorised visitors
- Database values are escaped with `encodeForHTML()`
- Login and registration use flash messages stored in `SESSION`

### Optional Hobbies and Contact Choices

Checkboxes that are not selected are not submitted in `FORM`.

The action pages use `<cfparam>` to set empty values for these fields.

### IC and Gender

The registration form uses the 12-digit Malaysian IC number.

- The first six digits must match the date of birth
- The final digit is used to detect gender
- JavaScript updates the hidden gender field
- The server validates the required fields again


## Testing Checklist

- Register a new account
- Try to register with an existing email
- Try mismatched passwords
- Log in with valid details
- Log in with invalid details
- Log out
- Open `landing.cfm` while not logged in
- Try entering a DOB that does not match the IC
- Save an account with more than one hobby
- Save email and phone call preferences
- Confirm the contact mask is `5`
- Confirm the dashboard shows only the selected preferences
- Try entering `<script>` text in the About Me field
- Confirm the text appears as text, not as a running script
