
local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str, new = lx.kit()

function _M:getConfig(key, defaultValue)

    local cfg = self('config')
    
    local config
    if cfg then
        config = cfg.config or {}
    end

    if not cfg or not config[key] or lf.isEmpty(config[key]) then
        
        return defaultValue
    end
    
    return cfg.config[key]
end

function _M:getBoolConfig(key, defaultValue)

    defaultValue = defaultValue or false
    local default = defaultValue and 'true' or 'false'
    
    return self:getConfig(key, default) == 'true'
end

function _M:getConfigKeys() end

function _M:saveConfig(array)

    local config
    if not self('config') then
        config = self:innerSetConfigKeys(new(Config), array)

        return self:config():save(config)
    end

    return self:innerSetConfigKeys(self('config'), array):save()
end

function _M.__:innerSetConfigKeys(configModel, array)

    local config = configModel.config

    for key, value in pairs(array) do
        if tb.inList(self:getConfigKeys(), key) then
            config[key] = value
        end
    end
    configModel.config = config
    
    return configModel
end

return _M

