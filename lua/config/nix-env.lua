local M = {}

local function fs_exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function find_nix_root()
  local dir = vim.fn.getcwd()

  while dir and dir ~= "/" do
    if fs_exists(dir .. "/flake.nix") or fs_exists(dir .. "/shell.nix") then
      return dir
    end

    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return nil
end

local function parse_env_lines(output)
  for line in output:gmatch("[^\r\n]+") do
    local key, value = line:match("^([%w_]+)=(.*)$")

    if key and value then
      vim.env[key] = value
    end
  end
end

local function apply_flake_env(root)
  local output = vim.fn.system({
    "nix",
    "print-dev-env",
    root,
    "--json",
  })

  if vim.v.shell_error ~= 0 then
    vim.notify("Nix env: failed to run nix print-dev-env", vim.log.levels.ERROR)
    return false
  end

  local ok, env = pcall(vim.json.decode, output)

  if not ok then
    vim.notify("Nix env: failed to parse nix print-dev-env JSON", vim.log.levels.ERROR)
    return false
  end

  for key, data in pairs(env.variables or {}) do
    if type(data) == "table" and data.value ~= nil then
      vim.env[key] = tostring(data.value)
    end
  end

  return true
end

local function apply_shell_env(root)
  local output = vim.fn.system({
    "nix-shell",
    root .. "/shell.nix",
    "--run",
    "env",
  })

  if vim.v.shell_error ~= 0 then
    vim.notify("Nix env: failed to run nix-shell", vim.log.levels.ERROR)
    return false
  end

  parse_env_lines(output)
  return true
end

function M.activate()
  local root = find_nix_root()

  if not root then
    vim.notify("Nix env: no flake.nix or shell.nix found", vim.log.levels.INFO)
    return
  end

  local choice = vim.fn.confirm("Use Nix environment for Neovim plugins?\n\n" .. root, "&Yes\n&No", 2)

  if choice ~= 1 then
    vim.notify("Nix env: skipped", vim.log.levels.INFO)
    return
  end

  local ok

  if fs_exists(root .. "/flake.nix") then
    ok = apply_flake_env(root)
  elseif fs_exists(root .. "/shell.nix") then
    ok = apply_shell_env(root)
  end

  if not ok then
    return
  end

  vim.g.nix_env_activated = true
  vim.g.nix_env_root = root

  vim.notify("Nix env: activated for Neovim plugins", vim.log.levels.INFO)

  local tools = {
    "node",
    "npm",
    "pnpm",
    "go",
    "gopls",
    "lua-language-server",
    "typescript-language-server",
    "rust-analyzer",
  }

  for _, tool in ipairs(tools) do
    local path = vim.fn.exepath(tool)

    if path ~= "" then
      vim.notify(tool .. ": " .. path, vim.log.levels.INFO)
    end
  end
end

function M.setup(opts)
  opts = opts or {}

  vim.api.nvim_create_user_command("NixEnvActivate", M.activate, {})

  if opts.auto_activate then
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.schedule(M.activate)
      end,
    })
  end
end

return M
