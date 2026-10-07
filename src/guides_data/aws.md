# ☁️ AWS CLI for Dummies: The No-Panic Manual

> **One sentence summary:** The AWS CLI (`aws`) lets you interact with Amazon Web Services—most notably uploading/downloading files from S3 buckets and starting/stopping EC2 virtual machines without getting lost in the AWS console web interface.

---

## 🔑 Initial Setup & Profiles

```bash
# Configure your credentials:
aws configure
# Prompts for:
# AWS Access Key ID: [paste]
# AWS Secret Access Key: [paste]
# Default region name: us-east-1
# Default output format: json
```

### Working with Multiple Profiles
If you have work vs. personal accounts:
```bash
# Add a named profile:
aws configure --profile personal

# Run any command using that profile:
aws s3 ls --profile personal

# Or set it for your current terminal session:
export AWS_PROFILE=personal
```

---

## 🪣 Amazon S3: The 90% Use Case (Cloud Storage)

S3 is the most common reason developers touch the AWS CLI. Think of S3 like Google Drive or Dropbox for code and model weights.

### 1. Listing Buckets and Files
```bash
# List all your buckets:
aws s3 ls

# List files inside a specific bucket:
aws s3 ls s3://my-ai-bucket/models/
```

### 2. Uploading & Downloading Single Files
```bash
# Upload local file to S3:
aws s3 cp ./model.pth s3://my-ai-bucket/checkpoints/

# Download file from S3 to current folder:
aws s3 cp s3://my-ai-bucket/checkpoints/model.pth ./
```

### 3. The Magic `sync` Command (Syncing Entire Folders)
`aws s3 sync` compares your local folder with S3 and **only uploads new or modified files** (saving gigabytes of bandwidth):
```bash
# Sync local folder to S3:
aws s3 sync ./my-dataset s3://my-ai-bucket/dataset/

# Sync S3 down to your Mac:
aws s3 sync s3://my-ai-bucket/dataset/ ./my-dataset
```

---

## 🖥️ EC2 Instances (Stop Them Before They Bill You!)

```bash
# Check all running instances (clean summary):
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress]" \
  --output table

# Stop an instance (stops the per-hour compute charge immediately!):
aws ec2 stop-instances --instance-ids i-0123456789abcdef0

# Start it back up:
aws ec2 start-instances --instance-ids i-0123456789abcdef0
```

---

## 🚨 The Golden Rules of AWS Safety

1. **NEVER COMMIT ACCESS KEYS TO GITHUB:**
   * Automated bots scrape GitHub within 20 seconds of a commit. If an AWS Secret Key is pushed, your account will get hacked with cryptocurrency miners and incur thousands of dollars in bills.
   * AWS credentials live safely in `~/.aws/credentials`, **never** inside code files.
2. **Always stop EC2 instances when not using them:**
   * A GPU instance (`g5.xlarge`) costs ~$1.00/hour. If left on for a month, that's $720.
3. **Set up a Billing Alarm:**
   * In AWS Console -> Billing -> Budgets, set an alert at $10 to get an email immediately if costs start climbing.
