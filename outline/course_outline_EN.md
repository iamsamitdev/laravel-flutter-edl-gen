# Basic to Advanced Laravel 13 and Flutter Framework

**30 Hours (5-Day Training, 6 Hours per Day)**  
*Hands-on Workshop — IT Genius Engineering*  
Course ID: **MOB-15** | Category: Mobile / Full-Stack

---

## Introduction

Modern application development demands a cleanly layered architecture: a backend that serves data through APIs, and a mobile front end that responds instantly, keeps working under unstable network conditions, and stays maintainable over the long term. Choosing the right stack — and knowing how to use each tool for the right job — has become an essential skill for today's developers.

This course takes developers on a journey from basic to advanced, building a complete full-stack system end to end. It starts with a backend API built on **Laravel 13** running against MariaDB/PostgreSQL, and continues all the way to a **Flutter mobile app** that uses **Riverpod 3.0 + Cubit** for state management — a hybrid approach well suited to enterprise work. Learners write real code every day and assemble all the pieces into a complete workshop on the final day.

> **Note:** This is a hands-on course. Every day includes labs where learners write code step by step. Participants should install Flutter SDK, Android Studio, Docker, PHP 8.3, and Composer before the training begins.

---

## Schedule

- **Duration:** 5 days, 6 hours per day, 30 hours total
- **Hours:** 09:00–12:00 and 13:00–16:00 (1-hour lunch break)
- **Format:** In-house training or online via Zoom
- **Daily labs:** Learners write real code on their own machines, with a prepared Starter Kit

---

## Training Topics Overview

- **Laravel 13 API Layer:** Design RESTful APIs with Laravel Sanctum/JWT, API Resources, and the Repository Pattern on MariaDB/PostgreSQL
- **Riverpod 3.0 Async State:** AsyncValue, AsyncNotifier, Mutations API (idle→pending→success/error), and Automatic Retry
- **Flutter Foundation:** Widget Tree, BuildContext, Stateless vs Stateful Widget — learn the "problem" first to understand *why* state management matters
- **Riverpod 3.0 Fundamentals:** Provider types, ConsumerWidget, ref.watch/read/listen, and @riverpod code generation
- **Riverpod Advanced + Cubit:** NotifierProvider, StreamProvider (WebSocket), Offline Persistence, AuthCubit, BlocObserver
- **End-to-End Workshop:** Assemble every piece into a real monitoring app covering Login, Real-time Dashboard, Offline Reports, Incident Reporting, and Data Logging

---

## Instructor

**Samit Koyom** — A software development and mobile application design specialist with more than 15 years of experience in IT training and building systems for large organizations across the ASEAN region.

- **Teaching experience:** Over 10 years as an instructor in Mobile App Development, API Design, and Database Architecture
- **Expertise:** Laravel, Flutter, Node.js, React Native, PostgreSQL, Docker, and Cloud-Native Architecture
- **Past work:** Designed and developed systems for public- and private-sector organizations in Thailand, Laos, and Cambodia, including energy and infrastructure projects
- **Teaching philosophy:** "Learn from real problems, solve with real code" — every lab is designed to map directly to learners' use cases

---

## Prerequisites

- **Programming basics:** Knowledge of PHP (basic OOP) and introductory Dart/Flutter, or experience developing other apps
- **Database:** Understanding of basic SQL (SELECT, INSERT, JOIN) on MariaDB or PostgreSQL
- **Git & Terminal:** Able to git clone, commit, push, and run terminal / command-prompt commands
- **No prior knowledge required of:** Riverpod, Cubit, Laravel Sanctum, or WebSocket — the course teaches these from the ground up

---

## Course Highlights

- **Basic to Advanced in one course:** Start from Laravel and Flutter fundamentals, progressively level up to advanced state management and offline-first architecture, and finish by building a real app
- **Hybrid State Management (Riverpod 3.0 + Cubit):** Use both together where each fits best — Riverpod for the data layer and async state, Cubit for complex business logic such as auth flow and audit trails
- **Offline-First Architecture:** Designed so the app keeps working when the network drops, using riverpod_sqflite caching that syncs back when online
- **Laravel 13 + Repository Pattern:** Write clean, testable APIs that can switch between MariaDB and PostgreSQL without touching business logic
- **Updated for 2026:** Uses Flutter 3.x, Dart 3.x, Riverpod 3.0 (the new Mutations API), Laravel 13, and PHP 8.3 — the latest community-supported tooling
- **BlocObserver / Audit Trail:** Every state change is logged automatically, suitable for organizational security standards and retrospective auditing

