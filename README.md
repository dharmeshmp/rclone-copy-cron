# **rclone-copy-cron**

A lightweight Docker image for automated file copy operations using **Rclone** with cron. This image is designed to periodically copy data between a source and destination using Rclone, with configurable schedules via environment variables.


## **Features**  
- Automatic file copying using cron.
- Customizable copy schedule with `BACKUP_CRON`.
- Supports multiple cloud storage providers with Rclone.
- Logs copy activity for easy monitoring.
- Lightweight and simple to set up.
- Configurable timezone for cron jobs via the `TIME_ZONE` environment variable.  

---

## **Getting Started**

### Prerequisites

- Docker installed on your system.
- Rclone properly configured with the necessary remotes.

---

## **Usage**

### **Docker Run Example**

```bash
docker run -d \
  -e RCLONE_SOURCE=source:my-source-bucket \
  -e RCLONE_DESTINATION=backup:my-destination-bucket \
  -e RCLONE_OPTIONS="--progress --checksum" \
  -e BACKUP_CRON="0 2 * * *" \
  -e TIME_ZONE="Asia/Kolkata" \
  -e RCLONE_CONFIG_SOURCE_TYPE=s3 \
  -e RCLONE_CONFIG_SOURCE_PROVIDER=AWS \
  -e RCLONE_CONFIG_SOURCE_ACCESS_KEY_ID=your-access-key \
  -e RCLONE_CONFIG_SOURCE_SECRET_ACCESS_KEY=your-secret-key \
  rclone-copy-cron
```


### **Docker Compose Example**

```yaml
version: "3.9"
services:
  backup:
    image: rclone-copy-cron
    environment:
      - RCLONE_SOURCE=source:my-source-bucket
      - RCLONE_DESTINATION=backup:my-destination-bucket
      - RCLONE_OPTIONS=--progress --checksum
      - BACKUP_CRON=0 2 * * *
      - TIME_ZONE=Asia/Kolkata
      - RCLONE_CONFIG_SOURCE_TYPE=s3
      - RCLONE_CONFIG_SOURCE_PROVIDER=AWS
      - RCLONE_CONFIG_SOURCE_ACCESS_KEY_ID=your-access-key
      - RCLONE_CONFIG_SOURCE_SECRET_ACCESS_KEY=your-secret-key
```

---

## **Environment Variables**

| Variable                       | Description                                                                                   | Default       |
|--------------------------------|-----------------------------------------------------------------------------------------------|---------------|
| `RCLONE_SOURCE`                | Source path for rclone to copy files from.                                                    | None          |
| `RCLONE_DESTINATION`           | Destination path for rclone to copy files to.                                                 | None          |
| `RCLONE_OPTIONS`               | Additional rclone options (e.g., `--progress --checksum`).                                    | None          |
| `BACKUP_CRON`                  | Cron expression to schedule the rclone copy task.                                             | None          |
| `TIME_ZONE`                    | Timezone for the container (e.g., `Asia/Kolkata`, `UTC`).                                      | `UTC`         |
| `RCLONE_CONFIG_SOURCE_*`       | Configuration for the source remote (e.g., provider, keys, region).                           | None          |
| `RCLONE_CONFIG_DESTINATION_*`  | Configuration for the destination remote (e.g., provider, keys, region).                      | None          |

---

## **Examples of TIME_ZONE**

| Time Zone      | Example Value      |
|----------------|--------------------|
| UTC            | `UTC`             |
| Asia/Kolkata   | `Asia/Kolkata`    |
| America/New_York | `America/New_York` |

---

### **Logs**

- Copy activity logs are stored in `/var/log/copy.log` inside the container.
- Logs can also be monitored in real-time via Docker logs:

```bash
docker logs -f <container-name>
```

---

### **Example Use Case**

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

### **License**

This image is open-source and available under the [MIT License](LICENSE).

---

### **Contributing**

Feel free to open an issue or submit a pull request for improvements!
