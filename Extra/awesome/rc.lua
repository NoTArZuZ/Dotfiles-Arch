-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- My libraries
local vicious = require("vicious")
local markup = require("markup")
local switcher = require("alttab")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- Autorun programs
awful.spawn.with_shell("~/.config/awesome/autostart.sh")

-- Naughty config
naughty.config.icon_dirs = { "/usr/share/icons/Arc/status/48/" }
naughty.config.spacing = 8
naughty.config.padding = 20
naughty.config.defaults.margin = 10
naughty.config.defaults.position = "bottom_right"

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/sus/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "st"
dmenu = "dmenu_run -bw 2 -l 10 -c"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
awesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

launchmenu = {
    { "Run App", dmenu },
    { "Terminal", terminal },
    { "Cromite", "cromite" },
    { "Mumble", "mumble" },
    { "Steam", "steam" },
    { "Conky", "conky-toggle" },
}

scriptsmenu = {
    { "hub-script", "hub-script" },
    { "Screenshot", "/home/sus/Scripts/maim-scrshot" },
    { "Color Picker", "/home/sus/Scripts/color-picker" },
    { "Set Wallpaper", "/home/sus/Scripts/set-bg" .. " -s" },
    { "Random Wallpaper", "/home/sus/Scripts/set-bg" .. " -r" },
}