---

## Course Objectives

- Enable learners to design and build RESTful APIs with Laravel 13, complete with authentication (Sanctum/JWT) and the Repository Pattern on MariaDB/PostgreSQL
- Enable learners to understand the Flutter widget tree and build UI components for a dashboard
- Enable learners to apply Riverpod 3.0 for async state management, covering AsyncValue, AsyncNotifier, and the new Mutations API
- Enable learners to use Cubit for enterprise-grade business logic such as auth sessions, status management, and audit logging
- Enable learners to build an offline-first mobile app that caches data and syncs back when reconnected
- Enable learners to walk away with an application prototype ready to extend into production use

---

## Who Is This Course For?

- **Software developers:** Who want to build or maintain full-stack systems with Laravel and Flutter
- **Backend developers:** With a PHP/Laravel foundation who want to connect their API to a Flutter mobile app
- **Mobile developers:** Who want to learn advanced state management with Riverpod 3.0 and Cubit in a real project
- **Junior developers:** New to Flutter who want to learn state management in a real project from the start

---

## Required Computer & Environment

- **Operating system:** Windows 10/11 (64-bit), macOS 13+, or Ubuntu 22.04
- **Flutter & Dart:** Flutter SDK 3.x (stable channel), Dart 3.x, Android Studio Ladybug or VS Code + Flutter Extension
- **PHP & Laravel:** PHP 8.3+, Composer 2.x, Laravel 13 — installed via Laragon (Windows) or Homebrew/Docker
- **Database:** MariaDB 11.x or PostgreSQL 16+ (Docker image provided)
- **Other tools:** Git 2.x, Postman/Bruno (API testing), Android Emulator or physical device (Android 9+)
- **RAM:** 16 GB or more recommended (Android Studio + Laravel + PostgreSQL running together)

---

## Course Content

### Day 1: Laravel 13 API Layer + Riverpod Async State

**Laravel 13 API Layer**

- **Laravel 13 Project Setup + API Architecture:** Install and configure Laravel 13 with the Repository Pattern — separate Controller, Service, and Repository for clean and testable code, with API versioning (`/api/v1/`)
- **Authentication with Laravel Sanctum + JWT:** Design the Login/Logout flow, token-based auth for mobile clients, and middleware guards for protected routes
- **API Resources & Collections:** Transform Eloquent models into clean JSON responses with Resource Classes, nested collections, and conditional fields — preventing over-fetching
- **MariaDB / PostgreSQL Repository Pattern:** Write a repository interface and concrete implementation that can switch drivers without changing business logic — including migrations, seeders, and database transactions

**Riverpod Async State**

- **Riverpod 3.0 AsyncValue:** Understand the state machine (data / loading / error) and how to consume API results with `when()` / `guard()` in a null-safe way
- **AsyncNotifier + Mutations API (3.0):** Build an AsyncNotifier for CRUD using the new Mutations API with the lifecycle `idle → pending → success/error`
  - Add data
  - Update status
  - UI feedback for each state
- **Automatic Retry:** Add retry logic with Riverpod's `retry` parameter and a custom exception handler for unstable networks

> 🔬 **Day 1 Lab:** Build a Laravel API endpoint with Sanctum auth, plus a Flutter widget that fully renders the AsyncValue Loading/Error/Data states

---

### Day 2: Flutter Foundation + Widget System

**Flutter Architecture Overview**

- **Flutter Rendering Pipeline:** Understand the Widget Tree, Element Tree, and RenderObject Tree — and why Flutter rebuilds faster than native in many cases
- **StatelessWidget vs StatefulWidget + setState:** Build UI with StatefulWidget and setState until the "problems" become clear — scattered state, prop-drilling, and unnecessary rebuilds ⚡ _Taught to make the "problem" clear first_
- **Widget Tree & BuildContext:** Learn to use BuildContext correctly, the differences between contexts at each level, and how to avoid common context-related bugs

