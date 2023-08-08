locals {
  app_production_url = var.APP_ENVIRONMENT == "production" ? var.APP_URL : replace(var.APP_URL, "${var.TRUSTUP_APP_KEY_SUFFIX}-", "")
}

resource "cloudflare_pages_domain" "app_production" {
  account_id = data.doppler_secrets.ci_commons.map.CLOUDFLARE_ACCOUNT_ID
  project_name = cloudflare_pages_project.app.name
  domain = local.app_production_url
}

resource "cloudflare_record" "app_production" {
  zone_id = lookup(data.doppler_secrets.ci_commons.map, var.CLOUDFLARE_ZONE_SECRET, data.doppler_secrets.ci_commons.map.CLOUDFLARE_DNS_ZONE_TRUSTUP_IO)
  name = cloudflare_pages_domain.app_production.domain
  value = cloudflare_pages_project.app.subdomain
  type = "CNAME"
  proxied = true
}

resource "cloudflare_pages_domain" "app_staging" {
  account_id = data.doppler_secrets.ci_commons.map.CLOUDFLARE_ACCOUNT_ID
  project_name = cloudflare_pages_project.app.name
  domain = "staging-${local.app_production_url}"
}

resource "cloudflare_record" "app_staging" {
  zone_id = lookup(data.doppler_secrets.ci_commons.map, var.CLOUDFLARE_ZONE_SECRET, data.doppler_secrets.ci_commons.map.CLOUDFLARE_DNS_ZONE_TRUSTUP_IO)
  name = cloudflare_pages_domain.app_staging.domain
  value = "staging.${cloudflare_pages_project.app.subdomain}"
  type = "CNAME"
  proxied = true
}