mainmenu = awful.menu({ items = {
        { "Launch", launchmenu },
        { "Scripts", scriptsmenu },
        { "Awesome", awesomemenu, beautiful.awesome_icon }
    }, theme = { width = 175, height = 20 }
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local tasklist_template = {
    {
        nil,
        {
            {
                { widget = wibox.widget.imagebox, id = "icon_role" },
                id     = "icon_margin_role",
                left   = 4,
                widget = wibox.container.margin
            },
            {
                {
                    id     = "text_role",
                    widget = wibox.widget.textbox,
                },
                id     = "text_margin_role",
                left   = 8,
                right  = 4,
                widget = wibox.container.margin
            },
            --fill_space = true,
            layout     = wibox.layout.fixed.horizontal
        },
        expand = "outside",
        layout = wibox.layout.align.horizontal,
    },
    -- {
        id     = "background_role",
        widget = wibox.container.background,
    -- },
    -- bottom = 2,
    -- color = xcolors.color4,
    -- widget = wibox.container.margin
}

local volumewidget = {
    {
        { widget = awful.widget.watch('bash -c "~/slstatus-sus/scripts/funcs/volume"', 1) },
        widget = wibox.container.margin(),
        right = 6,
        left = 6
    },
    widget = wibox.container.background(),
    bg = xcolors.color1,
    fg = xcolors.color0,
    buttons = gears.table.join(
        awful.button({ }, 1, function ()
            awful.spawn("bash -c 'pactl set-sink-mute @DEFAULT_SINK@ toggle'")
        end),
        awful.button({ }, 4, function ()
            awful.spawn("bash -c 'pactl set-sink-volume @DEFAULT_SINK@ +2%'")
        end),
        awful.button({ }, 5, function ()
            awful.spawn("bash -c 'pactl set-sink-volume @DEFAULT_SINK@ -2%'")
        end)
    )
}

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    -- awful.tag({ " 󰣇 ", "  ", "  ", "  ", "  " }, s, awful.layout.suit.tile)
    awful.tag({ "󰣇 ", " ", " ", " ", " " }, s, awful.layout.suit.tile)

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a tasklist widget
    s.tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        buttons = tasklist_buttons,
        widget_template = tasklist_template,
    }

    -- Create a taglist widget
    -- s.taglist = awful.widget.taglist {
    --     screen  = s,
    --     filter  = awful.widget.taglist.filter.all,
    --     buttons = taglist_buttons,
    -- }

    local fancy_taglist = require("fancytags")
        s.taglist = fancy_taglist.new({
            screen = s,
            taglist = { buttons = taglist_buttons },
            tasklist = { buttons = tasklist_buttons }
    })

    separatorA = wibox.widget.textbox()
    separatorA.text = "  "
    
    separatorB = wibox.widget.textbox()
    separatorB.text = " "

    separatorC = { widget = wibox.container.margin, right = 8 }

    memicon = wibox.widget.textbox() -- RAM Icon
    memicon.markup = markup.color(xcolors.color0, xcolors.color2, "   " )
    memicon:buttons(awful.button({ }, 1, function () awful.spawn("bash -c '~/slstatus-sus/scripts/onclick/mem'") end)) -- RAM click function

    memwidget = wibox.widget.textbox() -- RAM Widget
    vicious.cache(vicious.widgets.mem)
    vicious.register(memwidget, vicious.widgets.mem, markup.fg.color(xcolors.color2, " $1%"), 1)
    memwidget:buttons(awful.button({ }, 1, function () awful.spawn("bash -c '~/slstatus-sus/scripts/onclick/mem'") end)) -- RAM click function

    cpuicon = wibox.widget.textbox() -- CPU Icon
    cpuicon.markup = markup.color(xcolors.color0, xcolors.color5, "   " )
    cpuicon:buttons(awful.button({ }, 1, function () awful.spawn("bash -c '~/slstatus-sus/scripts/onclick/cpu'") end)) -- CPU click function

    cpuwidget = wibox.widget.textbox() -- CPU Widget
    vicious.cache(vicious.widgets.cpu)
    vicious.register(cpuwidget, vicious.widgets.cpu, markup.fg.color(xcolors.color5, " $1%"), 1)
    cpuwidget:buttons(awful.button({ }, 1, function () awful.spawn("bash -c '~/slstatus-sus/scripts/onclick/cpu'") end)) -- CPU click function

    diskicon = wibox.widget.textbox() -- Disk Icon
    diskicon.markup = markup.color(xcolors.color0, xcolors.color4, " 󱛟 " )
    diskicon:buttons(awful.button({ }, 1, function () awful.spawn("bash -c '~/slstatus-sus/scripts/onclick/diskfree'") end)) -- Disk click function

    diskwidget = wibox.widget.textbox() -- Disk Widget
    vicious.register(diskwidget, vicious.widgets.fs, markup.fg.color(xcolors.color4, " ${/ avail_gb} GiB free"), 60)
    diskwidget:buttons(awful.button({ }, 1, function () awful.spawn("bash -c '~/slstatus-sus/scripts/onclick/diskfree'") end)) -- Disk click function

    dateicon = wibox.widget.textbox() -- Date Icon
    dateicon.markup = markup.color(xcolors.color0, xcolors.color6, " 󰔟 ")
    dateicon:buttons(awful.button({ }, 1, function () awful.spawn("bash -c '~/slstatus-sus/scripts/onclick/date'") end)) -- Date click function
    
    datewidget = wibox.widget.textbox() -- Date Widget
    vicious.register(datewidget, vicious.widgets.date, markup.fg.color(xcolors.color6, " %F %T "), 1)
    datewidget:buttons(awful.button({ }, 1, function () awful.spawn("bash -c '~/slstatus-sus/scripts/onclick/date'") end)) -- Date click function

    kblayouticon = wibox.widget.textbox() -- Keyboard Layout Icon
    kblayouticon.markup = markup.color(xcolors.color0, xcolors.color3, "  ")
    
    keyboardLayout = wibox.container.background(awful.widget.keyboardlayout()) -- Keyboard Layout Widget
    keyboardLayout.fg = xcolors.color3

    wmicon = wibox.widget.textbox() -- WM Icon
    wmicon.markup = markup.color(xcolors.color0, xcolors.color7, "   ")

    -- Create the wibox
    s.wibox = awful.wibar({ position = "top", screen = s, height = 20 })

    -- Add widgets to the wibox
    s.wibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            wmicon,
            { widget = wibox.container.margin, right = 13, },
            layout = wibox.layout.fixed.horizontal,
            s.taglist,
            { widget = wibox.container.margin, right = 12, },
            s.layoutbox,
            { widget = wibox.container.margin, right = 12, },
        },
        s.tasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            separatorA, --separator
            kblayouticon,
            keyboardLayout,
            volumewidget,
            separatorC, --separator
            diskicon,
            diskwidget,
            separatorC, --separator
            cpuicon,
            cpuwidget,
            separatorC, --separator
            memicon,
            memwidget,
            separatorC, --separator
            dateicon,
            datewidget,
            wibox.widget.systray(),
            { widget = wibox.container.margin, right = 6, },
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 1, function () mainmenu:hide() end),
    awful.button({ }, 3, function () mainmenu:show() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, "Shift"   }, "Tab",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Tab",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ "Mod1",           }, "Tab", function () switcher.switch( 1, "Mod1", "Alt_L", "Shift", "Tab") end,
              {description = "cycle windows", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey, "Mod1"   }, "w", function () mainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Mod1" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Mod1"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "Prior", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey,           }, "Next", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
    awful.key({ modkey,           }, "space",
            function ()
                if awful.layout.getname(awful.layout.get(s)) ~= "max" then prev_layout_alt = awful.layout.get(s) end
                if awful.layout.getname(awful.layout.get(s)) == "max" then
                    awful.layout.set(prev_layout_alt)
                else
                    awful.layout.set(awful.layout.suit.max)
                end
            end,
              {description = "Alternate between Max and Previous", group = "layout"}),

    awful.key({ modkey, "Shift" }, "z",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey            }, "c",      function () awful.spawn("conky-toggle") end,
              {description = "toggle conky", group = "launcher"}),
    awful.key({ modkey            }, "d",      function () awful.spawn(dmenu) end,
              {description = "dmenu_run", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "d",      function () awful.spawn("hub-script") end,
              {description = "hub-script", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "g",
        function (c)
            c.floating = not c.floating
            awful.placement.centered()
            c:raise()
        end ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey,           }, "p",
        function (c)
            c.sticky = not c.sticky
            c:raise()
        end ,
              {description = "toggle sticky", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "z",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     callback = awful.client.setslave
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Nsxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "steam",
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true, placement = awful.placement.centered }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    { rule_any = { class = { "St", "mpv" }
        }, properties = { size_hints_honor = false }
    },

    { rule_any = { class = { "Xdg-desktop-portal-gtk" }
        }, properties = { placement = awful.placement.centered }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = 18 }) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        layout = wibox.layout.align.horizontal,
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Smart borders for single, floating, maximized window and for max, floating layouts
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    local layout = awful.layout.getname(awful.layout.get(s))
    for _, c in pairs(s.clients) do
        if only_one and layout == "floating" then
            c.border_width = beautiful.border_width -- your border width
            awful.titlebar.show(c, "top")
        elseif (only_one or layout == "max") and not c.floating or c.maximized then
            c.border_width = 0
            awful.titlebar.hide(c, "top")
        else
            c.border_width = beautiful.border_width -- your border width
            awful.titlebar.show(c, "top")
        end
    end
end)

