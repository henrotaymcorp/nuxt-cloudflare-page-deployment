provider "doppler" {
  doppler_token = var.DOPPLER_ACCESS_TOKEN_USER
}

data "doppler_secrets" "ci_commons" {
  project = "trustup-io-ci-commons"
  config = "github"
}

data "doppler_secrets" "local" {
  project = doppler_project.app.name
  config = doppler_environment.local.slug
}