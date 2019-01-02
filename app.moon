lapis = require "lapis"
import get_redis from require "lapis.redis"


class extends lapis.Application
    @enable "etlua"

    [index: "/wiki(/index)"]: =>
        redirect_to: "/wiki/foundation"

    [docsite: "/wiki/:doc_site(/*)"]: =>
        redis = get_redis!
        @name = @params.doc_site
        file = @params.splat

        if file == nil
            -- If no params after `/wiki/:doc_site`, this means we are in the home of the wiki and need to load index
            return render: "wiki.index"

        file_name, file_ext = string.match(file, "(.*)%.(.*)")
        response, err = redis\hget("docsites:#{@params.doc_site}", "#{file_ext}:#{file_name}")

        if err
            return status:500

        if response == ngx.null
            return "** File not found #{file} **", layout: false, status: 404

        if file_ext == "md"
            return response, layout: false
