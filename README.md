# chatapp_with_firebase

A chat app with Firebase tutorial for the J4J - Flutter group.

## Getting Started

Create a new flutter project with only the following platforms: `android`, `iOS`, and `Web` with the command:

```bash
flutter create --platforms=android,ios,web chatapp_with_firebase
```

## Steps in short

1. Create the login page ui with no functionality
2. Create the sign-up page ui with no functionality
3. Create the chat page ui
   1. Format the date and time using the `intl` package
   2. Create a `ChatMessageBubble`
4. Add validation to the login and signup forms
   1. Add validation to the login form
   2. Add validation to the signup form
5. Firebase dependencies and setup
6. Set up `firebase_auth` in `main.dart`
7. Set up `cloud_firestore` in the project

## Steps with description

### 1. Create the `LoginPage` ui

1. Delete the code of the `MyHomePage` widget in the `main.dart` file.
2. In the `lib` directory, create a new directory called `pages`; inside it, create a new file called `login_page.dart`.
3. In the `login_page.dart` file creates a stateful widget called `LoginPage`.
4. Set the `LoginPage` widget as the home of the `MaterialApp` widget in the `main.dart` file.
5. Run in the emulator or physical device to see the result.
6. Create the user interface as you like:
![Login page UI](/assets/screenshots/login_page_ui.png)

### Create the sign-up page ui with no functionality

1. Create a new file called `signup_page.dart` in the `pages` directory.
2. Temporarily set the `SignupPage` widget as the home of the `MaterialApp` widget in the `main.dart` file.
3. To save time, we can copy the content of the `login_page.dart` file to the `signup_page.dart` file and add things.
*Change the class name to SignupPage (use F2)*
4. Add confirm your password field to the form
5. Add `Divider` and an option to navigate to the login page
    hint: You can use `InkWell` to change control every pixel of the pressable area
6. Example:
    ![Signup page UI](/assets/screenshots/signup_page_ui.png)
7. Update the login page to include the option to navigate to the signup page like this:

    ![Login page UI step 2](/assets/screenshots/login_page_ui_step2.png)

8. Add the functionality to navigate between the login and signup pages. Here is an example for the `LoginPage`:

   ```dart
   onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
   ```

9. How do you pop the page from the navigation stack if you're using the `push` method?

### Create the chat page ui

1. Create a new file called `chat_page.dart` in the `pages` directory.
2. Create a stateful widget called `ChatPage` in the `chat_page.dart` file.
3. Temporarily set the `ChatPage` widget as the home of the `MaterialApp` widget in the `main.dart` file.
4. Create a class called `ChatMessageModel` in the `chat_page.dart` file (We will refactor it later), with the properties:
    - message
    - sender
    - time
5. Create a list of `ChatMessageModel` called `messages` and add some dummy data.

   ```dart
    final List<ChatMessageModel> messages = [
        ChatMessageModel(
        message: "Hello world",
        sender: "me",
        time: DateTime.now(),
        ),
        ChatMessageModel(
        message: "Hello J4J group",
        sender: "Bob",
        time: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        ChatMessageModel(
        message: "Hello Bob",
        sender: "Alice",
        time: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
    ];
   ```

6. Sort the dummy data by time. *Use the `sort` method*
7. Create the body with a `Column` widget. The column will contain the `ListView` with the messages and the `TextField` for the user to type the message.
8. Create a `ListView.builder` to display the messages and show each message in a `ListTile` widget.
9. Create a `Divider` widget to separate the `ListView` from the `TextField`'s row.
10. Create a `Row` widget to contain the `TextField` and the `TextButton.icon` to send the message. *Note: you will need to use the `Expanded` widget somewhere*

![Chat page UI](/assets/screenshots/step3_chat_ui.png)

#### Format the date and time using the `intl` package

1. Meet Flutter's date and time formatting library, [`intl`](https://pub.dev/packages/intl).
2. Add the `intl` package to the `pubspec.yaml` file by copying the following line to the `dependencies` section, then save (`ctrl+ s`):

   ```yaml
   intl: ^0.18.1
   ```

3. Or, run this command in the terminal:

    ```bash
    flutter pub add intl
    ```

4. In the `chat_page.dart` file, import the `intl` package:

   ```dart
   import 'package:intl/intl.dart';
   ```

5. Create a `DateFormat` object to format the date and time:

   ```dart
   final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
   final DateFormat timeFormat = DateFormat("HH:mm");
   ```

6. Use the `dateFormat` and `timeFormat` objects to format the date and time in the `ListTile` widget:

```diff
return ListTile(
    title: Text(message.message),
    subtitle: Text(message.sender),
    trailing: Text(
-   message.time.toString(),
+   "${dateFormat.format(message.time)} ${timeFormat.format(message.time)}"),
);
```

![Chat page UI after intl](/assets/screenshots/step3.1_chat_ui.png)

#### Create a `ChatMessageBubble`

