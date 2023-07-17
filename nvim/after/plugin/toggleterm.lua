local status, toggleterm = pcall(require, "toggleterm")
if (not status) then return end

toggleterm.setup {
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  persist_size = true,
  persist_mode = true,
  -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
  direction = 'float',
  auto_scroll = true,
}