**Layout & Navigation**

- **Layout Widgets:** Column, Row, Stack, Expanded, Flexible, ListView.builder, GridView.builder — build a responsive dashboard layout that works on both phones and tablets
- **Custom Widgets + Composition Pattern:** Break UI into small, reusable widgets such as `StatCard`, `StatusBadge`, `AlertTile` — practicing the DRY principle
- **Navigation + GoRouter:** Configure GoRouter for named routes, route guards (auth check), deep links, and bottom navigation

> 🔬 **Day 2 Lab:** Build a Flutter app skeleton — with Login, Dashboard (mockup), Reports, and Settings screens, complete navigation, and at least 3 custom widgets

---

### Day 3: Riverpod 3.0 Fundamentals — Provider Types & Consumer Patterns

**ProviderScope & Provider Types**

- **Why State Management?** Revisit the Day 2 `setState` problems: compare code before/after Riverpod — see prop-drilling, unnecessary rebuilds, and testability
- **ProviderScope + Provider Lifecycle:** Set up ProviderScope at the root, auto-dispose, keep-alive, and how to override providers in a test environment
- **Basic Provider Types:**
  - `Provider` — constants / singletons
  - `StateProvider` — values the UI changes easily (filter/toggle)
  - `FutureProvider` — read-only API calls

**Consumer Patterns & Code Generation**

- **ConsumerWidget & ConsumerStatefulWidget:** Write widgets that subscribe to Riverpod providers correctly
- **ref.watch vs ref.read vs ref.listen:** The most important distinction in Riverpod — `watch` (rebuild), `read` (one-time), `listen` (side effect) + anti-patterns to avoid
- **@riverpod Annotation + Code Generation:** Use `riverpod_generator` and `riverpod_annotation` to create type-safe providers via annotations and reduce boilerplate

> 🔬 **Day 3 Lab:** Connect the Flutter app to the Day 1 Laravel API using FutureProvider and AsyncNotifier — display real data on the dashboard with a loading skeleton and error banner

---

### Day 4: Advanced Riverpod + Cubit for Enterprise Logic

**Riverpod Advanced**

- **NotifierProvider:** Use for state with multiple fields and methods, such as a report state with filter, sort, pagination, and refresh
- **StreamProvider + WebSocket Real-time:** Connect to a Laravel WebSocket (Pusher/Ably or Laravel Echo) — display real-time data ✅ _Real-time monitoring_
- **Provider Family:** Create providers that take parameters such as `detailProvider(id)` for the list/detail pattern
- **Offline Persistence (riverpod_sqflite):** Cache data into SQLite — define TTL, sync strategy, and conflict resolution when back online
- **Provider Scoping & Override:** For testing and multi-tenant architecture

**Cubit — Supplementing Enterprise Logic**

- **Cubit vs BLoC:** Compare the two and explain why Cubit is chosen — it's simpler and well-suited to enterprise logic at this scale
- **AuthCubit (Login / Logout / Session):** Token storage (`flutter_secure_storage`), auto-refresh token, session timeout, app-wide logout
- **StatusCubit:** Track state with a `BlocObserver` that logs every transition as an audit trail ✅ _Audit trail_

> 🔬 **Day 4 Lab:** Add a real-time dashboard with StreamProvider + WebSocket, an AuthCubit for the login flow, and offline cache — test by turning off the network and observing how the app falls back

---

### Day 5: End-to-End Workshop — EDL-Generation Monitoring App

**Feature 1 — Login & Auth Flow (Cubit + Laravel Sanctum)**

- Assemble AuthCubit with the Laravel Sanctum API — Login, Token Refresh, Logout
- Route guard via GoRouter redirect when the token expires

**Feature 2 — Real-time Power Dashboard (StreamProvider + WebSocket)**

- Display power output (MW), frequency (Hz), and voltage in real time with `fl_chart`
- Auto-updates every time the server pushes new data

**Feature 3 — Daily Production Report (AsyncNotifier + Offline Cache)**

