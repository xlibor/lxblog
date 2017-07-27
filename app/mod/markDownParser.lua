
local lx, _M, mt = oo{
    _cls_ = ''
}

local app, lf, tb, str, new = lx.kit()

function _M:new()

    local this = {
        parseDown = new('parseDown'),
        htmlConverter = nil
    }
    
    return oo(this, mt)
end

function _M:html2md(html)

    return self.htmlConverter:convert(html)
end

function _M:parse(markdown, clean)

    clean = lf.needTrue(clean)
    local convertedHtml = self.parseDown:text(markdown)
    -- if clean then
    --     convertedHtml = clean(convertedHtml, 'user_comment_content')
    -- end
    
    return convertedHtml
end

return _M

