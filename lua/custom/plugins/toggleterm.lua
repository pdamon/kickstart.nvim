return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      hide_numbers = false,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      direction = 'tab',
      close_on_exit = true,
      winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end,
      },

      shell = vim.o.shell,
    }

    -- Function to create a terminal and run a specific command
    local function term_cmd(cmd, count)
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new { cmd = cmd, hidden = true, count = count, direction = 'tab' }
      return function()
        term:toggle()
      end
    end

    local function toggle_term(count, directon)
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new { hidden = true, count = count, direction = directon }
      return function()
        term:toggle()
      end
    end
    -- Setup key mappings
    local map = vim.api.nvim_set_keymap
    map('n', '<leader>tt', '', { callback = toggle_term(100, 'tab'), noremap = true, silent = true, desc = 'ToggleTerm Tab' })
    map('n', '<leader>th', '', { callback = toggle_term(101, 'horizontal'), noremap = true, silent = true, desc = 'ToggleTerm Horizontal' })
    map('n', '<leader>tv', '', { callback = toggle_term(102, 'vertical'), noremap = true, silent = true, desc = 'ToggleTerm Vertical' })
    -- Btop
    map('n', '<leader>tb', '', { callback = term_cmd('htop', 10), noremap = true, silent = true, desc = 'ToggleTerm htop' })
    -- Lazygit
    map('n', '<leader>tg', '', { callback = term_cmd('lazygit', 20), noremap = true, silent = true, desc = 'ToggleTerm lazygit' })
    -- Python
    map('n', '<leader>tp', '', { callback = term_cmd('python3', 30), noremap = true, silent = true, desc = 'ToggleTerm python' })

    for i = 1, 4 do
      map('n', '<leader>t' .. i, '', {
        callback = toggle_term(i, 'tab'),
        noremap = true,
        silent = true,
        desc = 'ToggleTerm ' .. i,
      })
    end
  end,
}
