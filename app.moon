lapis = require "lapis"


class extends lapis.Application
    @enable "etlua"
    @include "applications.wiki", path: "/wiki", name: "wiki_"

    [index: "/"]: =>
        render: "home"
