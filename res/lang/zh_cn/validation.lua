
return {
    accepted = 'The :attr must be accepted.',
    active_url = 'The :attr is not a valid URL.',
    after = 'The :attr must be a date after :date.',
    after_or_equal = 'The :attr must be a date after or equal to :date.',
    alpha = 'The :attr may only contain letters.',
    alpha_dash = 'The :attr may only contain letters, numbers, and dashes.',
    alpha_num = 'The :attr may only contain letters and numbers.',
    array = 'The :attr must be an array.',
    before = 'The :attr must be a date before :date.',
    before_or_equal = 'The :attr must be a date before or equal to :date.',
    between = {
        numeric = 'The :attr must be between :min and :max.',
        file = 'The :attr must be between :min and :max kilobytes.',
        string = 'The :attr must be between :min and :max characters.',
        array = 'The :attr must have between :min and :max items.'
    },
    boolean = 'The :attr field must be true or false.',
    confirmed = ':attr 两次确认不匹配.',
    date = 'The :attr is not a valid date.',
    date_format = 'The :attr does not match the format :format.',
    different = 'The :attr and :other must be different.',
    digits = 'The :attr must be :digits digits.',
    digits_between = 'The :attr must be between :min and :max digits.',
    dimensions = 'The :attr has invalid image dimensions.',
    distinct = 'The :attr field has a duplicate value.',
    email = 'The :attr must be a valid email address.',
    exists = 'The selected :attr is invalid.',
    file = 'The :attr must be a file.',
    filled = 'The :attr field is required.',
    image = 'The :attr must be an image.',
    ['in'] = 'The selected :attr is invalid.',
    in_array = 'The :attr field does not exist in :other.',
    integer = 'The :attr must be an integer.',
    ip = 'The :attr must be a valid IP address.',
    json = 'The :attr must be a valid JSON string.',
    max = {
        numeric = 'The :attr may not be greater than :max.',
        file = 'The :attr may not be greater than :max kilobytes.',
        string = 'The :attr may not be greater than :max characters.',
        array = 'The :attr may not have more than :max items.'
    },
    mimes = 'The :attr must be a file of type: :values.',
    mimetypes = 'The :attr must be a file of type: :values.',
    min = {
        numeric = 'The :attr must be at least :min.',
        file = 'The :attr must be at least :min kilobytes.',
        string = 'The :attr must be at least :min characters.',
        array = 'The :attr must have at least :min items.'
    },
    not_in = 'The selected :attr is invalid.',
    numeric = 'The :attr must be a number.',
    present = 'The :attr field must be present.',
    regex = 'The :attr format is invalid.',
    required = '字段 :attr 必填.',
    required_if = 'The :attr field is required when :other is :value.',
    required_unless = 'The :attr field is required unless :other is in :values.',
    required_with = 'The :attr field is required when :values is present.',
    required_with_all = 'The :attr field is required when :values is present.',
    required_without = 'The :attr field is required when :values is not present.',
    required_without_all = 'The :attr field is required when none of :values are present.',
    same = 'The :attr and :other must match.',
    size = {
        numeric = 'The :attr must be :size.',
        file = 'The :attr must be :size kilobytes.',
        string = 'The :attr must be :size characters.',
        array = 'The :attr must contain :size items.'
    },
    string = 'The :attr must be a string.',
    timezone = 'The :attr must be a valid zone.',
    unique = 'The :attr has already been taken.',
    uploaded = 'The :attr failed to upload.',
    url = 'The :attr format is invalid.',
    custom = {
        ['attr-name'] = {
            ['rule-name'] = 'custom-msg'
        }
    },
    attrs = {}
}