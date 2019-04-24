lapis = require "lapis"
lfs = require "lfs"
util = require "lapis.util"
os = require("os")

class WikiApp extends lapis.Application
    @enable "etlua"

    [doc_site: "/(*)"]: =>
        @name = ngx.var.name
        req = @req.parsed_url
        file = @params.splat

        if file == nil
            -- If no params after `/`, this means we are in the home of the wiki and need to load index
            root = "/sandbox/var/docsites/" .. @name
            dirs = {root}
            all_pages = {}
            for _, dir in pairs dirs
                for entity in lfs.dir(dir) do
                    if entity ~= "." and entity ~= ".." then
                        full_path = dir .. "/" .. entity
                        mode = lfs.attributes(full_path, "mode")
                        if mode == "file" and string.sub(entity, -3) == ".md"
                            page, _ = string.gsub(full_path, root .. "/" , "")
                            all_pages[#all_pages + 1] = page
                        elseif mode=="directory"
                            dirs[#dirs + 1] = full_path
            @all_pages = util.to_json(all_pages)
            scheme = "ws"
            @url = scheme .. "://" .. req.host
            if req.port
                @url = @url .. ":" .. req.port
            return render: "wiki.index", layout: false
        if @req.headers['x-forwarded-proto'] == "https"
            @req.parsed_url.scheme = "https"
        if string.sub(file, -3) == ".md"
            file = string.lower(file)

        redirect_to: "/docsites/"..@name.."/".. file
