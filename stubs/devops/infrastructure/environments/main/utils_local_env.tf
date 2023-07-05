locals {
  local_app_key = "${var.TRUSTUP_APP_KEY}-local"
}

locals {
  local_env = {
    NUXT_PUBLIC_TRUSTUP_APP_KEY=local.local_app_key
    NUXT_PUBLIC_APP_NAME=var.TRUSTUP_APP_KEY
    APP_PORT = lookup(data.doppler_secrets.local.map, "APP_PORT", data.doppler_secrets.ci_commons.map.LOCAL_APP_PORT)
    WEBSOCKET_PORT = lookup(data.doppler_secrets.local.map, "WEBSOCKET_PORT", data.doppler_secrets.ci_commons.map.LOCAL_VITE_PORT)
  }
}