

summary: redirect plugin

http_to_https if true, ignore field config.location  

Default values:  
```
---
_format_version: "1.1"
plugins:
  - name: kong-redirect-plugin
    config:
      redirect_http_code: 302
      http_to_https: false
      include_path: true
      trim_trailing_slash: false
      location: http://localhost
```
