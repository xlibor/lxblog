
return function(cmd)
    cmd:add('app/test', function()
        local lx = Lx()
        local new = lx.new
        echo('hello')
        local user = User.find(1)
        echo(user)
    end)
	cmd:add('cvtMd', 'convertMd@run')
end