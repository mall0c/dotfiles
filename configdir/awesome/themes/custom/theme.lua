---------------------------
-- Default awesome theme --
---------------------------

local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local real_dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local menubar = require("menubar")
-- local gtk = require("beautiful.gtk")

local DPI_SCALE = 0.8

local dpi = function(value, ...)
    return real_dpi(value * DPI_SCALE, ...)
end

local theme = {}
theme.dpi = dpi  -- Expose dpi function for other scripts


function theme.lookup_icon(name, color)
    color = color or theme.fg_normal
    local image = menubar.utils.lookup_icon(name)

    if not image then
        local function try(icondir)
            icondir = string.format("%s/%s/symbolic/", icondir, theme.icon_theme)
            local fname = icondir .. name .. "-symbolic.svg"
            if gears.filesystem.is_dir(icondir) then
                if gears.filesystem.file_readable(fname) then
                    return fname
                end
            end
            print("Error: Icon " .. fname .. " not found")
            return nil
        end

        image = try(string.format("%s/.icons", os.getenv("HOME")))
            or try("/usr/share/icons")
            or try("/usr/share/icons/hicolor")
    end

    if image then
        image = gears.color.recolor_image(image, color)
    end

    return image
end

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "oomox-numix_awesome_icons"

theme.font          = "Sans 7"
-- theme.font          = "Open Sans 7"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"
theme.fullscreen_hide_border = true

-- theme.gtk = gtk.get_theme_variables()
-- theme.bg_normal     = theme.gtk.bg_color
-- theme.fg_normal     = theme.gtk.fg_color
--
-- theme.wibar_bg      = theme.gtk.menubar_bg_color
-- theme.wibar_fg      = theme.gtk.menubar_fg_color
--
-- theme.bg_focus      = theme.gtk.selected_bg_color
-- theme.fg_focus      = theme.gtk.selected_fg_color
--
-- theme.bg_urgent     = theme.gtk.error_bg_color
-- theme.fg_urgent     = theme.gtk.error_fg_color
--
-- theme.bg_minimize   = mix(theme.wibar_fg, theme.wibar_bg, 0.3)
-- theme.fg_minimize   = mix(theme.wibar_fg, theme.wibar_bg, 0.9)
--
-- theme.bg_systray    = theme.wibar_bg
--
-- theme.border_normal = theme.gtk.wm_border_unfocused_color
-- theme.border_focus  = theme.gtk.wm_border_focused_color
-- theme.border_marked = theme.gtk.success_color
--
-- theme.border_width  = dpi(theme.gtk.button_border_width or 1)
-- theme.border_radius = theme.gtk.button_border_radius

-- theme.taglist_bg_focus = "#555555"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- old behaviour
-- theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
-- theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Generate taglist squares:
local taglist_square_size = dpi(8)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.wibar_icon_margin = dpi(4)
-- theme.wibar_height = dpi(26)


-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_max_width = dpi(455)
-- theme.notification_max_height = dpi(75)
theme.notification_icon_size = dpi(75)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(100)
theme.main_menu_width = dpi(150)

theme.titlebar_size = dpi(25)
theme.titlebar_margin = dpi(3)
theme.titlebar_border_size = dpi(2)
theme.titlebar_bg_focus = theme.bg_normal
-- theme.titlebar_bg_normal = theme.bg_normal .. "CC"

-- Radius from client corner that allows dragging to resize
theme.client_corner_resize_radius = dpi(20)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"
-- theme.titlebar_close_button_normal = lookup_icon("actions/window-close")
-- theme.titlebar_close_button_focus = lookup_icon("actions/window-close")

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"
-- theme.titlebar_minimize_button_normal = lookup_icon("actions/window-minimize")
-- theme.titlebar_minimize_button_focus  = lookup_icon("actions/window-minimize")

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

local themedir = os.getenv("HOME") .. "/.config/awesome/themes/custom/"
theme.wallpaper = os.getenv("HOME") .. "/.cache/awesome/wallpaper.png"

local layoutdir = themedir .. "layouts/"
theme.layout_fairh = layoutdir .. "fairhw.png"
theme.layout_fairv = layoutdir .. "fairvw.png"
theme.layout_floating  = layoutdir .. "floatingw.png"
theme.layout_magnifier = layoutdir .. "magnifierw.png"
theme.layout_max = layoutdir .. "maxw.png"
theme.layout_fullscreen = layoutdir .. "fullscreenw.png"
theme.layout_tilebottom = layoutdir .. "tilebottomw.png"
theme.layout_tileleft   = layoutdir .. "tileleftw.png"
theme.layout_tile = layoutdir .. "tilew.png"
theme.layout_tiletop = layoutdir .. "tiletopw.png"
theme.layout_spiral  = layoutdir .. "spiralw.png"
theme.layout_dwindle = layoutdir .. "dwindlew.png"
theme.layout_cornernw = layoutdir .. "cornernw.png"
theme.layout_cornerne = layoutdir .. "cornerne.png"
theme.layout_cornersw = layoutdir .. "cornersw.png"
theme.layout_cornerse = layoutdir .. "cornerse.png"

-- Generate Awesome icon:
-- theme.awesome_icon = theme_assets.awesome_icon(
--     theme.menu_height, theme.bg_focus, theme.fg_focus
-- )

-- theme = theme_assets.recolor_titlebar(theme, theme.fg_normal, "normal")
-- theme = theme_assets.recolor_titlebar(theme, theme.fg_focus, "focus")

return theme
