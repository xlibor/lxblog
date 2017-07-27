
local lx, _M, mt = oo{
    _cls_ = ''
}

local app, lf, tb, str = lx.kit()

function _M:new()

    local this = {
        content_original = nil,
        content_parsed = nil
    }
    
    return oo(this, mt)
end

function _M:replace()

    local place
    local search
    self.content_parsed = self.content_original
    for _, user in pairs(Ah.getMentionedUsers(self.content_original)) do
        search = '@' .. user.name
        place = '[' .. search .. '](' .. route('user.show', user.name) .. ')'
        self.content_parsed = str.replace(self.content_parsed, search, place)
    end
end

function _M:parse(content)
    
    self.content_original = content
    self:replace()
    
    return self.content_parsed
end

function _M:mentionUsers(comment, users, raw_content)

    for _, user in pairs(users) do
        if not isAdmin(users) then
            user:notify(new('mentionedInComment' ,comment, raw_content))
        end
    end
end

return _M