1. Under the `lib` directory, create a new directory called `components`.
2. In the `components` directory, create a new file called `chat_message_bubble.dart`.
3. Create a stateless widget called `ChatMessageBubble` in the `chat_message_bubble.dart` file. The widget will take a `ChatMessageModel` object as a parameter.
  
   ```dart
    class ChatMessageBubble extends StatelessWidget {
    final ChatMessageModel message;
    const ChatMessageBubble(
        this.message, {
        super.key,
    });

    @override
    Widget build(BuildContext context) {
    
    ```

4. Build the UI of the `ChatMessageBubble` widget as you like.
5. Change the `ListTile` widget in the `ChatPage` widget to use the `ChatMessageBubble` widget.

    ```diff
    -  return ListTile(
    -                  title: Text(message.message),
    -                 subtitle: Text(message.sender),
    -                  trailing: Text(
    -                    "${dateFormat.format(message.time)} ${timeFormat.format(message.time)}",
    -                  ),
    -                );
    +  return ChatMessageBubble(message);
    ```

6. Create something like this:

    ![Chat page UI with bubbles](/assets/screenshots/step3.2_chat_ui.png)

### Add validation to the login and signup forms

#### Add validation to the login form

1. What is the validation for the `email` field?
2. What is the validation for the `password` field?
3. Check if the form is valid before submitting it.
4. Add `TextEditingController` to the `email` and `password` fields to get their values and use them in the submission.

#### Add validation to the signup form

1. Email field - !!Reuse the same validator!!
2. Password field - !!Reuse the same validator!!
3. Password confirmation field - how to validate it?
4. Add `TextEditingController` to the `email` and `password` fields to get their values and use them in the submission. *Maybe you will need to add them before validating the confirmation field*

## To the Good Stuff 👍

### Firebase dependencies and setup

