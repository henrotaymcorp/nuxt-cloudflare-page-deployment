# Pages project managing project source
locals {
  production_branch = "main"
  github_organization = "deegitalbe"
}

resource "cloudflare_pages_project" "app" {
  account_id = data.doppler_secrets.ci_commons.map.CLOUDFLARE_ACCOUNT_ID
  name = var.TRUSTUP_APP_KEY
  production_branch = local.production_branch
  source {
    type = "github"
    config {
      owner                         = local.github_organization
      repo_name                     = var.TRUSTUP_APP_KEY
      production_branch             = local.production_branch
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "custom"
      preview_branch_includes       = ["release/*", "dev/*"]
      preview_branch_excludes       = [local.production_branch]
    }
  }
  build_config {
    build_command       = "yarn generate"
    destination_dir     = ".output/public"
  }
  deployment_configs {
    preview {
      secrets = merge({ NODE_VERSION: data.doppler_secrets.ci_commons.map.CLOUDFLARE_DEPLOYMENT_NODE_VERSION }, data.doppler_secrets.app_staging.map, data.doppler_secrets.app_commons_staging.map)
    }
    production {
      secrets = merge({ NODE_VERSION: data.doppler_secrets.ci_commons.map.CLOUDFLARE_DEPLOYMENT_NODE_VERSION }, data.doppler_secrets.app_production.map, data.doppler_secrets.app_commons_production.map)
    }
  }
}
