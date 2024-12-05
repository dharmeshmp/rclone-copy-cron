# rclone-copy-cron

A lightweight Docker image for automated file copy operations using **Rclone** with cron. This image is designed to periodically copy data between a source and destination using Rclone, with configurable schedules via environment variables.

## Features

- Automatic file copying using cron.
- Customizable copy schedule with `BACKUP_CRON`.
- Supports multiple cloud storage providers with Rclone.
- Logs copy activity for easy monitoring.
- Lightweight and simple to set up.

---

## Getting Started

### Prerequisites

- Docker installed on your system.
- Rclone properly configured with the necessary remotes.

---

### Usage

#### Run with `docker run`

```bash
docker run --rm -it \
    -e BACKUP_CRON="0 * * * *" \
    -e RCLONE_SOURCE="source:my-source-bucket" \
    -e RCLONE_DESTINATION="destination:my-destination-bucket" \
    -e RCLONE_OPTIONS="--progress --fast-list --transfers=32 --checkers=64 --checksum" \
    -e RCLONE_CONFIG_SOURCE_TYPE="s3" \
    -e RCLONE_CONFIG_SOURCE_PROVIDER="AWS" \
    -e RCLONE_CONFIG_SOURCE_ACCESS_KEY_ID="your-access-key" \
    -e RCLONE_CONFIG_SOURCE_SECRET_ACCESS_KEY="your-secret-key" \
    -e RCLONE_CONFIG_SOURCE_REGION="your-region" \
    -e RCLONE_CONFIG_DESTINATION_TYPE="s3" \
    -e RCLONE_CONFIG_DESTINATION_PROVIDER="DigitalOcean" \
    -e RCLONE_CONFIG_DESTINATION_ACCESS_KEY_ID="your-access-key" \
    -e RCLONE_CONFIG_DESTINATION_SECRET_ACCESS_KEY="your-secret-key" \
    -e RCLONE_CONFIG_DESTINATION_REGION="us-east-1" \
    -e RCLONE_CONFIG_DESTINATION_ENDPOINT="your-endpoint" \
    rclone-copy-cron
```

#### Run with `docker-compose`

Create a `docker-compose.yml` file:

```yaml
version: "3.8"
services:
  copy:
    image: rclone-copy-cron
    environment:
      - BACKUP_CRON=*/30 * * * * # Runs every 30 minutes
      - RCLONE_SOURCE=source:my-source-bucket
      - RCLONE_DESTINATION=destination:my-destination-bucket
      - RCLONE_OPTIONS=--progress --fast-list --transfers=32 --checkers=64 --checksum
      - RCLONE_CONFIG_SOURCE_TYPE=s3
      - RCLONE_CONFIG_SOURCE_PROVIDER=AWS
      - RCLONE_CONFIG_SOURCE_ACCESS_KEY_ID=your-access-key
      - RCLONE_CONFIG_SOURCE_SECRET_ACCESS_KEY=your-secret-key
      - RCLONE_CONFIG_SOURCE_REGION=your-region
      - RCLONE_CONFIG_DESTINATION_TYPE=s3
      - RCLONE_CONFIG_DESTINATION_PROVIDER=DigitalOcean
      - RCLONE_CONFIG_DESTINATION_ACCESS_KEY_ID=your-access-key
      - RCLONE_CONFIG_DESTINATION_SECRET_ACCESS_KEY=your-secret-key
      - RCLONE_CONFIG_DESTINATION_REGION=us-east-1
      - RCLONE_CONFIG_DESTINATION_ENDPOINT=your-endpoint
```

Start the service:

```bash
docker-compose up
```

---

### Environment Variables

| Variable                       | Description                                                                                                                                | Required |
|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|----------|
| `BACKUP_CRON`                  | Cron expression for scheduling the copy operation. If not set, the container will exit with an error.                                      | Yes      |
| `RCLONE_SOURCE`                | The Rclone source path to copy data from.                                                                                                 | Yes      |
| `RCLONE_DESTINATION`           | The Rclone destination path to copy data to.                                                                                             | Yes      |
| `RCLONE_OPTIONS`               | Additional Rclone options (e.g., `--progress --fast-list --transfers=32 --checkers=64 --checksum`).                                       | Optional |
| `RCLONE_CONFIG_<REMOTE>_*`     | Rclone configuration for source and destination remotes (e.g., `RCLONE_CONFIG_SOURCE_TYPE`, `RCLONE_CONFIG_DESTINATION_PROVIDER`, etc.).   | Yes      |

---

### Logs

- Copy activity logs are stored in `/var/log/copy.log` inside the container.
- Logs can also be monitored in real-time via Docker logs:

```bash
docker logs -f <container-name>
```

---

### Example Use Case

#### Scenario:
You want to copy data from an AWS S3 bucket to a DigitalOcean Space every hour with progress tracking.

#### Environment Variables:
```bash
BACKUP_CRON="0 * * * *"
RCLONE_SOURCE="s3:my-source-bucket"
RCLONE_DESTINATION="do:my-destination-bucket"
RCLONE_OPTIONS="--progress --fast-list --transfers=32 --checkers=64 --checksum"
```

#### Command:
```bash
docker run --rm -it \
    -e BACKUP_CRON="0 * * * *" \
    -e RCLONE_SOURCE="s3:my-source-bucket" \
    -e RCLONE_DESTINATION="do:my-destination-bucket" \
    -e RCLONE_OPTIONS="--progress --fast-list --transfers=32 --checkers=64 --checksum" \
    rclone-copy-cron
```

---

### License

This image is open-source and available under the [MIT License](LICENSE).

---

### Contributing

Feel free to open an issue or submit a pull request for improvements!
