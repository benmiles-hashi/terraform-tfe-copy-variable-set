locals {
    variables = {for idx, item in  data.tfe_variables.sourcevars.variables  : 
        format("%s-%s", "vars", item.name) => {
            category = item.category
            name = item.name
            hcl = item.hcl
            sensitive = item.sensitive
            value = item.value
        }
    }
}

data "tfe_variable_set" "vssource" {
  name         = var.vs_source
  organization = var.orgname
}

data "tfe_variables" "sourcevars" {
    variable_set_id = data.tfe_variable_set.vssource.id
}

resource "tfe_variable_set" "vscopy" {
  name         = var.vs_target
  description  = "Copy of ${var.vs_source}"
  global       = false
  organization = var.orgname
}

resource "tfe_variable" "variable" {
 for_each = local.variables
  variable_set_id = tfe_variable_set.vscopy.id
  category = each.value.category
  key = each.value.name
  sensitive = each.value.sensitive
  hcl = each.value.hcl
  value = each.value.value
}

resource "tfe_workspace_variable_set" "workspace" {
  for_each = data.tfe_variable_set.vssource.workspace_ids
    variable_set_id = tfe_variable_set.vscopy.id
    workspace_id = each.value
}