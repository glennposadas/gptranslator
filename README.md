# GPXML-Localizer

![enter image description here](https://i.imgur.com/2sIjukq.png)

****GPXML-Localizer**** is a macos application, an online assessment test, as part of my job application at [Innovattic.](https://www.innovattic.to/)

So far the application can only write a single translation file.

---

## TODOS
- Loop through the selected files to be translated.
- Utilize MVVM pattern.
- More aesthetics.
- UT/UI Tests.

## Tech Stacks

The project was built using **Xcode 11.5**, **Swift 5.2.4**. 
Dependencies are managed by [Cocoapods](https://cocoapods.org/).

**MVVM** is the targetted architectural pattern, but is actually **MVC**.

---
# NON TECHNICAL PART
This part of the document contains instructions on how to build and run the project **iSearch**

## Getting Started

You'll need the following software installed on your mac machine.

1. Xcode - You can download it from the App Store on your mac.

---

## Downloading the source codes

Download the project is pretty straight forward. Find the GREEN button that says Clone Or Download, and you're good to go.

![Clone or download](https://i.imgur.com/CZNfTCu.png)

---

## Building the project

Build and running the project on to your simulator is easy. Make sure you are using `.xcworkspace` (white icon) and NOT `.xcodeproject` (blue icon). 
There's a difference between these two project files.

Now click on the **PLAY** button in your Xcode. Or simple press `CMD` + `R` to run the project on to your selected simulator or device. When running the project on to your real device, you will need to setup some certificates on your local machine.

---

## TestFlight

Inviting an internal user (a user under your Apple Developer Account) is quite not simple. I wrote before a wiki for this:
[A Thorough Guide In Testing Apps Via TestFlight For Clients, Bosses, and Testers](https://github.com/glennposadas/TestFlight-Guide/wiki/A-Thorough-Guide-In-Testing-Apps-Via-TestFlight---For-Clients,-Bosses,-and-Testers).

---
## Support | Contact

Should there be questions or any discussions, you may contact me: https://www.glennvon.com/
