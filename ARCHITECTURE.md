# 🧱 Architecture Overview

This project follows **Clean Architecture** principles, structured around feature modules and clear separation of concerns.

---

## 🧭 Clean Architecture Layers

             +-----------------------------+
             |         Presentation        |
             |  (Screens, Widgets, State)  |
             +-------------▲---------------+
                           │
             +-------------┴---------------+
             |           Domain            |
             |  (Entities, Repositories,   |
             |      Use Cases)             |
             +-------------▲---------------+
                           │
             +-------------┴---------------+
             |            Data             |
             | (Models, Datasources, Impl) |
             +-----------------------------+


- **Presentation:** Flutter UI + Riverpod providers
- **Domain:** Business logic layer, pure Dart (no Flutter imports)
- **Data:** Concrete data layer — models, remote/local sources, repo impls

---

## 📌 Key Design Decisions
- Riverpod is used across features via Provider, FutureProvider, and NotifierProvider.
- Each feature is self-contained, easily testable, and independently scalable.
- Shared functionality lives in core/ (app-level) or shared/ (feature-level reuse).

## 📁 Folder Structure

```
lib/
├── core/                   # Global theming, config, constants, reusable widgets
├── features/               # Feature-based modules
│   ├── campsite/           # Core functionality around campsites
│   │   ├── data/           # Remote/local sources, models, impl
│   │   ├── domain/         # Entities, Repositories, UseCases
│   │   └── presentation/   # Screens, Providers, Widgets
│   ├── filters/            # Filtering system
│   └── maps/               # Map screen, clustering logic
├── shared/                 # Cross-feature providers, extensions
└── main.dart               # App entry point
```