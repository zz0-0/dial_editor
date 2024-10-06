# 📜 dial_editor

**Dial Editor** is a Markdown editor built using Flutter and Riverpod.

[![dial_editor](https://github.com/zz0-0/dial_editor/actions/workflows/github-actions.yml/badge.svg)](https://github.com/zz0-0/dial_editor/actions/workflows/github-actions.yml)

![Alt](https://repobeats.axiom.co/api/embed/67f4dddccfa76c1d0463558d8dcf73e61daa6723.svg "Repobeats analytics image")

## ⚠️ Disclaimer

**Warning:** I am currently pursuing a master's degree and do not have much time for development at the moment. I intend to resume work on this personal project later on.

**Warning:** This project is in its early stages. Use it at your own risk.

## 🚀 Features

## 🛠️ To-Do

- [ ] **Markdown Support**
  - [ ] **Markdown Parser**: Implement a parser for converting Markdown text into structured data. **Markdown Render**: Develop a renderer to display Markdown content with proper formatting.
    - [x] Heading (https://github.com/zz0-0/dial_editor/issues/34)
      - [x] Heading block (https://github.com/zz0-0/dial_editor/issues/38)
      - [x] Heading id (https://github.com/zz0-0/dial_editor/issues/35)
      - [ ] Bidirectional link (https://github.com/zz0-0/dial_editor/issues/36)
    - [x] Bold
    - [x] Italic
    - [x] Bold Italic
    - [x] Strikethrough
    - [x] Unordered list
      - [x] List block (https://github.com/zz0-0/dial_editor/issues/40)
    - [x] Ordered list
      - [x] List block (https://github.com/zz0-0/dial_editor/issues/40)
    - [x] Task list
      - [x] List block (https://github.com/zz0-0/dial_editor/issues/40)
    - [ ] Definition list
      - [ ] List block (https://github.com/zz0-0/dial_editor/issues/40)
    - [x] Horizontal rule
    - [x] Quote
      - [x] Quote block (https://github.com/zz0-0/dial_editor/issues/39)
    - [x] Emoji
    - [x] Hightlight
    - [x] Link
    - [x] Image
    - [ ] Table
      - [ ] Table block (https://github.com/zz0-0/dial_editor/issues/8)
    - [x] Code
      - [x] Code block (https://github.com/zz0-0/dial_editor/issues/6)
    - [ ] Footnote (https://github.com/zz0-0/dial_editor/issues/11)
    - [x] Math Equation (https://github.com/zz0-0/dial_editor/issues/19)
      - [x] Math Block
    - [ ] Diagram (https://github.com/zz0-0/dial_editor/issues/9)
      - [x] Code block (https://github.com/zz0-0/dial_editor/issues/6)
    - [ ] Table of content (https://github.com/zz0-0/dial_editor/issues/10)
    - [ ] Video
    - [ ] Page breaks
  - [ ] **Keyboard Shortcut**
    - [x] Ctrl A: Select All
    - [x] Key Arrow Up
    - [x] Key Arrow Down
    - [x] Key Arrow Left
    - [x] Key Arrow Right
    - [ ] Tab Indentation
  - [x] **Mouse Selection**
- [x] **Line Number**
- [ ] **Folder context menu** (https://github.com/zz0-0/dial_editor/issues/34)
- [x] **Auto Save**
- [ ] **Undo/Redo**
  - [x] Currently utilizing the default editable text functionality for undo/redo.
  - [ ] Full text undo/redo
- [x] **Dark theme**: Theme switch
  - [ ] **Customizable Themes**: Choose from a variety of themes to suit your style.
    - [x] overall theme - basic dark, light theme
    - [ ] theme color
    - [ ] text theme
- [ ] **Collaborative Editing**: Real-time collaboration with others.
  - [ ] crdt
- [ ] **Export Options**: Enable users to export Markdown files to PDF, HTML, etc. (https://github.com/zz0-0/dial_editor/issues/7)
- [ ] **Spell Check**: Implement functionality to ensure error-free Markdown.
- [ ] **Version Control**: Track changes and allow users to revert to previous versions. (https://github.com/zz0-0/dial_editor/issues/12)
- [ ] **Third Party Integration**: Integrate with third-party services or APIs for extended functionality.
- [x] **Live Preview**: See your Markdown rendered in real-time.
- [ ] **Syntax Highlighting**: Easily distinguish between different elements of your Markdown. (https://github.com/zz0-0/dial_editor/issues/41)
- [ ] **Keyboard Shortcuts**: Boost your productivity with handy shortcuts.
- [ ] **Support for Extensions**: Enhance the editor with additional functionalities.
- [ ] **Cross-Platform**: Ensure compatibility on both mobile and desktop platforms.
  - [x] Flutter supports all platforms.
  - [ ] Desktop UI
  - [ ] Mobile UI
  - [ ] Web UI
- [ ] **Infinite Canvas**: Interchangeable markdown canvas that constructs and edits your markdown file visually (https://github.com/zz0-0/dial_editor/issues/16)
  - [ ] standalone canvas view (https://github.com/zz0-0/dial_editor/issues/42)
  - [ ] integrate with markdown file (https://github.com/zz0-0/dial_editor/issues/43)

## 🖥️ Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- Knowledge of [Riverpod](https://riverpod.dev/) for state management.

### Installation

#### Install Visual Studio Code

Download and install Visual Studio Code from https://code.visualstudio.com/download.

#### Install Flutter

Download and install Flutter SDK from https://docs.flutter.dev/get-started/install. Once you have the SDK, refer to https://flutter-ko.dev/get-started/install/windows for a comprehensive installation guide on setting up Flutter and Dart. You can find the official installation guide on the Flutter website.

#### Run flutter doctor

Run flutter doctor in your terminal, once you have installed Flutter on your system, it will automatically check for the necessary system requirements to run the program. These requirements may include the Android toolchain, Chrome, Visual Studio, and Android Studio.

#### Install Chrome

Download and install Chrome form https://www.google.com/chrome/browser-tools/. Chrome is the default web browser utilized by Flutter when running the app.

#### Install Visual Studio

Download and install Visual Studio from https://visualstudio.microsoft.com/downloads/.

#### Install Android Studio

Download and install Android Studio from https://developer.android.com/studio.

#### Install Android toolchain

To install Android toolchain, these steps need to be followed:

1. Open Android Studio
2. In the Menu bar, click Tools
3. choose SDK Tools panel
4. Tick Android SDK Command-line Tools
5. Click Apply at bottom of the window

#### Clone git repository

After installing all the required software and tools, run flutter doctor again to validate.
Once you have done that, open a terminal and clone the project's Git repository using git clone https://github.com/zz0-0/dial_editor.git

```bash
git clone https://github.com/zz0-0/dial_editor.git
cd dial_editor
```

#### Get flutter packages

Use Visual Studio Code to open the project and then run in the terminal: flutter pub get, to get all the required flutter packages.

```bash
flutter pub get
```

#### Run

##### Run on android

To run the app, you can navigate to the main.dart file located under the lib directory. There are two methods to run the app. First, you can go to the bottom right corner of Visual Studio Code, click on No device and select Start Flutter Emulator. Then, locate the button group of Run, Debug, and Profile just above the main method. Clicking on Run will run the app. Alternatively, you can still be on the main.dart file and go to the top right corner of Visual Studio Code, where you'll find a button labeled Start Debugging. Click on the dropdown and select Run without Debugging.

##### Run on desktop

```bash
flutter run
```

or

Locate the button group of Run, Debug, and Profile just above the main method. Clicking on Run will run the app.

#### Open markdown file

##### Android

Once the Android emulator has launched and the app is running, you can either open an existing folder or create a new one within the app. After that, you will be able to create a new markdown file or open an existing one for editing. I have included a markdown file for you, which you can simply drag into the download folder for testing.

##### Desktop

On Desktop, you can either open an existing folder or create a new one within the app which includes markdown file.

#### Start typing

Inside the markdown file, begin writing in markdown syntax.

## 🤝 Contributing

Contributions are welcome! Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file for guidelines.

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your_feature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your_feature`).
5. Open a pull request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

## 📬 Contact

Feel free to reach out via [email](mailto:zz11009988@outlook.com) for any questions or feedback.
