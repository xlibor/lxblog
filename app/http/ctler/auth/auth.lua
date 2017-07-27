
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str = lx.kit()

function _M:new()

    local this = {
        userDoer = nil
    }
    
    return oo(this, mt)
end

function _M:ctor(userDoer)

    self.userDoer = userDoer
end

function _M:redirectToGithub()

    return Socialite.driver('github'):redirect()
end

function _M:bindGithub(currentUser, githubData)

    currentUser.github_id = githubData['github_id']
    currentUser.github_name = githubData['name']
    if config('app.avatar') == currentUser.avatar then
        currentUser.avatar = githubData['avatar']
    end
    local meta = currentUser.meta
    meta['github'] = githubData['url']
    currentUser.meta = meta
    self.userDoer:clearAllCache()
    
    return currentUser:save()
end

function _M:store(request)

    if not session():has('githubData') then
        
        return redirect('login')
    end
    local name = request:get('name')
    local email = request:get('email')
    self:validate(request, {name = 'required|regex:/^[a-zA-Z-_]+$/u|max:16|min:3|unique:users', email = 'required|email|max:255|unique:users', password = 'required|min:6|confirmed'}, {['name.regex'] = "Username can only contains letter,number or -,_", ['name.unique'] = "Username  '{name}'  has been registered,if it is you,then you can login to bind your github account", ['email.unique'] = "Email  '{email}'  has been registered,if it is you,then you can login to bind your github account"})
    if mb_substr_count(request:get('name'), '_') > 1 or mb_substr_count(request:get('name'), '-') > 1 then
        
        return back():withInput():withErrors("name's '-' and '_' max count is 1.")
    end
    local githubData = session('githubData')
    local user = new('user' ,)
    user.name = name
    user.email = githubData['email']
    user.avatar = config('app.avatar')
    user.register_from = 'github'
    user.password = bcrypt(request:get('password'))
    if self:bindGithub(user, githubData) then
        auth():loginUsingId(user.id)
        session():forget('githubData')
        
        return redirect():route('post.index'):with('success', '使用Github注册成功')
     else 
        session():forget('githubData')
        
        return redirect():route('post.index'):with('success', '使用Github注册失败')
    end
end

function _M:registerFromGithub()

    if not session():has('githubData') then
        
        return redirect('login')
    end
    local githubData = tb.merge(session('githubData'), request():old())
    
    return view('auth.github_register', compact('githubData'))
end

function _M:handleGithubCallback()

    local currentUser
    local githubUser = Socialite.driver('github'):user()
    local user = User.where('github_id', githubUser.id):first()
    
    if auth():check() then
        currentUser = auth():user()
        
        if currentUser.github_id then
            
            if currentUser.github_id == githubUser.id then
                
                return redirect():route('post.index')
             else 
                
                return redirect():route('post.index'):withErrors('Sorry,you have bind a different github account!')
            end
         else 
            
            if user then
                
                return redirect():route('post.index'):withErrors('Sorry,this github account has been bind to another account,is that you?')
             else 
                if self:bindGithub(currentUser, self:getDataFromGithubUser(githubUser)) then
                    
                    return redirect():route('post.index'):with('success', '绑定 Github 成功')
                end
                
                return redirect():route('post.index'):withErrors('绑定 Github 失败')
            end
        end
     else 
        
        if user then
            auth():loginUsingId(user.id)
            
            return redirect():route('post.index'):with('success', '登录成功')
         else 
            githubData = self:getDataFromGithubUser(githubUser)
            session():put('githubData', githubData)
            
            return redirect():route('github.register')
        end
    end
end

function _M.__:getDataFromGithubUser(githubUser)

    githubData['github_id'] = githubUser.id
    githubData['email'] = githubUser.email
    githubData['avatar'] = githubUser.avatar
    githubData['name'] = githubUser.nickname
    githubData['url'] = githubUser.user['html_url']
    
    return githubData
end

return _M

