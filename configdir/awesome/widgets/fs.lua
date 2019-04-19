local awful = require("awful")
local wibox = require("wibox")
local utils = require("utils")
local icons = require("icons")
local lain = require("lain")
local naughty = require("naughty")
local BaseWidget = require("widgets.base").BaseWidget


local FSWidget = BaseWidget.derive()

function print_info(name, data)
    units = string.upper(data.units)
    return string.format("\n%s - %i%%\n\tFree:\t\t%.2f %s\n\tUsed:\t%.2f %s\n\tSize:\t\t%.2f %s\n",
        name, data.percentage,
        data.free, units,
        data.used, units,
        data.size, units)
end

function FSWidget:generate_popup_string()
    keys = {}
    s = ""

    for k in pairs(self.data) do
        table.insert(keys, k)
    end

    table.sort(keys)

    for _, k in ipairs(keys) do
        s = s .. print_info(k, self.data[k])
    end

    return s
end

function FSWidget:create(args)
    args = args or {}
    args.followtag           = args.followtag or true
    args.notification_preset = args.notification_preset or naughty.config.defaults
    args.partition           = args.partition or "/"
    args.showpopup           = "off"
    args.settings            = function()
        self.data = fs_now
        widget:set_markup(fs_now["/"].percentage .. "%")
        self.popuptext = self:generate_popup_string()
    end

    self.partition = args.partition
    self.popuptext = ""
    self.lainwidget = lain.widget.fs(args)
    local box = self:init(self.lainwidget.widget, args.icon or icons.fs)

    utils.registerPopupNotify(box, "Filesystem", function(w)
        return self.popuptext or ""
    end)
end

function FSWidget:update()
    self.lainwidget.update()
end

return FSWidget
