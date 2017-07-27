@extends('admin.layouts.app')
@section('css')
    <link href="//cdn.bootcss.com/simplemde/1.11.2/simplemde.min.css" rel="stylesheet">
@endsection
@section('content')
    <div id="upload-img-url" data-upload-img-url="{{ route('upload.image') }}" style="display: none"></div>
    <div class="row">
        <div class="col-md-12">
            <div class="widget widget-default">
                <div class="widget-header">
                    <h6><i class="fa fa-file fa-fw"></i>创建页面</h6>
                </div>
                <div class="widget-body edit-form">
                    <form role="form" class="form-horizontal" action="{{ route('page.store') }}" method="post">

                        @include('admin.page.form-content')

                        <div class="form-group">
                            <div class="col-md-8 col-md-offset-4">
                                <button type="submit" class="btn btn-primary">
                                    创建
                                </button>
                            </div>
                        </div>

                    </form>
                </div>

            </div>
        </div>
    </div>
@endsection
@section('script')
    <script src="//cdn.bootcss.com/simplemde/1.11.2/simplemde.min.js"></script>
    <script>
        var simplemde = new SimpleMDE({
            autoDownloadFontAwesome: true,
            autosave: {
                enabled: true,
                uniqueId: "page.create",
                delay: 1000,
            },
            renderingConfig: {
                codeSyntaxHighlighting: true,
            },
            spellChecker: false,
            toolbar: ["bold", "italic", "heading", "|", "quote", 'code', 'ordered-list', 'unordered-list', 'link', 'image', 'table', '|', 'preview', 'side-by-side', 'fullscreen'],
        });
        inlineAttachment.editors.codemirror4.attach(simplemde.codemirror, {
            uploadUrl: $("#upload-img-url").data('upload-img-url'),
            uploadFieldName: 'image',
            extraParams: {
                '_token': XblogConfig.csrfToken,
                'type': 'xrt'
            },
        });
    </script>
@endsection