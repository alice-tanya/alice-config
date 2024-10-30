
local function setup() 
  local opt = function(desc) 
    return {noremap = true, silent = true, desc=desc}
  end
  local align = require('align')

  vim.keymap.set('x', 'aa',  function() align.align_to_char({length = 1})                                      end, opt("Aligns to 1 character"))
  vim.keymap.set('x', 'ad',  function() align.align_to_char({preview = true, length = 2})                      end, opt("Aligns to 2 characters with previews"))
  vim.keymap.set('x', 'aw',  function() align.align_to_string({preview = true, regex = false})                 end, opt("Aligns to a string with previews"))
  vim.keymap.set('x', 'ar',  function() align.align_to_string({preview = true, regex = true})                  end, opt("Aligns to a Vim regex with previews"))
  vim.keymap.set('n', 'gaw', function() align.operator(align.align_to_string, {regex = false, preview = true}) end, opt("Example gawip to align a paragraph to a string with previews"))
  vim.keymap.set('n', 'gaa', function() align.operator(align.align_to_char)                                    end, opt("Example gaaip to align a paragraph to 1 character"))
end

return {'Vonr/align.nvim', branch = "v2", lazy = true, init = setup}
