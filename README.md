# Drake Huang's Resume

[![Deploy to GitHub Pages](https://github.com/drakehuang81/drakehuang81.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/drakehuang81/drakehuang81.github.io/actions/workflows/deploy.yml)

A professional interactive resume built with [Flutter](https://flutter.dev), deployed as a web application.

Check out the live version here: [https://drakehuang81.github.io/](https://drakehuang81.github.io/)

## 🚀 Features

- **Responsive Design**: Optimized for both desktop and mobile viewing experiences.
- **Multilingual Support**: Built-in localization support (English/Chinese).
- **Interactive UI**: Smooth animations and modern material design components.
- **Automated Deployment**: CI/CD pipeline set up with GitHub Actions to automatically deploy to GitHub Pages.

## 🛠️ Built With

- [Flutter](https://flutter.dev) - UI Toolkit
- [Dart](https://dart.dev) - Programming Language
- [GitHub Actions](https://github.com/features/actions) - CI/CD

## 💻 Local Development

1. **Clone the repository**
   ```bash
   git clone git@github.com:drakehuang81/drakehuang81.github.io.git
   cd drakehuang81.github.io
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate localization files**
   ```bash
   flutter gen-l10n
   ```

4. **Run the app**
   ```bash
   flutter run -d chrome
   ```

## 📦 Building for Production

To build the project for web:

```bash
flutter build web --release
```

## 🔄 Deployment

This project includes a GitHub Actions workflow (`.github/workflows/deploy.yml`) that automatically builds and deploys the application to GitHub Pages whenever changes are pushed to the `main` or `master` branch.

## 📄 Sections

- **Experience**: detailed professional history.
- **Education**: academic background.
- **Skills**: technical and soft skills.
- **Contact**: links to social profiles and email (if applicable).
