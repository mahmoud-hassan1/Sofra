<div align="center">

<img src="https://img.shields.io/badge/Sofra-Recipe%20App-A11518?style=for-the-badge&logo=food&logoColor=white" alt="Sofra Banner" />

# 🍽️ Sofra — Discover & Share Recipes Around You

**A full-stack recipe-sharing platform with geo-discovery, built with Flutter & Node.js**

[![Flutter](https://img.shields.io/badge/Flutter-3.11+-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Node.js](https://img.shields.io/badge/Node.js-Express%205-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org)
[![MongoDB](https://img.shields.io/badge/MongoDB-Mongoose%209-47A248?style=flat-square&logo=mongodb&logoColor=white)](https://mongodb.com)
[![Cloudinary](https://img.shields.io/badge/Cloudinary-Media%20CDN-3448C5?style=flat-square&logo=cloudinary&logoColor=white)](https://cloudinary.com)
[![License](https://img.shields.io/badge/License-ISC-yellow?style=flat-square)](LICENSE)

[Features](#-features) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [API Reference](#-api-reference) • [Screenshots](#-screenshots)

---

</div>

## 🌟 What is Sofra?

**Sofra** (صُفرة — Arabic for "dining spread") is a recipe-sharing app that connects food lovers through their location. Users can browse trending dishes, discover meals shared by cooks nearby, publish their own recipes with step-by-step instructions, and build a personal cookbook of saved favorites.

> From your kitchen to your community — Sofra makes every meal a story worth sharing.

---

## ✨ Features

### 📱 Mobile App (Flutter)
- 🔐 **Authentication** — Secure sign-up & login with JWT
- 🏠 **Home Feed** — Browse all recipes with real-time search, category & region filters
- 🏆 **Top Liked** — Trending recipes ranked by community saves
- 📖 **Recipe Details** — Full ingredient list, ordered steps, image gallery & YouTube video link
- ➕ **Add Recipe** — Create and publish recipes with photo upload, cooking time, category, kitchen type & location tagging
- ❤️ **Save / Unsave** — Toggle a personal collection of favorite recipes (live like count)
- 👤 **Profile** — View your recipes, your saved collection, edit bio, display name & avatar
- 🎨 **Custom Design System** — BricolageGrotesque + HankenGrotesk typography, branded `#A11518` red theme, native splash screen

### 🖥️ Backend (Node.js / Express 5)
- 🔑 **JWT Auth** with bcrypt password hashing
- 🔍 **Full-text search** across recipe name, description, category & region
- 📦 **Cloudinary** image uploads (avatar + recipe photos via Multer)
- 🛡️ **Security** — Helmet, CORS, rate-limiting on auth routes (20 req / 15 min)
- ✅ **Zod validation** on every request body & query string
- 📄 **Pagination** on all list endpoints
- 🏗️ **Clean layered architecture** — routes → controller → service → model

---

## 🏛️ Architecture

```
sofra/
├── 📱 flutter/               # Mobile frontend
│   └── lib/
│       ├── core/             # Network, DI (GetIt), design system, shared widgets
│       └── features/
│           ├── auth/         # Login & Sign-up (BLoC/Cubit)
│           ├── home/         # Feed, nearby & top-liked tabs
│           ├── posts/        # Recipe browse & search
│           ├── recipe details/  # Full recipe view
│           ├── add recipe/   # Recipe creation flow
│           ├── favorite recipe/ # Saved recipes collection
│           └── profile/      # User profile & edit
│
└── 🖥️ backend/               # REST API
    └── src/
        ├── config/           # DB, Cloudinary, env
        ├── middlewares/      # Auth (JWT), validation, error, upload
        ├── modules/
        │   ├── auth/         # signup · login
        │   ├── users/        # profile · avatar
        │   ├── recipes/      # CRUD · search · geo · saves · likes
        │   └── media/        # Cloudinary upload
        └── shared/           # AppError, asyncHandler, JWT utils, pagination
```

**State management:** Flutter BLoC / Cubit pattern throughout  
**DI:** GetIt service locator (`service_locator.dart`)  
**HTTP client:** Dio with centralised `ApiService`

---

## 🚀 Getting Started

### Prerequisites

| Tool | Version |
|------|---------|
| Flutter SDK | ≥ 3.11.1 |
| Dart | ≥ 3.x |
| Node.js | ≥ 18 LTS |
| MongoDB | ≥ 6 (Atlas or local) |
| Cloudinary account | any free tier |

---

### 🖥️ Backend Setup

```bash
# 1. Clone and enter the backend folder
git clone https://github.com/your-username/sofra.git
cd sofra/backend

# 2. Install dependencies
npm install

# 3. Create your environment file
cp .env.example .env
```

Edit `.env` with your credentials:

```env
NODE_ENV=development
PORT=5000

MONGO_URI=mongodb+srv://<user>:<pass>@cluster.mongodb.net/sofra
JWT_SECRET=your_super_secret_key
JWT_EXPIRES_IN=7d
BCRYPT_SALT_ROUNDS=12

CORS_ORIGIN=*

CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```

```bash
# 4. Start the dev server (with hot-reload)
npm run dev

# Or for production
npm start
```

The API will be running at `http://localhost:5000/api`

---

### 📱 Flutter Setup

```bash
# 1. Enter the Flutter folder
cd sofra/flutter

# 2. Install packages
flutter pub get

# 3. Configure the base URL
# Open lib/core/network/api_constants.dart and set your backend URL:
# static const String baseUrl = 'http://<your-ip>:5000/api';

# 4. Run the app
flutter run
```

> **Android emulator tip:** Use `http://10.0.2.2:5000/api` to reach your localhost backend.

---

## 📡 API Reference

### Authentication
| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/auth/signup` | ❌ | Register a new user |
| `POST` | `/api/auth/login` | ❌ | Login & receive JWT |

### Users
| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/users/me` | ✅ | Get current user profile |
| `PATCH` | `/api/users/me` | ✅ | Update display name / bio |
| `PATCH` | `/api/users/me/avatar` | ✅ | Upload new avatar image |

### Recipes
| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/recipes` | Optional | List all recipes (search, region, category filters) |
| `GET` | `/api/recipes/top-liked` | Optional | Recipes sorted by like count |
| `GET` | `/api/recipes/me` | ✅ | My published recipes |
| `GET` | `/api/recipes/saved` | ✅ | My saved recipes |
| `GET` | `/api/recipes/:id` | ✅ | Full recipe details |
| `POST` | `/api/recipes` | ✅ | Create a new recipe |
| `POST` | `/api/recipes/:id/save` | ✅ | Toggle save / unsave (updates like count) |

### Media
| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/media/recipe-image` | ✅ | Upload a recipe image to Cloudinary |

---

## 🧰 Tech Stack

### Frontend
| Library | Purpose |
|---------|---------|
| `flutter_bloc` | State management (Cubit) |
| `dio` | HTTP client |
| `get_it` | Dependency injection |
| `image_picker` | Camera / gallery access |
| `flutter_svg` | SVG asset rendering |
| `dotted_border` | UI decoration |

### Backend
| Package | Purpose |
|---------|---------|
| `express` v5 | Web framework |
| `mongoose` | MongoDB ODM |
| `jsonwebtoken` | JWT auth |
| `bcryptjs` | Password hashing |
| `zod` | Schema validation |
| `cloudinary` + `multer` | Image upload & CDN |
| `helmet` + `express-rate-limit` | Security hardening |
| `morgan` | HTTP request logging |

---

## 📂 Project Structure (Backend Detail)

```
src/
├── app.js              # Express app setup (middleware stack)
├── server.js           # HTTP server + DB connection boot
├── config/
│   ├── db.js           # Mongoose connect
│   ├── cloudinary.js   # Cloudinary SDK init
│   └── env.js          # Validated env vars
├── middlewares/
│   ├── auth.middleware.js        # authRequired / authOptional guards
│   ├── validate.middleware.js    # Zod request validation
│   ├── uploadImage.middleware.js # Multer memory storage
│   ├── error.middleware.js       # Global error handler
│   └── notFound.middleware.js    # 404 catcher
├── modules/
│   ├── auth/       { controller · service · routes · validation }
│   ├── users/      { controller · service · routes · model · validation }
│   ├── recipes/    { controller · service · routes · model · mapper · validation }
│   ├── saves/      { model }
│   └── media/      { controller · service · routes }
└── shared/
    ├── errors/AppError.js
    └── utils/ { asyncHandler · jwt · pagination }
```

---

## 🔒 Security Highlights

- Passwords hashed with **bcrypt** (12 rounds by default)
- Auth routes rate-limited to **20 requests per 15 minutes**
- `helmet` sets secure HTTP headers on every response
- JWT secrets & API keys are **never committed** — loaded via `.env`
- Zod validates every incoming request before it touches the database
- `passwordHash` field is **`select: false`** in Mongoose — never leaked in responses

---

# 📸 Screenshots

Take a quick look at the Sofra experience—from discovering recipes to sharing your own culinary creations.

### 🔐 Authentication

| Login | Sign Up |
|-------|---------|
| <img src="https://github.com/user-attachments/assets/95f6e753-b449-4aab-9839-345f8e8eb69b" width="250">  | <img src="https://github.com/user-attachments/assets/4337c414-760d-432e-b7a1-1e5bb7126b79" width="250"> |

---

### 🏠 Home

| Home Feed |
|-----------|
| <img width="250" height="1000" alt="Home" src="https://github.com/user-attachments/assets/b47d0b4b-9866-4244-8135-7e4d1e68dbec" /> |

---

### 🍽️ Recipe Details

| Recipe Details | Add Recipe |
|----------------|------------|
| <img width="250" height="1300" alt="Home" src="https://github.com/user-attachments/assets/e3f449f3-bbbb-448b-917c-d2da386cd744" /> | <img width="250" height="1000" alt="add recipe" src="https://github.com/user-attachments/assets/789fd93a-2970-4bd7-b556-110bee2de7e7" /> |


---

### ➕ Saved and Created Posts

| Saved Recipes | Profile |
|---------------|---------|
| <img width="250"  alt="favourite recipes" src="https://github.com/user-attachments/assets/0354914a-ebbc-4357-9dc9-eb78b1b06da9" /> | <img width="250" alt="profile" src="https://github.com/user-attachments/assets/3e598612-3433-4cce-80e3-42bae9b32c5f" />
 |

---

## 🤝 Contributors

- 👨🏻‍💻 Abdelrahman Khaled Mohammed "UI/UX Designer" [Github](https://github.com/AbdelrhmanKhaled76)
- 👨🏻‍💻 Ahmed Elkady [Github](https://github.com/ahmedellkady)
- 👨🏻‍💻 Filopateer Fouad bekheet [Github](https://github.com/FilopateerFouad)
- 👨🏻‍💻 Islam Adel Ahmed [Github](https://github.com/ISLAM2ADEL)
- 👨🏻‍💻 Mahmoud Hassan [Github](https://github.com/mahmoud-hassan1)
- 👩🏻‍💻 Mariam Essam Edward [Github](https://github.com/MariamEssam5)
- 👨🏻‍💻 Mohamed EssamElDin AbdelFattah [Github](https://github.com/MohamedEssam2127)

---
<div align="center">

Made with ❤️ and a lot of good food

**⭐ If Sofra made you hungry, give it a star!**

</div>
