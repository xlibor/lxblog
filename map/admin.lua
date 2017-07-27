
return function(route)

	route:get('/', {use = 'admin@index', as = 'admin.index'})
	route:get('/settings', {use = 'admin@settings', as = 'admin.settings'})
	route:post('/settings', {
		use = 'admin@saveSettings', as = 'admin.save-settings'})
	route:post('/upload/image', {
		use = 'image@uploadImage', as = 'upload.image'})
	route:post('/delete/file', {
		use = 'file@deleteFile', as = 'delete.file'})
	route:post('/upload/file', {
		use = 'file@uploadFile', as = 'upload.file'})

	route:add('/posts', {use = 'admin@posts', as = 'admin.posts'})
	route:get('/failed-jobs', {
		use = 'admin@failedJobs', as = 'admin.failed-jobs'})
	route:get('/comments', {
		use = 'admin@comments', as = 'admin.comments'})
	route:get('/tags', {use = 'admin@tags', as = 'admin.tags'})
	route:get('/users', {use = 'admin@users', as = 'admin.users'})
	route:get('/pages', {use = 'admin@pages', as = 'admin.pages'})
	route:get('/categories', {
		use = 'admin@categories', as = 'admin.categories'})
	route:get('/images', {use = 'image@images', as = 'admin.images'})
	route:get('/files', {use = 'file@files', as = 'admin.files'})
	route:get('/ips', {use = 'admin@ips', as = 'admin.ips'})

	route:post('/comment/{comment}/restore', {
		use = 'comment@restore', as = 'comment.restore'})

	route:post('/post/{post}/restore', {
		use = 'post@restore', as = 'post.restore'})
	route:get('/post/{slug}/preview', {
		use = 'post@preview', as = 'post.preview'})
	route:post('/post/{post}/publish', {
		use = 'post@publish', as = 'post.publish'})
	route:get('/post/{post}/download', {
		use = 'post@download', as = 'post.download'})
	route:post('/post/{post}/config', {
		use = 'post@updateConfig', as = 'post.config'})

	route:post('/tag/{tag}/delete', {use = 'tag@destroy', as = 'tag.destroy'})
	route:post('/tag', {use = 'tag@store', as = 'tag.store'})

	route:resource('post', 'post', {except = {'show', 'index'}})
	route:resource('category', 'category',
		{except = {'index', 'show', 'create'}})
	route:resource('page', 'page', {except = {'show', 'index'}})

	route:post('/ip/{ip}/toggle', {
		use = 'ip@toggleBlock', as = 'ip.block'})
	route:post('/ip/{ip}/delete', {use = 'ip@destroy', as = 'ip.delete'})

	route:post('/failed-jobs/flush', {
		use = 'admin@flushFailedJobs', as = 'admin.failed-jobs.flush'})
end

