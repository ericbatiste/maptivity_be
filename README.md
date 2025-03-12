# Maptivity API

Rails API backend for my [Maptivity iOS application](https://github.com/ericbatiste/maptivity). This api handles user authentication via JWT token exchange and endpoints for tracking activities that contain geolocation data.

## Setup

1. Prerequisites:
   - Ruby 3.0+
   - PostgreSQL
   - Bundler

2. Installation:
   ```bash
   git clone https://github.com/ericbatiste/maptivity-be.git
   cd maptivity-be
   bundle install
   rails db:create db:migrate
   ```

3. Start a local server if you have postgresql downloaded:
   ```bash
   rails s
   ```

## API Endpoints

### Authentication

| Endpoint | Method | Description | Request Body |
|----------|--------|-------------|--------------|
| `/api/v1/auth/signup` | POST | Register user | `{ "user": { "name": "John", "email": "john@example.com", "password": "pass123" } }` |
| `/api/v1/auth/login` | POST | Log in | `{ "email": "john@example.com", "password": "pass123" }` |
| `/api/v1/auth/refresh` | POST | Refresh token | `{ "refresh_token": "refresh_token" }` |
| `/api/v1/auth/logout` | DELETE | Log out | _Requires Authorization header_ |

### Users

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/users/me` | GET | Get user profile |
| `/api/v1/users/me` | PATCH/PUT | Update profile |
| `/api/v1/users/me` | DELETE | Delete account |

### Activities

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/activities` | GET | List activities |
| `/api/v1/activities/:id` | GET | Get activity |
| `/api/v1/activities` | POST | Create activity |
| `/api/v1/activities/:id` | PATCH/PUT | Update activity |
| `/api/v1/activities/:id` | DELETE | Delete activity |

## Activity Parameters

When creating or updating an activity, these parameters are available:
```
title
designation
notes
start_time
end_time
route
distance
max_speed
average_speed
climbing
descending
```

## Authentication

- All endpoints except signup, login, and refresh require JWT authentication
- Include the token in requests using: `Authorization: Bearer {token}`
- When a token expires, use the refresh endpoint to get a new one

## Development Status

This API is currently under active development.