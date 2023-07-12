local status, zen = pcall(require, "zen")
if (not status) then return end

config = function()
  zen.setup {}
end

