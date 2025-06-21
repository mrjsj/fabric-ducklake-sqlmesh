# Sample Project: Microsoft Fabric Lakehouse + DuckDB DuckLake + SQLMesh

This sample project demonstrates how to combine [Microsoft Fabric Lakehouse](https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-overview), [DuckDB's DuckLake](https://duckdb.org/docs/extensions/ducklake.html) for storage, and [SQLMesh](https://sqlmesh.com/) for data orchestration.

## Prerequisites

- **Python**: 3.10 or newer
- **Azure CLI**: [Install instructions](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- **AzCopy**: [Install instructions](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10)

## DuckLake Table Synchronization

DuckLake tables (from your Postgres database) are synchronized as **Delta tables** in the Lakehouse `Tables` directory.  
This enables seamless consumption by Power BI reports using **Direct Lake** mode.

## Azure Resources Required

1. **Resource Group**  
   Create a resource group to contain all resources.

2. **Azure Key Vault**  
   Used to store secrets (service principal credentials, database passwords, etc).

3. **Azure Database for PostgreSQL Flexible Server**  
   Minimum tier is sufficient.

4. **Microsoft Fabric Workspace**  
   - Create a workspace.
   - Add a **schema-enabled Lakehouse**.

5. **Azure Service Principal**  
   - Create a service principal.
   - Assign it as a **Contributor** to the Fabric workspace.

## Setup Instructions

### 1. Clone the Repository

```sh
git clone https://github.com/mrjsj/fabric-ducklake-sqlmesh
```

### 2. Install Python Requirements

```sh
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 3. Configure Environment Variables

- Copy `.env.example` to `.env` and fill in all required values:

```sh
cp .env.example .env
# Edit .env with your editor of choice
```

### 4. Update Notebook Configuration

- Open `fabric/SQLMeshRunner.ipynb` and update the **Configuration** section:
  - Key vault, workspace, lakehouse, and database names
  - Ensure all secret names match those in your Key Vault

### 5. Set Up Secrets in Key Vault

- Add all secrets referenced in the notebook to your Azure Key Vault.

### 6. Upload the Notebook to Fabric

- Upload `fabric/SQLMeshRunner.ipynb` to your Fabric workspace.
- **Attach the Lakehouse as the default lakehouse** for the notebook.

### 7. Run the SQLMesh on your local code

```sh
make plan
```

### 8. Or to run SQLMesh in a Fabric Notebook 

First authenticate and Upload Code

#### Login to AzCopy

```sh
make azcopy-login
```

#### Upload Code (excluding .gitignore files)

```sh
make azcopy-upload
```

#### Run the Fabric Notebook

Open the Fabric Notebook in the specified workspace and click "Run all".

#### Remove Uploaded Files

```sh
make azcopy-remove
```

