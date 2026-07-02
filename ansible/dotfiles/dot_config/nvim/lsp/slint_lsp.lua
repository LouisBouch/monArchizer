return {
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<leader>sp", function()
      client:exec_cmd({
        command = "slint/showPreview",
        arguments = { vim.uri_from_bufnr(bufnr) },
      })
    end, { buffer = bufnr, desc = "Open Slint preview" })
  end,
}

