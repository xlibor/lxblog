
return function(route)
	
	route:add('test', function(c)
		echo(c.url)
	end)
end