All of the docs for Firebase are available [here](https://firebase.google.com/docs/build).

In the past we had to do the setup manually, but now we can use the `Firebase CLI` to do it for us. To use it, we need to [install](https://firebase.google.com/docs/cli) it first via the terminal:

```bash
npm install -g firebase-tools
```

After installing the `Firebase CLI`, we need to log in to our Google account:

```bash
firebase login
```

#### Adding the dependencies

1. Add the `firebase_core` package to the `pubspec.yaml` file:

   ```bash
    flutter pub add firebase_core
   ```

2. We want our app to use the Firebase Authentication service, so we need to add the `firebase_auth` package to the `pubspec.yaml` file:

   ```bash
   flutter pub add firebase_auth
   ```

3. We want our app to use the Firebase Cloud Firestore service as our database, so we need to add the `cloud_firestore` package to the `pubspec.yaml` file:

   ```bash
   flutter pub add cloud_firestore
   ```

    Or maybe add them all at once:

    ```bash
    flutter pub add firebase_core firebase_auth cloud_firestore
    ```

#### Configure the Firebase project

1. You can create manually a new Firebase project from the [Firebase console](https://console.firebase.google.com/), Or you can use the `Firebase CLI` to create a new project:

   ```bash
   firebase projects:create
   ```

2. After creating the Firebase project, we need to add the Flutter project to it. To do that, we need to run the following commands in the terminal:
    1. Enable the `flutterfire_cli` dart plugin:

        ```bash
        flutter pub global activate flutterfire_cli        
        ```

    2. Run the `flutterfire_cli` tool to register our apps. Follow the instructions:

        ```bash
        flutterfire configure
        ```

    3. After registering the apps, we need to configure them in our `main.dart` file:

        ```dart
        import 'package:firebase_core/firebase_core.dart';
        import 'firebase_options.dart';
        // ... other imports

        Future<void> main() async {
            WidgetsFlutterBinding.ensureInitialized();
            await Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
            );
            runApp(const MyApp());
        }
        ```

        ***Note: We need to finish the setup of the Firebase project in the Firebase console.***

    4. Back at the [Firebase console](https://console.firebase.google.com/), we need to enable the `Authentication` and `Cloud Firestore` services.
       1. In the `Authentication` service, enable the `Email/Password` sign-in method and `Anonymous` sign-in methods.
       2. In the `Cloud Firestore` service, create a new database in `test mode`. Select the `Cloud Firestore location` of the database and click  `Enable`. *Suggestion: `eur3`*

    5. Security alert: For best practices, you must add the following files to the `.gitignore` file:

        ```bash
        google-services.json
        GoogleService-Info.plist
        firebase_options.dart
        firebase_app_id_file.json
        ```

        Those files contain sensitive information about your Firebase project. You can create them again by running the `flutterfire configure` command.
    6. Now, the setup is done! 🎉

### Set up `firebase_auth` in `main.dart`

Based on the `firebase_auth` state we want to control the navigation between the `LoginPage` and the `ChatPage` widgets.

1. We will listen to changes in the `firebase_auth` state using the `authStateChanges` [stream](https://dart.dev/tutorials/language/streams).

    ```diff
     @override
     Widget build(BuildContext context) {
    - return MaterialApp(
    -   title: 'J4J Chat App',
    -   theme: ThemeData(
    -     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    -     useMaterial3: true,
    -   ),
    -   home: const LoginPage(),
    +    return StreamBuilder<User?>(
    +    stream: FirebaseAuth.instance.userChanges(),
    +    builder: (_, snapshot) {
    +       return MaterialApp(
    +        title: 'J4J Chat App',
    +        theme: ThemeData(
    +            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    +            useMaterial3: true,
    +        ),
    +        home: snapshot.data == null ? const LoginPage() : const ChatPage(),
    +       );
    +       },

    ```

    You can add a print statement to see the changes in the `authStateChanges` stream.

    *Note: in the coming steps, each function should be wrapped with a try-catch clause to handle edge cases*

    *Consider using a `SnackBar` to show error messages*

2. `SignUpPage`: add the functionality to sign up a new user using the `firebase_auth` package.
   1. Check if the form state is valid
   2. Create a new user using the `createUserWithEmailAndPassword` method like:

        ```dart
        FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
                );
        ```

        *Note: Hover on the methods to see edge-cases*
   3. Pop the `SignUpPage` widget from the navigation stack and let the `StreamBuilder` in the `main.dart` file handles the navigation to the `ChatPage` widget.
3. `LoginPage`: add the functionality to sign in an existing user using the `firebase_auth` package.
   1. Check if the form state is valid
   2. Sign in the user using the `signInWithEmailAndPassword` method like:

        ```dart
        FirebaseAuth.instance.signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
                );
        ```

        *Note: Hover on the methods to see edge-cases*
   3. We don't need to pop the `LoginPage` widget from the navigation stack because the `StreamBuilder` in the `main.dart` file will handle the navigation to the `ChatPage` widget.
   4. Add the button to enable anonymous sign-in. Use the `signInAnonymously` method like:

        ```dart
        FirebaseAuth.instance.signInAnonymously();
        ```

        *Note: Hover on the methods to see edge-cases*
4. `ChatPage`: add the functionality to sign out the user using the `firebase_auth` package.
   1. Add an option to sign out the user using the `signOut` method like:

        ```dart
        FirebaseAuth.instance.signOut();
        ```

   2. Refactor the input field row to a StatefulWidget called `ChatInputForm`. Wrap with a `Form` widget and add a controller and the validation to the submission. *Later we will add the functionality to send the message to the database*

### Set up `cloud_firestore` in the project

1. Create a new file called `collections.dart` in the `lib` directory.
2. Create a variable called `kChatMsgsCollection` of type `CollectionReference` and initialize it with the `chat_messages` collection in the database:

    ```dart
    final CollectionReference<Map<String, dynamic>> kChatMsgsCollection =
        FirebaseFirestore.instance.collection('chat_messages');
    ```

3. In `ChatPage`, remove the dummy `List<ChatMessageModel> messages` created earlier.
4. Wrap the `ListView.builder` widget with a `StreamBuilder` widget. The stream will be the `snapshots` stream of the `kChatMsgsCollection` variable. *Note: the stream query should look like that:*

    ```dart
    stream: kChatMsgsCollection.orderBy('time', descending: false).snapshots();
    ```

    This will sort the messages by time in ascending order.
5. Handle cases when the stream is waiting,has an error, or lacks data in the database.
6. In the `ChatMessageModel` class, add two methods:
    1. `fromJson` factory method to convert a `Map<String, dynamic>` object to a `ChatMessageModel` object.
    2. `toJson` method to convert a `ChatMessageModel` object to a `Map<String, dynamic>` object.
7. Back at the `ChatPage` widget, convert the `QuerySnapshot` object to a `List<ChatMessageModel>` object using the `map` method and the `fromJson` factory method, something like:

   ```dart
    final messages = snapshot.data!.docs.map((doc) {
                    final data = doc.data();
                    return ChatMessageModel.fromMap(data);
                  }).toList();
   ```
8. In `ChatInputForm` implement the functionality to send the message to the database.
   1. Check if the form state is valid
   2. Create a new `ChatMessageModel` object with the message, sender, and time. 
      1. The message is the value of the `message` field in the form.
      2. The sender is the uid of the current user. *Hint: use the `FirebaseAuth.instance.currentUser.uid` getter*
      3. The time is the current time. *Hint: use the `DateTime.now()` constructor*
   3. Add the message to the database using the `add` method like:

        ```dart
        kChatMsgsCollection.add(message.toJson());
        ```

   4. Clear the input field and reset the form state,
9. In `ChatMessageBubble` widget, update the check of the sender to show the message on the right side if the sender is the current user. *Hint: use the `FirebaseAuth.instance.currentUser.uid` getter*

----------

### Created by [Maor Meir Hajaj](https://www.github.com/hajajmaor)
