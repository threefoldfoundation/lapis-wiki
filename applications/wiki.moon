lapis = require "lapis"
lfs = require "lfs"
util = require "lapis.util"


class WikiApp extends lapis.Application
    @path: "/wiki"
    @name: "wiki_"
    @enable "etlua"

    [index: "(index)"]: =>
        -- redirect_to: @url_for("wiki_doc_site"), "foundation"
        redirect_to: "/wiki/foundation"

    [doc_site: "/:doc_site(/*)"]: =>
        @name = @params.doc_site
        file = @params.splat

        if file == nil
            -- If no params after `/wiki/:doc_site`, this means we are in the home of the wiki and need to load index
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
            return render: "wiki.index"
        if @req.headers['x-forwarded-proto'] == "https"
            @req.parsed_url.scheme = "http"
        redirect_to: "/wiki_static/"..@name.."/".. string.lower(file)
