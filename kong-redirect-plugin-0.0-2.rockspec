package = "kong-redirect-plugin"
version = "0.0-2"

source = {
 url    = "git@github.com:carnei-ro/kong-redirect-plugin.git",
 branch = "master"
}

description = {
  summary = "redirect plugin",
}

dependencies = {
  "lua ~> 5.1"
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.kong-redirect-plugin.handler"] = "src/handler.lua",
    ["kong.plugins.kong-redirect-plugin.schema"] = "src/schema.lua",
  }
}