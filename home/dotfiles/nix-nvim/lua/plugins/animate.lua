M = {}
M.setup = function()
  local m = require("mini.animate")
  m.setup({
    -- Cursor path
    cursor = {
      -- Whether to enable this animation
      enable = true,
      -- Timing of animation (how steps will progress in time)
      timing = function(_, n)
        return 50 / n
      end,
    },

    -- Vertical scroll
    scroll = {
      -- Whether to enable this animation
      enable = true,
      -- Timing of animation (how steps will progress in time)
      timing = function(_, n)
        return 50 / n
      end,
    },

    -- Window resize
    resize = {
      -- Whether to enable this animation
      enable = false,
      timing = function(_, n)
        return 250 / n
      end,
    },

    -- Window open
    open = {
      -- Whether to enable this animation
      enable = true,
      -- Timing of animation (how steps will progress in time)
      timing = function(_, n)
        return 20 / n
      end,
    },

    -- Window close
    close = {
      -- Whether to enable this animation
      enable = true,
      timing = function(_, n)
        return 20 / n
      end,
    },
  })
end
return M
