
local lx, _M = oo{
    _cls_       = '',
    _ext_       = 'unit.testCase'
}

local app, lf, tb, str = lx.kit()

function _M:setUp()

end

function _M:tearDown()

end

function _M:testBasicExample()
 
    local mock = self:mock('htmlStr')
    mock:shouldReceive('toHtml'):once()
        :with(1, 2, 3)
        :andReturn(3)

    self:assertEquals(3, mock:toHtml(1,2,3))
end

function _M:test0()
    
    local col = lx.col{1,2,3}

    self:assertContains(1, col)
    -- self:assertTrue(nil)
end


return _M

