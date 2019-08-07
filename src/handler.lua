
local BasePlugin = require "kong.plugins.base_plugin"

local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")

local plugin = BasePlugin:extend()

function plugin:new()
    plugin.super.new(self, plugin_name)
end

function plugin:access(conf)
    plugin.super.access(self)

    local req_path       = kong.request.get_path()
    local req_qs         = kong.request.get_raw_query()
    local forwarded_host = ngx.var.http_x_forwarded_host or ngx.var.host
    local location       = conf['http_to_https'] and ("https://" .. forwarded_host) or conf['location']
    local request_uri    = conf['trim_trailing_slash'] and req_path:gsub('(.)%/$', '%1') or req_path
    request_uri          = (conf['trim_trailing_slash'] and (request_uri=='/')) and '' or request_uri
    location             = conf['include_path'] and (location .. request_uri) or location
    ngx.log(ngx.ERR, "req_qs: '" .. req_qs .."'")
    if conf['include_querystring'] and req_qs ~= '' then
        location         = location .. '?' .. req_qs
    end
    
    ngx.header["Location"] = location
    return kong.response.exit(conf['redirect_http_code'])
    
end

plugin.PRIORITY = 1100
plugin.VERSION = "0.0-2"

return plugin
