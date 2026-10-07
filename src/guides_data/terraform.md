# 🌍 Terraform for Dummies: The No-Panic Manual

> **One sentence summary:** Terraform is an Infrastructure-as-Code (IaC) tool that lets you define cloud resources (S3, VPCs, databases, servers) in code files instead of manually clicking buttons in the AWS or GCP console.

---

## 🧠 The 3 Golden Concepts

1. **Declarative State**: You define the *target end-state* (e.g. "I want 1 Postgres database with 50 GB storage"), and Terraform calculates the delta between what exists now and what you want.
2. **State File (`terraform.tfstate`)**: Terraform's memory bank. It maps your code definitions to real cloud IDs. If you delete or corrupt this file, Terraform has no idea what it owns. Always store it in a remote backend (S3 bucket or Terraform Cloud).
3. **Plan vs Apply**: Never run blindly. `plan` is the preview dry-run (tells you what will be created `+`, updated `~`, or destroyed `-`). `apply` physically executes the changes on the cloud provider.

---

## ⚡ The Daily 80/20 Workflow

```bash
# 1. Initialize provider plugins and remote backend (run first)
terraform init

# 2. Format your files nicely
terraform fmt

# 3. Dry-run preview: See what will happen without touching anything
terraform plan

# 4. Execute the plan (prompts for interactive confirmation)
terraform apply

# 5. Targeted apply (only touch one specific resource)
terraform apply -target=aws_s3_bucket.user_uploads

# 6. Destroy everything (caution!)
terraform destroy
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Committing State or Secrets to Git**:
  * *Disaster:* State files often contain database passwords, API keys, and sensitive tokens in plaintext.
  * *Fix:* Add `*.tfstate`, `*.tfstate.backup`, and `.terraform/` to `.gitignore`.
* **Footgun: State Drift**:
  * *What happens:* Someone manually clicks and deletes an EC2 instance in the AWS console.
  * *Fix:* Run `terraform refresh` or `terraform plan` to reconcile differences between reality and code.
* **Footgun: Accidental Resource Destruction**:
  * *Fix:* Always inspect the plan for red minus signs (`- destroy`). Add `lifecycle { prevent_destroy = true }` on production databases.
