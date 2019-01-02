local config = require("lapis.config")
return config("development", function()
  return redis({
    host = "127.0.0.1",
    port = 6379
  })
end)
