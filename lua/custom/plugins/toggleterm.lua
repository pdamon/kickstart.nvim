return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- Additional configuration options
      size = 20,
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = true,
      float_opts = {
        title_pos = 'center',
      },
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
      local term = Terminal:new { cmd = cmd, hidden = true, count = count, direction = 'float' }
      return function()
        term:toggle()
      end
    end

    local function toggle_term(count)
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new { hidden = true, count = count, direction = 'float' }
      return function()
        term:toggle()
      end
    end
    -- Setup key mappings
    local map = vim.api.nvim_set_keymap
    -- Htop
    map('n', '<leader>th', '', { callback = term_cmd('htop', 10), noremap = true, silent = true, desc = 'ToggleTerm htop' })
    -- Lazygit
    map('n', '<leader>tg', '', { callback = term_cmd('lazygit', 20), noremap = true, silent = true, desc = 'ToggleTerm lazygit' })
    -- Python
    map('n', '<leader>tp', '', { callback = term_cmd('python3', 30), noremap = true, silent = true, desc = 'ToggleTerm python' })

    for i = 1, 4 do
      map('n', '<leader>t' .. i, '', {
        callback = toggle_term(i),
        noremap = true,
        silent = true,
        desc = 'ToggleTerm ' .. i,
      })
    end
  end,
}
