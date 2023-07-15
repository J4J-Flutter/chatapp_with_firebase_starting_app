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
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
   ```

9. Do the same in the `SignUpPage` widget

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