-- Window swallowing implementation
table_is_swallowed = { "St", }
table_minimize_parent = { "mpv", "Nsxiv", "Cromite" }
table_cannot_swallow = { "Dragon" }

function is_in_Table(table, element)
    for _, value in pairs(table) do
        if element:match(value) then
            return true
        end
    end
    return false
end

function is_to_be_swallowed(c)
    return (c.class and is_in_Table(table_is_swallowed, c.class)) and true or false
end

function can_swallow(class)
    return not is_in_Table(table_cannot_swallow, class)
end

function is_parent_minimized(class)
    return is_in_Table(table_minimize_parent, class)
end

function copy_size(c, parent_client)
    if (not c or not parent_client) then
        return
    end
    if (not c.valid or not parent_client.valid) then
        return
    end
    c.x=parent_client.x;
    c.y=parent_client.y;
    c.width=parent_client.width;
    c.height=parent_client.height;
end
function check_resize_client(c)
    if(c.child_resize) then
        copy_size(c.child_resize, c)
    end
end

function get_parent_pid(child_ppid, callback)
    local ppid_cmd = string.format("pstree -ps %s", child_ppid)
    awful.spawn.easy_async(ppid_cmd, function(stdout, stderr, reason, exit_code)
        -- primitive error checking
        if stderr and stderr ~= "" then
            callback(stderr)
            return
        end
        local ppid = stdout
        callback(nil, ppid)
    end)
end

client.connect_signal("property::size", check_resize_client)
client.connect_signal("property::position", check_resize_client)
client.connect_signal("manage", function(c)
    if is_to_be_swallowed(c) then
        return
    end
    local parent_client=awful.client.focus.history.get(c.screen, 1)
    get_parent_pid(c.pid, function(err, ppid)
        if err then
            error(err)
            return
        end
        parent_pid = ppid
        if parent_client and (parent_pid:find("("..parent_client.pid..")")) and is_to_be_swallowed(parent_client) and can_swallow(c.class) then
            if is_parent_minimized(c.class) then
                parent_client.child_resize=c
                parent_client.minimized = true
                c:connect_signal("unmanage", function() parent_client.minimized = false end)
                copy_size(c, parent_client)
            else
                parent_client.child_resize=c
                c.floating=true
                copy_size(c, parent_client)
            end
        end
    end)
end)
-- End of window swallowing implementation

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
