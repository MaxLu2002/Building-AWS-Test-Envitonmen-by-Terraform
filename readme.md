# 架構圖 Architecture Design
![Architecture Design](./figures/Architecture_Design.png)

# 專案說明 Projecy Desctiption
** 中文版 **
本專案旨在使用 Terraform 在 AWS 上自動化部署一個包含 VPC、EC2、S3 及網路配置的完整架構。該架構主要設計為多可用區域 (Availability Zones) 的高可用環境，並可用於測試或開發環境。具體架構如下：

- **VPC**: 包含兩個可用區域 (Availability Zones)，每個可用區域內包含一個公共子網 (Public Subnet) 和一個私有子網 (Private Subnet)。
- **EC2 實例**: 每個可用區域內的公共子網中各部署一台 EC2 實例，用於接收外部流量，並且私有子網中也有 EC2 實例，用於內部服務處理。這些實例將利用 NAT Gateway 進行出站流量的控制，以確保私有子網中的 EC2 實例保持安全。
- **NAT Gateway**: 部署在公共子網中，允許私有子網中的 EC2 實例通過 NAT 出站訪問互聯網，並確保不會暴露在公網中。
- **Internet Gateway**: 用於連接 VPC 與互聯網，並允許部署在公共子網中的 EC2 實例進行外部連接。
- **S3 儲存桶**: 系統使用了多個 S3 儲存桶，這些儲存桶可以用來存儲應用程序數據、備份和靜態資源。
- **Instance Connect**: 透過 AWS Console 使用 Instance Connect 來連接 EC2 實例，進行管理和維護。

該架構適用於測試、開發和小型生產環境，並且透過標籤 (tags) 管理資源，便於成本控制和資源分類。

** English Version **
This project aims to automate the deployment of a complete architecture on AWS using Terraform, which includes VPC, EC2, S3, and network configurations. The architecture is primarily designed as a high-availability environment across multiple Availability Zones, suitable for testing or development purposes. The detailed architecture is as follows:

- **VPC**: The VPC includes two Availability Zones, each containing one Public Subnet and one Private Subnet.
- **EC2 Instances**: Each Availability Zone deploys an EC2 instance in the Public Subnet to handle external traffic, and another EC2 instance in the Private Subnet for internal service processing. These instances use a NAT Gateway for outbound traffic control to ensure the security of the EC2 instances in the Private Subnet.
- **NAT Gateway**: Deployed in the Public Subnet, it allows EC2 instances in the Private Subnet to access the internet through NAT, ensuring they are not exposed to the public internet.
- **Internet Gateway**: This connects the VPC to the internet and allows EC2 instances deployed in the Public Subnet to have external connectivity.
- **S3 Buckets**: The system uses multiple S3 buckets for storing application data, backups, and static resources.
- **Instance Connect**: AWS Console’s Instance Connect is used to connect to EC2 instances for management and maintenance.

This architecture is suitable for testing, development, and small-scale production environments. Resources are managed through tagging, which helps with cost control and resource classification.

# 使用步驟 Steps
** 中文版 **
## 1. 使用前配置
- **IAM 用戶與 AWS CLI 配置：**
  - 在 AWS 上建立一個帶有 `access key` 的 IAM user，該用戶應有足夠的權限管理 EC2、S3 和 VPC。
  - 下載並安裝 [AWS CLI](https://aws.amazon.com/cli/)。
  - 使用 `aws configure` 命令將 IAM user 的 profile 設置在本地環境中。

## 2. 修改 Terraform 配置檔案
進入專案目錄，並依照以下步驟設定 Terraform 配置檔案：

1. **進入 `_variable.tf` 檔案：**
   - 設定 `provider "aws"`，並輸入 AWS 的 `region`。
   - 輸入適合的標籤名稱（tag names）來協助資源管理。
   - 指定 S3 bucket 的名稱。

2. **檢查 EC2 的 AMI 設定：**
   - 確認會使用到的 AMI ID，這些 AMI 會根據你所選擇的 region 而不同。這一點非常重要，因為不同地區有不同的 AMI 可供選擇。
   - 在 `EC2.tf` 中確認每台 EC2 實例都配置了合適的 AMI ID。

## 3. 執行 Terraform 指令
在完成所有設定後，可以按照以下順序執行 Terraform 指令來部署架構：

1. **初始化 Terraform 環境：**
   ```bash
   terraform init
   ```
   該命令會下載並安裝 AWS Provider，並初始化 Terraform 環境。

2. **驗證配置：**
   ```bash
   terraform validate
   ```
   確認你的 Terraform 配置文件語法正確且無誤。

3. **計劃變更：**
   ```bash
   terraform plan
   ```
   該命令會生成變更計劃，幫助你確認哪些資源將會被創建或修改。

4. **應用變更：**
   ```bash
   terraform apply
   ```
   該命令會開始創建並部署所有 AWS 資源。運行後會提示輸入 `yes` 確認變更。

## 4. 測試完成後刪除資源
當測試結束後，為了避免不必要的資源消耗，你可以刪除所有已創建的資源：

```bash
terraform destroy
```
該命令會刪除所有由 Terraform 創建的資源，確保測試環境被完全移除。

** English Version **
## 1. Pre-Configuration
- **IAM User and AWS CLI Configuration:**
  - Create an IAM user with an `access key` in AWS, and ensure the user has sufficient permissions to manage EC2, S3, and VPC.
  - Download and install [AWS CLI](https://aws.amazon.com/cli/).
  - Use the `aws configure` command to set the IAM user's profile in your local environment.

## 2. Modify Terraform Configuration Files
Navigate to the project directory and follow these steps to configure the Terraform files:

1. **Edit the `_variable.tf` file:**
   - Set the `provider "aws"` and input the desired AWS `region`.
   - Input appropriate tag names to assist with resource management.
   - Specify the name of the S3 bucket.

2. **Check EC2 AMI Settings:**
   - Verify the AMI ID to be used, as these AMIs vary depending on the selected region. This step is crucial because different regions have different AMIs available.
   - Confirm that each EC2 instance in `EC2.tf` is configured with the correct AMI ID.

## 3. Execute Terraform Commands
After completing all the configurations, you can deploy the architecture by following these steps:

1. **Initialize the Terraform Environment:**
   ```bash
   terraform init
   ```
   This command will download and install the AWS Provider and initialize the Terraform environment.

2. **Validate the Configuration:**
   ```bash
   terraform validate
   ```
   This command checks that your Terraform configuration files are syntactically correct and valid.

3. **Plan the Changes:**
   ```bash
   terraform plan
   ```
   This command generates an execution plan to help you review the resources that will be created or modified.

4. **Apply the Changes:**
   ```bash
   terraform apply
   ```
   This command will start creating and deploying all AWS resources. You will be prompted to type `yes` to confirm the changes.

## 4. Clean Up After Testing
Once testing is complete, you can remove all created resources to avoid unnecessary costs:

```bash
terraform destroy
```
This command will delete all resources created by Terraform, ensuring the test environment is completely removed.
```

This version translates the content into English while preserving the technical instructions and flow.