- Fetch daily production reports from the Laravel API and cache to SQLite
- Filter by time range and plant — usable even without a network

**Feature 4 — Machine Incident Reporting (Mutations API + Push Notification)**

- Submit incidents with photos, GPS coordinates, and severity level
- Show the complete `idle/pending/success/error` cycle

**Feature 5 — Meter Reading Entry (Cubit + MariaDB via Laravel API)**

- A form to log hourly meter readings with validation
- Optimistic UI update and persistence to MariaDB through the Laravel API

**Code Review & Best Practices**

- Review the code written over the 5 days and point out anti-patterns to fix
- How to unit test Cubit and Riverpod providers
- Introductory CI/CD guidance (GitHub Actions)

> 🔬 **Day 5 Workshop — Final PoC Presentation:** Each team presents its complete prototype, receives feedback, and plans next steps for continued development in a real project

---

## What Learners Receive Upon Completion

- **Monitoring app prototype:** A working Flutter app on Android with all 5 features
- **Laravel API codebase:** Clean Laravel 13 API source code with the Repository Pattern, authentication, and basic test cases
- **Training materials:** Slides, a lab guide, and Starter Kit code with a README (Thai)
- **Certificate of Completion:** A certificate from IT Genius Engineering
- **Community access:** Join the IT Genius LINE/Slack group for Q&A and networking

---

## Big Picture

This course is designed so each day builds on the last. Day 1 lays the foundation of the backend API and async state; Days 2–3 build the Flutter UI and teach Riverpod fundamentals; Day 4 levels up to advanced state management with Cubit and offline-first architecture; and Day 5 assembles every part into a real monitoring app prototype.

| Day | Focus | Outcome |
|-----|-------|---------|
| Day 1 | Laravel 13 API + Authentication + Riverpod Async State | Laravel API with auth; Flutter widget rendering AsyncValue state |
| Day 2 | Flutter Foundation — Widget System & Navigation | App skeleton with navigation, custom widgets, and layout |
| Day 3 | Riverpod 3.0 Fundamentals — Provider Types & Consumer Patterns | Flutter app connected to a real Laravel API, displaying data |
| Day 4 | Advanced State: StreamProvider, Cubit, Offline Cache | Working real-time dashboard, auth flow, and offline mode |
| Day 5 | Workshop: EDL-Generation Monitoring App, all 5 features | Prototype ready to present and extend into production |

---

## Tech Stack & Tools

| Layer | Technology |
|-------|-----------|
| Backend | Laravel 13, PHP 8.3, Laravel Sanctum, JWT Auth, Eloquent ORM, Laravel Echo |
| Database | MariaDB 11.x / PostgreSQL 16+ (Repository Pattern supports both drivers) |
| Mobile | Flutter 3.x (stable), Dart 3.x, GoRouter, fl_chart, flutter_secure_storage |
| State Management | Riverpod 3.0, riverpod_annotation, riverpod_generator, riverpod_sqflite, flutter_bloc (Cubit) |
| Dev Tools | Android Studio / VS Code, Postman/Bruno, Docker Compose, Git, TablePlus/DBeaver |
| DevOps | GitHub Actions for Laravel API tests + Flutter build (recommended on Day 5) |

---

## Pre-Training Recommendations

- **Prepare a sample dataset or mockup:** Have example data close to real-world work for use in labs and the workshop
- **Install tools beforehand:** Send a pre-install guide to learners at least 3 days ahead (Flutter SDK, Android Studio, Docker, PHP 8.3, Composer, Postman)
- **Test Android device / emulator:** Verify the Android emulator runs on every learner's machine — if the CPU lacks hardware acceleration, a physical device may be needed
- **Venue network:** Make sure the ports Laravel uses (8000, and 6001 for WebSocket) are not blocked by a firewall

---

## Contact

> **Interested in in-house training or want more details?**
>
> IT Genius Engineering  
> Tel. 02-570-8449 | Mobile 088-807-9770  
> Website: [www.itgenius.co.th](https://www.itgenius.co.th) | Email: contact@itgenius.co.th  
> LINE Official: @itgenius | Facebook: IT Genius Engineering
