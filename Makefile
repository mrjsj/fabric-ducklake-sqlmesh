
include .env
export $(shell sed 's/=.*//' .env)


.PHONY: run plan

plan:
	sqlmesh plan

print-env:
	@printenv

azcopy-login:
	@export AZCOPY_SPA_CLIENT_SECRET=${AZURE_CLIENT_SECRET} && \
	azcopy login --service-principal --application-id ${AZURE_CLIENT_ID} --tenant-id ${AZURE_TENANT_ID}

azcopy-remove:
	azcopy \
		remove https://onelake.blob.fabric.microsoft.com/${FABRIC_WORKSPACE_NAME}/${FABRIC_LAKEHOUSE_NAME}.Lakehouse/Files/${FABRIC_SQLMESH_CODE_PATH} \
		--recursive=true \
		--trusted-microsoft-suffixes onelake.blob.fabric.microsoft.com

azcopy-upload:
	mkdir -p .azcopy_tmp && \
    git ls-files -z | xargs -0 -I{} cp --parents -r "{}" .azcopy_tmp && \
	azcopy \
		copy ".azcopy_tmp/*" "https://onelake.blob.fabric.microsoft.com/${FABRIC_WORKSPACE_NAME}/${FABRIC_LAKEHOUSE_NAME}.Lakehouse/Files/${FABRIC_SQLMESH_CODE_PATH}/" \
		--recursive=true \
		--trusted-microsoft-suffixes onelake.blob.fabric.microsoft.com && \
	rm -rf .azcopy_tmp
