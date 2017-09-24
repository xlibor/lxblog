
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()
local lh = lx.h
local redirect, back, abort, route = lh.kit()
local auth, config = lh.auth, lh.config

function _M:ctor(userDoer)

    self.userDoer = new 'userDoer'
    self:setBar('guest')
end

function _M:showRegForm(c)

    c:view('auth.reg')
end

function _M:reg(c)

    local request = c.req

    self:validate(request, {
        name = 'required|regex:[a-zA-Z-_]+|max:16|min:3|unique:users',
        email = 'required|email|max:255|unique:users',
        password = 'required|min:6|confirmed'
    }, {
        ['name.regex'] = "Username can only contains letter,number or -,_"
    })

    local name = request.name
    if str.amount(name, '_') > 1 or str.amount(name, '%-') > 1 then

        return back():withInput():withErrors("name's '-' and '_' max count is 1.")
    end
    auth():login(self:create(request.all))
    self.userDoer:clearCache()
    
    return redirect():route('post.index')
end

function _M.__:create(data)

    return new(User):create({
        name = data.name,
        email = data.email,
        password = Hash.make(data.password),
        avatar = config('app.avatar')
    })
end

return _M

