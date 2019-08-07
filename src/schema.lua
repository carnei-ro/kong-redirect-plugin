return {
    fields = {
        redirect_http_code = { type = "number", default = 302, required = true },
        http_to_https = { type = "boolean", default = false, required = true },
        include_path = { type = "boolean", default = true, required = true },
        trim_trailing_slash = { type = "boolean", default = false, required = true },
        location = { type = "string", default = "http://localhost", required = true },
    }
}
