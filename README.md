# Event Editor

The event editor application is a user interface for organizers to add/modify events displayed on PennMobile.

## Setup

```bash
bundle install
rails db:migrate
rails server
```

## S3 Image Storage

By default, images are stored on a folder on the server.
Set the following environment variables to use S3 to store images:
- `S3_BUCKET_NAME`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
