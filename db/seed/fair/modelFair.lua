
return function(fair)
    
    local lx = require('lxlib')
    local app, lf, tb, str, new = lx.kit()
    local use = lx.ns('.app.model')
    local User, Post, Category, Tag = use(
        'user', 'post', 'category', 'tag'
    )

    local rand = lf.rand

    fair:define(User, function(faker)
        
        return {
            name = faker:name(),
            email = faker:email(),
            password = Hash('123456'),
            remember_token = str.random(10)
        }
    end)

    fair:define(Post, function(faker)
        local html_content = str.join(faker:paragraphs(rand(7, 20)), "\n\n")
        
        return {
            title = faker:sentence(rand(5, 10)),
            content = html_content,
            html_content = html_content,
            slug = faker:slug(),
            published_at = faker:datetime(),
            description = faker:sentence(rand(5, 15)),
            status = 1
        }
    end)

    fair:define(Category, function(faker)
        
        return {name = str.random(7)}
    end)

    fair:define(Tag, function(faker)
        
        return {name = str.random(7)}
    end)

end

