# **rclone-copy-cron**

A lightweight Docker image for automated file copy operations using **Rclone** with cron. This image supports both **scheduled backups** via cron and **immediate backups**, making it perfect for flexible and reliable cloud storage management.

---

## **Features**  
- **Scheduled Backups**: Automate file copy operations using the `BACKUP_CRON` environment variable.  
- **Immediate Backups**: If `BACKUP_CRON` is not set, the backup runs immediately, and the container exits.  
- **Multi-Cloud Compatibility**: Works seamlessly with Rclone-supported cloud storage providers.  
- **Configurable Time Zone**: Use the `TIME_ZONE` variable to set your desired timezone for cron scheduling.  
- **Comprehensive Logs**: Real-time and persistent logs for monitoring backup activity.  
- **Customizable Rclone Options**: Add advanced Rclone options for tailored performance.

---

## **Getting Started**

### Prerequisites

- Docker installed on your system.  
- Rclone configured with necessary remotes (e.g., AWS S3, Google Drive).

---

## **Usage**

### **1. Immediate Backup (No Cron)**

Run the container without specifying `BACKUP_CRON` to start a backup immediately and stop the container upon completion:

```bash
docker run --rm \
  -e RCLONE_SOURCE=source:my-source-bucket \
  -e RCLONE_DESTINATION=backup:my-destination-bucket \
  -e RCLONE_OPTIONS="--progress --checksum" \
  -e TIME_ZONE="Asia/Kolkata" \
  rclone-copy-cron
```

---

### **2. Scheduled Backup**

Specify a `BACKUP_CRON` expression to schedule periodic backups:

```bash
docker run -d \
  -e RCLONE_SOURCE=source:my-source-bucket \
  -e RCLONE_DESTINATION=backup:my-destination-bucket \
  -e RCLONE_OPTIONS="--progress --checksum" \
  -e BACKUP_CRON="0 2 * * *" \
  -e TIME_ZONE="Asia/Kolkata" \
  rclone-copy-cron
```

---

### **3. Docker Compose Example**

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

| Variable                       | Required | Description                                                                                   | Default       |
|--------------------------------|----------|-----------------------------------------------------------------------------------------------|---------------|
| `RCLONE_SOURCE`                | ✅       | Source path for Rclone to copy files from.                                                    | None          |
| `RCLONE_DESTINATION`           | ✅       | Destination path for Rclone to copy files to.                                                 | None          |
| `RCLONE_OPTIONS`               | ✅       | Additional Rclone options (e.g., `--progress --checksum`).                                    | None          |
| `BACKUP_CRON`                  | ❌       | Cron expression to schedule backups. If not set, the backup runs immediately and exits.       | None          |
| `TIME_ZONE`                    | ❌       | Timezone for the container (e.g., `Asia/Kolkata`, `UTC`).                                      | `UTC`         |
| `RCLONE_CONFIG_SOURCE_*`       | ✅       | Configuration for the source remote (e.g., provider, keys, region).                           | None          |
| `RCLONE_CONFIG_DESTINATION_*`  | ✅       | Configuration for the destination remote (e.g., provider, keys, region).                      | None          |

---

### **Examples of TIME_ZONE**

| Time Zone         | Example Value      |
|-------------------|--------------------|
| UTC               | `UTC`             |
| Asia/Kolkata      | `Asia/Kolkata`    |
| America/New_York  | `America/New_York`|

---

## **Logs**

- **File Logs**: Persistent logs are saved in `/var/log/copy.log` inside the container.  
- **Real-Time Logs**: Monitor logs in real-time via Docker:  

```bash
docker logs -f <container-name>
```

---

## **Advanced Use Case**

#### **Scenario**  
Copy data from an AWS S3 bucket to a DigitalOcean Space every hour with optimized Rclone options.  

#### **Environment Variables**  
```bash
BACKUP_CRON="0 * * * *"
RCLONE_SOURCE="s3:my-source-bucket"
RCLONE_DESTINATION="do:my-destination-bucket"
RCLONE_OPTIONS="--progress --fast-list --transfers=32 --checkers=64 --checksum"
```

#### **Command**  
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