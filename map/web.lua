
return function(route)
	
	route:get('/', {use = 'home@index', as = 'index'})
	
	route:get('/auth/github', {
		use = 'auth.auth@redirectToGithub', as = 'github.login'})
	route:get('/auth/github/callback', {
		use = 'auth.auth@handleGithubCallback', as = 'github.callback'})
	route:get('/github/register', {
		use = 'auth.auth@registerFromGithub', as = 'github.register'})
	route:post('/github/store', {
		use = 'auth.auth@store', as = 'github.store'})

	route:get('/projects', {use = 'home@projects', as = 'projects'})
	route:get('/search', {use = 'home@search', as = 'search'})
	route:get('/achieve', {use = 'home@achieve', as = 'achieve'})

	route:get('/blog', {use = 'post@index', as = 'post.index'})
	route:get('/blog/{slug}', {use = 'post@show', as = 'post.show'})

	route:get('/category/{name}', {
		use = 'category@show', as = 'category.show'})
	route:get('/category', {
		use = 'category@index', as = 'category.index'})

	route:get('/tag/{name}', {use = 'tag@show', as = 'tag.show'})
	route:get('/tag', {use = 'tag@index', as = 'tag.index'})

	route:get('/user/{name}', {use = 'user@show', as = 'user.show'})
	route:get('/notifications', {
		use = 'user@notifications', as = 'user.notifications'})
	route:patch('/user/upload/avatar', {
		use = 'user@uploadAvatar', as = 'user.upload.avatar'})
	route:patch('/user/upload/profile', {
		use = 'user@uploadProfile', as = 'user.upload.profile'})
	route:patch('/user/upload/info', {
		use = 'user@update', as = 'user.update.info'})

	route:get('/commentable/{commentable_id}/comments', {
		use = 'comment@show', as = 'comment.show'})
	route:resource('comment', 'comment', {
		only = {'store', 'destroy', 'edit', 'update'}})

	-- route:get('/comment/store', {
	-- 	use = 'comment@store', as = 'comment.store'})

	route:get('sitemap', 'generated@index')
	route:get('sitemap.xml', 'generated@index')

	route:get('feed.xml', 'generated@feed')

	route:get('/page/{name}', {use = 'page@show', as = 'page.show'})

end

