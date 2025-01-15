return {
  "rachartier/tiny-glimmer.nvim",
  event = "TextYankPost",
  opts = {
    enabled = true,
    default_animation = "pulse",
    refresh_interval_ms = 6,

    -- Only use if you have a transparent background
    -- It will override the highlight group background color for `to_color` in all animations
    transparency_color = require("gruvbox-material.colors").get(vim.o.background, "hard").bg0,
    animations = {
      fade = {
        max_duration = 300,
        min_duration = 200,
        chars_for_max_duration = 10,
        color = hl_visual_bg,
      },
      bounce = {
        max_duration = 500,
        min_duration = 400,
        chars_for_max_duration = 20,
        oscillation_count = 1,
      },
      left_to_right = {
        max_duration = 350,
        min_duration = 150,
        chars_for_max_duration = 25,
        lingering_time = 50,
      },
      pulse = {
        max_duration = 300,
        min_duration = 200,
        chars_for_max_duration = 15,
        pulse_count = 1,
        intensity = 1.2,
      },
      rainbow = {
        max_duration = 600,
        min_duration = 350,
        chars_for_max_duration = 20,
      },
      custom = {
        max_duration = 350,
        chars_for_max_duration = 40,
        color = hl_visual_bg,

        -- Custom effect function
        -- @param self table The effect object
        -- @param progress number The progress of the animation [0, 1]
        --
        -- Should return a color and a progress value
        -- that represents how much of the animation should be drawn
        effect = function(self, progress)
          return self.settings.color, progress
        end,
      },
    },
    virt_text = {
      priority = 2048,
    },
  },
}
