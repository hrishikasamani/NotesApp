## Secure Notes App

This project builds a secure notes application using a provided JSON API. Users can register, log in, manage their profile, create and view notes, and delete them.

**Features:**

- **Authentication:** Register new accounts and log in using email/password. (Logout functionality is simulated locally due to API limitations.)
- **Profile Management:** View profile details after logging in.
- **Notes Management:**
    - View a list of all created notes.
    - Create new notes with optional multiline input using `UITextView`.
    - Delete notes.
- **Persistence (Optional, Extra Credit):** Attempt to retain the logged-in state using `UserDefaults` for a better user experience.

**API Details:**

The application interacts with a JSON API (details provided in your assignment documentation).

**Getting Started:**

1. **Clone the Repository:**

   ```bash
   git clone [(https://github.com/hrishikasamani/NotesApp)]
   ```
   
2. **Install Dependencies: (If using CocoaPods):**

   ```bash
   pod install
   ```
   
   If not using CocoaPods, you'll need to manually integrate the Alamofire library for making network requests through *Package Dependencies*.
   
3. **Run the App:**
   
   Open the project in Xcode and run it on your simulator or device.


**Usage:**

1. Upon launch, the app will display the login screen.
   
2. **Register** if you're a new user:
   - Enter your name, email, and password.
   - Validation ensures a valid email format and prevents duplicate user creation (based on API limitations).

3. **Log in:**
   - Enter your registered email and password.
   - Validation checks for incorrect credentials or user non-existence.

4. Once logged in, you'll see your notes list.

5. **Create a New Note:**
   - Tap the "Add Note" button.
   - Enter your note content in the UITextView.
   - Tap "Save" to create the note.
   
7. **View Notes:**
   - Notes are displayed in a list.
   - Tap a note to view its details.

8. **Delete Note:**
   - On viewing note details, a delete button has the functionality to delete a note from the database.
   - Confirm deletion.

9. **UserDefaults**
   - The app attempts to retain your logged-in state using UserDefaults. If successful, you won't need to log in again on subsequent app launches.


*Incase of any issues, feel free to reach out to me at my [mail](hrishikasamani@gmail.com)*
