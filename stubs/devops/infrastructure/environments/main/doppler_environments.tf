resource "doppler_environment" "local" {
  name = "local"
  slug = "local"
  project = doppler_project.app.name
}

resource "doppler_environment" "staging" {
  depends_on = [ doppler_environment.local ]
  name = "staging"
  slug = "staging"
  project = doppler_project.app.name
}

resource "doppler_environment" "production" {
  depends_on = [ doppler_environment.staging ]
  name = "production"
  slug = "production"
  project = doppler_project.app.name
}
