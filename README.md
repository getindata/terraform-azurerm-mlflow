# Terraform Module Template


> **Warning**:
> This is a template document. Remember to **remove** all text in _italics_ and **update** Module name, Repo name and links/badges to the acual name of your GitHub repository/module!!!

![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

<!--- Replace repository name -->
![License](https://badgen.net/github/license/getindata/terraform-module-template/)
![Release](https://badgen.net/github/release/getindata/terraform-module-template/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

_Brief Description of MODULE:_

* _What it does_
* _What techonlogies it uses_

## USAGE

_Example usage of the module - terraform code snippet_

```terraform
```

## NOTES

_Additional information that should be made public, for ex. how to solve known issues, additional descriptions/suggestions_

<!-- BEGIN_TF_DOCS -->
## EXAMPLES
```hcl
data "azurerm_resource_group" "this" {
  name = "my-resource-group"
}

module "azure_mlfow" {
  source  = "../.."
  context = module.this.context

  resource_group = data.azurerm_resource_group.this.name

  #  auth = {
  #    type = "google"
  #    client_secret = ""
  #    client_id = ""
  #  }

  auth = {
    type          = "azureActiveDirectory"
    client_secret = ""
    client_id     = ""
    azureActiveDirectory = {
      tenant_id = ""
    }
  }
}
```





## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_auth"></a> [auth](#input\_auth) | OAuth2.0 provider configuration for MLflow app instance. Supported types: azureActiveDirectory, google | <pre>object({<br>    type          = string<br>    client_id     = string<br>    client_secret = string<br>    azureActiveDirectory = optional(object({<br>      tenant_id = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Container App CPU requirements | `number` | `0.75` | no |
| <a name="input_db_admin_username"></a> [db\_admin\_username](#input\_db\_admin\_username) | Database Server root username | `string` | `"mlflow_root"` | no |
| <a name="input_db_backup_type"></a> [db\_backup\_type](#input\_db\_backup\_type) | Storage account type used to store backups for this database. One of: Geo, GeoZone, Local, Zone | `string` | `"Local"` | no |
| <a name="input_db_max_size_gb"></a> [db\_max\_size\_gb](#input\_db\_max\_size\_gb) | Max database size in GB | `number` | `4` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Location for all of the resources. Falls back to the Resource Group's default. | `string` | `null` | no |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | Max number of Container App replicas | `number` | `1` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Container App memory requirements | `string` | `"1.5Gi"` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | Min number of Container App replicas | `number` | `0` | no |
| <a name="input_mlflow_docker_image"></a> [mlflow\_docker\_image](#input\_mlflow\_docker\_image) | MLflow docker image. See https://github.com/getindata/mlflow-docker | `string` | `"marrrcin/mlflow-azure:latest"` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource Group name | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_storage_sku"></a> [storage\_sku](#input\_storage\_sku) | Azure Storage Account SKU. See https://docs.microsoft.com/en-us/rest/api/storagerp/srp_sku_types | `string` | `"Standard_GRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | getindata/storage-account/azurerm | 1.1.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mlflow_tracking_uri"></a> [mlflow\_tracking\_uri](#output\_mlflow\_tracking\_uri) | Link to deployed MLflow instance |
| <a name="output_storage_connection_string"></a> [storage\_connection\_string](#output\_storage\_connection\_string) | Connection string to MLflow's blob storage account |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 0.4.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.17.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.3.2 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | 0.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.17.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.3.2 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.managed_environment](https://registry.terraform.io/providers/Azure/azapi/0.4.0/docs/resources/resource) | resource |
| [azapi_resource.mlflow_app](https://registry.terraform.io/providers/Azure/azapi/0.4.0/docs/resources/resource) | resource |
| [azapi_resource.mlflow_app_auth](https://registry.terraform.io/providers/Azure/azapi/0.4.0/docs/resources/resource) | resource |
| [azurerm_log_analytics_workspace.log_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_mssql_database.mlflow_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_firewall_rule.mlflow_db_firewall_allow_internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.mlflow_db_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [random_id.unique_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<a href="https://github.com/getindata/terraform-azurerm-mlflow/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-azurerm-mlflow" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
