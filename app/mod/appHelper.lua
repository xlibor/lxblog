
local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str = lx.kit()

function _M.isAdmin(user)
 
    return user ~= nil and user:__is(User) and user.id == 1
end

function _M.isAdminById(userId)

    return userId == 1
end

function _M.getAdminUser()

    return new(User):findOrFail(1)
end

function _M.getMilliseconds()

    return round(microtime(true) * 1000)
end

function _M.getUrlEndWithSlash(url)

    if not str.endsWith(url, '/') then
        
        return url .. '/'
    end
    
    return url
end

function _M.getUrlByFileName(fileName)

    local qiniu_domain = app:conf('filesystems.disks.qiniu.domains.https')
    if qiniu_domain then
        qiniu_domain = _M.getUrlEndWithSlash(qiniu_domain)
     else 
        qiniu_domain = app:conf('filesystems.disks.qiniu.domains.default')
        qiniu_domain = getUrlEndWithSlash(qiniu_domain)
    end
    
    return qiniu_domain .. fileName
end

function _M.processImageViewUrl(rawImageUrl, width, height, mode)

    mode = mode or 1
    local para = '?imageView2/' .. mode
    if width then
        para = para .. '/w/' .. width
    end
    if height then
        para = para .. '/h/' .. height
    end
    
    -- return rawImageUrl .. para
    return '/img/avatar.png'
end

function _M.getImageViewUrl(key, width, height, mode)

    mode = mode or 1
    
    return _M.processImageViewUrl(_M.getUrlByFileName(key), width, height, mode)
end

function _M.formatBytes(size, precision)

    precision = precision or 2
    local suffixes
    local base
    if size > 0 then
        size = tonumber(size)
        base = log(size) / log(1024)
        suffixes = {' bytes', ' KB', ' MB', ' GB', ' TB'}
        
        return round(pow(1024, base - floor(base)), precision) .. suffixes[floor(base)]
     else 
        
        return size
    end
end

function _M.getMentionedUsers(content)

    local atlist_tmp = str.rematch(content,
        [[(\S*)\@([^\r\n\s]*)"]])
    local usernames = {}

    if not atlist_tmp then
        return {}
    end
    for k, v in pairs(atlist_tmp[2]) do
        if not (atlist_tmp[1][k] or str.len(v) > 25) then
            tapd(usernames, v)
        end
    end
    local users = new(User):whereIn('name', tb.unique(usernames)):get()
    
    return users
end

function _M.httpUrl(url)

    if url == nil or url == '' then
        
        return ''
    end
    if not str.startWith(url, 'http') then
        
        return 'http://' .. url
    end
    
    return url
end

return _M

