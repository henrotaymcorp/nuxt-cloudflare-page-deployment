provider "doppler" {
  doppler_token = var.DOPPLER_ACCESS_TOKEN_USER
}

data "doppler_secrets" "ci_commons" {
  project = "trustup-io-ci-commons"
  config = "github"
}

data "doppler_secrets" "app_commons_production" {
  project = "trustup-io-app-commons"
  config = "production"
}

data "doppler_secrets" "app_commons_staging" {
  project = "trustup-io-app-commons"
  config = "staging"
}

data "doppler_secrets" "app_production" {
  project = var.TRUSTUP_APP_KEY
  config = "production"
}

data "doppler_secrets" "app_staging" {
  project = var.TRUSTUP_APP_KEY
  config = "staging"
}

provider "cloudflare" {
  api_key = data.doppler_secrets.ci_commons.map.CLOUDFLARE_API_TOKEN
  email = data.doppler_secrets.ci_commons.map.CLOUDFLARE_API_EMAIL
}
