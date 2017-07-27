
local lx, _M = oo{
	_cls_ = '',
	_ext_ = 'command'
}

local app, lf, tb, str, new = lx.kit()
local fs = lx.fs

function _M:run()

	self:test(); do return end

    local docsDir = lx.dir('tmp', 'app/docs')
    local files = fs.files(docsDir)
    local parseDown = new 'parseDown'

    for i, file in ipairs(files) do
    	if str.endsWith(file, '.md') then
    		local content = fs.get(file)
    		content = self:preFilter(content)
    		content = self:filter(content)
    		local newFile = str.gsub(file, 'app/docs', 'app/newdocs')
    		local title = self:getTitle(content)
    		local intro = self:getIntroduction(content)
    		local slug = str.gsub(fs.baseName(file), '.md', '')
    		slug = self:filter(slug)
			local mdStr = self:convertFile(content)
			if str.len(content) > 10 then
				local post = new(Post):create({
					title = title,
					category_id = 1,
					user_id = 1,
					status = 1,
					content = mdStr,
					html_content = parseDown:text(mdStr),
					description = str.len(intro) < 200 and instro or 'too longs',
					slug = 'lxlib-docs-' .. slug
				})
				post:save()
				echo(file)
			end
		end
    end
end

function _M:preFilter(content)

	local i = str.find(content, '## 译者署名', _, true)
	if i then
		content = str.sub(content,1, i -1)
	end

	if str.find(content, '```php') then
		content = str.gsub(content, '```php\n(.-)```', function(m, m1)
			local lines = str.split(m, '\n')
			for i, line in ipairs(lines) do
				lines[i] = '    ' .. line
			end

			return str.join(lines, '\n')
		end)
	end

	return content
end

function _M:getTitle(content)

	local title = str.rematch(content, [[^#\s*(.*)]])

	return title and title[1] or 'unknown'
end

function _M:getIntroduction(content)

	local intro = str.rematch(content,
		[[## 简介\n\n(.*)\n]]
	)

	return intro and intro[1] or 'unknown'
end

function _M:test()

	local code = [[
<?php
    $some = ['mysql' => [
        'read' => [
            'host' => '192.168.1.1',
        ],
        'write' => [
            'host' => '196.168.1.2'
        ],
        'driver'    => 'mysql',
        'database'  => 'database',
        'username'  => 'root',
        'password'  => '',
        'charset'   => 'utf8',
        'collation' => 'utf8_unicode_ci',
        'prefix'    => '',
    ]
    ];
]]
	local hc = new('net.http.client')
 	local resp = hc:post('http://phphub5.app:8888/trans', {
 		body = 'code=' .. lf.uriEncode(code)
 	})

 	if resp.statusCode == 200 then
 		body = resp.body
 		echo(body)
 	end
end

function _M:convertFile(content)

	local lines = self:parseLines(content)
	
	for i, line in ipairs(lines) do
		local vt = type(line)
		if vt == 'string' then
			line = self:filterPhpStyleName(line)
		elseif vt == 'table' then
			line = str.join(line, '\n')
			line = self:transCode(line)
		end
		lines[i] = line
	end

	local text = str.join(lines, '\n')
	text = self:filter(text)

	return text
end

function _M:filterPhpStyleName(content)

    local i,j = str.find(content, '`[%w\\$]+`')
    if i then
    	content = str.gsub(content, '`([%w\\]+)`', function(m)
	        local a = str.split(m, "\\")
	        for i, w in ipairs(a) do
	        	if str.allUpper(w) then
	        		w = str.lower(w)
	        	end
	        	if str.sub(w, 1, 1) == '$' then
	        		w = str.sub(w, 2)
	        	end
	            a[i] = str.camel(w)
	        end
	        m = str.join(a, ".")

	        return '`' .. m .. '`'
    	end)
    end

	return content
end

function _M:filter(text)

	text = str.replace(text, {
		laravel = 'lxlib', Laravel = 'lxlib',
		Php = 'lua', PHP = 'lua',
		Eloquent = 'orm', eloquent = 'orm',
		['php artisan'] = 'lx',
		migrate = 'shift',
		serviceProvider = 'box', ServiceProvider = 'box',
		Contract = 'bond', contract = 'bond',
		Middleware = 'bar', middleware = 'bar',
		Migration = 'shift', migration = 'shift',
		Illuminate = 'lxlib', illuminate = 'lxlib',
		['.blade.php'] = '.html',
		['/docs/{{version}}/'] = '/blog/lxlib-docs-',
		resources = 'res',
		Facade = 'face', facade = 'face',
		Attribute = 'Attr', attribute = 'attr',
		register = 'reg', Register = 'reg',
		toArray = 'toArr', 
	})

	return text
end

function _M:parseLines(content)

    local lines = str.split(content, "\n")

    local newLines = {}
    local last = 0
    local blocked = false
    local blockLines

    for i, line in ipairs(lines) do
        local s = str.rematch(line, [[^\s{4,4}([^\-\*>]+(.*))]])
        if not s then

            if (str.len(line) == 0 or line == '    ' or line == '    */')
            	and i - last == 1 then
                s = line
            end
        else
        	s = s[0]
        end

        if s then
            if i - last > 1 then
                blocked = false
            else
                blocked = true
            end
            last = i

        	if not blockLines then
        		blockLines = {}
        	end

        	tapd(blockLines, s)
        else
        	if blockLines then
        		tapd(newLines, blockLines)
        	end
        	blockLines = nil
        	tapd(newLines, line)
        end
    end

    if blockLines then
    	tapd(newLines, blockLines)
    end

    return newLines
end

function _M:transCode(code)

	local phpCode = code

 	local hc = new('net.http.client')

 	if not str.find(code, '<?php', _, true) then
 		code = str.gsub(code, '%s*use [^\n]+', '')
 		if str.find(code, 'function %w+%(') and
 			not str.find(code, 'class %w+') then
	 		code = 'class someClass extends someSuper {\n' .. code .. '\n}'
	 	end
	 	code = str.gsub(code, 'protected %$', '%$')
	 	code = '<?php \n' .. code .. ' ?>'
	else
		code = str.trim(code, ' ')
	end

 	local resp = hc:post('http://phphub5.app:8888/trans', {
 		body = 'code=' .. lf.uriEncode(code)
 	})
 	
 	if resp.statusCode == 200 then
 		body = resp.body
 		if str.has(body, 'Parse Error') then
 			-- echo(body, phpCode)
 			return phpCode
 		else
 			if str.find(body, 'someSuper') then
 				body = str.gsub(body, 'local lx,.*lx%.kit%(%)', '')
 				body = str.ltrim(body, '\n')
 			end
 			body = self:addIndent(body)
 			if not str.find(body, '_M:new') then
 				body = str.gsub(body, '_M, mt', '_M')
 			end
 		end

 		return body
 	end

end

function _M:addIndent(code)

	local lines = str.split(code, '\n')
	local newLines = {}
	for _, line in ipairs(lines) do
		line = '    ' .. line
		tapd(newLines, line)
	end

	return str.join(newLines, '\n')
end

return _M

