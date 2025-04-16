return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  priority = 10, -- Needs to be a really low priority, to catch others plugins keybindings.
  config = function()
    local config = vim.fn["gruvbox_material#get_configuration"]()
    local palette =
        vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
    require("tiny-glimmer").setup({
      enabled = true,
      default_animation = "pulse",
      refresh_interval_ms = 6,

      -- Only use if you have a transparent background
      -- It will override the highlight group background color for `to_color` in all animations

      transparency_color = palette.bg0[1],
      animations = {
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
      },
      virt_text = {
        priority = 2048,
      },
    })
  end,
}
