-- define global variable to store lua program
M = {}

-- local variable to pass the age key to all functions
local age_key

function M.get_age_key()

  -- Get the content of the current buffer
  local buffer_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")

  -- find the line that contain the recipient age key
  for line in buffer_content:gmatch("[^\n]+") do
    if line:match("recipient:") then

      -- only get the last word that is the age pub key
      age_key = line:match("%S+$")
      -- print(age_key:match("%S+$"))
      return age_key
    end
  end
end

-- decrypt sops file -- needs to have the sops age keys $HOME/.config/sops/age
function M.decrypt_sops()

  -- store the age key
  age_key = M.get_age_key()
  -- get the file from the current buffer
  local current_file = vim.fn.expand("%:p")

  -- Run SOPS command to decrypt the file
  local sops_decrypt_command = "sops -d " .. current_file
  local decrypted_content = vim.fn.system(sops_decrypt_command)

  -- try catch error
  if vim.v.shell_error == 0 then

    -- Replace the current buffer's content with decrypted content
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.split(decrypted_content, "\n"))
    print("File decrypted.")
    print("Age KEY: ",age_key)
  else
    print("Error decrypting file with SOPS.")
  end
end

-- encrypt the file -- need to save the file decrypted first
function M.encrypt_sops()

  -- get the file from the current buffer
  local current_file = vim.fn.expand("%:p")

  -- Run SOPS command to encrypt and save the file
  local sops_encrypt_command = "sops -e --in-place --age=" .. age_key .. " " .. current_file
  vim.fn.system(sops_encrypt_command)

  -- reload the buffer to show the encrypted content
  vim.api.nvim_command('edit')

  -- try catch error
  if vim.v.shell_error == 0 then
    print("File encrypted and saved.")
    print("Age KEY: ",age_key)
  else
    print("Error encrypting and saving file with SOPS.")
  end
end

-- bindings
vim.api.nvim_set_keymap("n", "<Leader>md", "<cmd>lua M.decrypt_sops()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>me", "<cmd>lua M.encrypt_sops()<CR>", {noremap = true})

-- return the global var
return M
