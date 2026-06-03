return {
  {
    "LazyVim/LazyVim",
    init = function()
      local timer
      local remaining = 0
      local running = false

      local function fmt(sec)
        return string.format("%02d:%02d", math.floor(sec / 60), sec % 60)
      end

      _G.PomodoroStatus = function()
        return running and ("󰄉 " .. fmt(remaining)) or ""
      end

      local function stop()
        if timer then
          timer:stop()
          timer:close()
          timer = nil
        end
        running = false
        remaining = 0
        vim.notify("Pomodoro stopped")
      end

      local function start(minutes)
        if timer then
          stop()
        end

        remaining = (tonumber(minutes) or 25) * 60
        running = true
        timer = vim.loop.new_timer()

        vim.notify("Pomodoro started: " .. fmt(remaining))

        if not timer then
          vim.notify("Failed to create pomodoro timer", vim.log.levels.ERROR, {
            timeout = 10000,
          })
          running = false
          remaining = 0
          return
        end

        timer:start(
          1000,
          1000,
          vim.schedule_wrap(function()
            if not timer or timer:is_closing() then
              return
            end

            remaining = remaining - 1

            if remaining <= 0 then
              stop()
              vim.notify("Pomodoro complete. Take a break.", vim.log.levels.INFO, {
                style = "fancy",
                timeout = 30000,
              })
            end
          end)
        )
      end

      vim.api.nvim_create_user_command("PomodoroStart", function(opts)
        start(opts.args ~= "" and opts.args or 25)
      end, { nargs = "?" })

      vim.api.nvim_create_user_command("PomodoroStop", stop, {})
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, function()
        return _G.PomodoroStatus and _G.PomodoroStatus() or ""
      end)
    end,
  },
}
