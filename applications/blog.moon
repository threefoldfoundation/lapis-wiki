lapis = require "lapis"

class BlogApp extends lapis.Application
    @enable "etlua"

    "/blog": =>
        return render: "blog.index", layout: false
