-- -- NEW VIM COMMANDS

---A command object containing all fields necessary for creating a command.
---@class Command
---@field name string Name of the new user command. Must begin with an uppercase letter.
---@field command string|fun(args: vim.api.keyset.create_user_command.command_args)
---   Replacement command to execute when this user command is executed.
---@field ft? string|string[]  Filetypes for which the command is set.
---@field opts? vim.api.keyset.user_command Optional `command-attributes`.

---Create commands
---@param commands Command[]
local function applyCommands(commands)
  -- Autocommand group for autocommands that create file specific commands.
  vim.api.nvim_create_augroup("ft_commands", { clear = true })
  for _, command in ipairs(commands) do
    if command.ft ~= nil then
      -- For when the command has been defined for specific filetypes.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = command.ft,
        group = "ft_commands",
        callback = function(event)
          local opts = command.opts or {}
          vim.api.nvim_buf_create_user_command(
            event.buf,
            command.name,
            command.command,
            opts
          )
        end,
      })
    else
      -- For when the command has not been defined for specific filetypes.
      vim.api.nvim_create_user_command(
        command.name,
        command.command,
        command.opts or {}
      )
    end
  end
end

---List of commands
---@type Command[]
local commands = {
  { name = "Q", command = "q" },
  { name = "W", command = "w" },
  { name = "Wq", command = "wq" },
  { name = "WQ", command = "wq" },
  { name = "Putmes", command = "put=execute('messages')" },
  { name = "RecoveryDiff", command = ":diffthis | :vnew | :r # | :exe 'norm! ggdd' | :diffthis" },
}
applyCommands(commands)
