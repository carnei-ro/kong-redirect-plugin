
local BasePlugin = require "kong.plugins.base_plugin"

local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")

local plugin = BasePlugin:extend()

function plugin:new()
    plugin.super.new(self, plugin_name)
end

function plugin:access(conf)
    plugin.super.access(self)

    local forwarded_host = ngx.var.http_x_forwarded_host or ngx.var.host
    local location = conf['http_to_https'] and ("https://" .. forwarded_host) or conf['location']
    local request_uri = conf['trim_trailing_slash'] and ngx.var.request_uri:gsub('(.)%/$', '%1') or ngx.var.request_uri
    local request_uri = (conf['trim_trailing_slash'] and (request_uri=='/')) and '' or request_uri

    location = conf['include_path'] and (location .. request_uri) or location

    ngx.header["Location"] = location
    return kong.response.exit(conf['redirect_http_code'])
    
end

plugin.PRIORITY = 1100
plugin.VERSION = "0.0-1"

return plugin
