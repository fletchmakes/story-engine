pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- globals
_margin = 4
_screen_width = 128
_line_height = 6
_letter_width = 4

_menu_option = 1
_menu_offset = 0
_menu_tween = nil
_anim_duration = 0.5
opts = {"walk", "run", "check", "inventory", "save", "exit"}

-->8
-- tween helpers

-- https://github.com/JoebRogers/PICO-Tween
function linear(t, b, c, d)
    return c * t / d + b
end

-- https://github.com/JoebRogers/PICO-Tween
function outQuad(t, b, c, d)
    t = t / d
    return -c * t * (t - 2) + b
end

function coroutween(duration, from, to, func)
    return function() 
        local tStart = time()
        local elapsed = 0
        while (true) do
            elapsed = time() - tStart

            if (elapsed > duration) then elapsed = duration end

            local step = outQuad(elapsed, from, to - from, duration)
            func(step)

            if (elapsed >= duration) then break end
            yield()
        end
    end
end

-->8
-- text functions
function print_text(sentence, screen_y)
    local words = split(sentence, " ", false)
    screen_cursor_x = _margin
    screen_cursor_y = screen_y

    foreach( words, function(word)
        if (#word * _letter_width + screen_cursor_x > _screen_width - _margin) then
            screen_cursor_y = screen_cursor_y + _line_height
            screen_cursor_x = _margin
        end

        print(word, screen_cursor_x, screen_cursor_y, 7)
        screen_cursor_x = screen_cursor_x + (#word * _letter_width) + _letter_width
    end )

    return screen_cursor_y
end

function center(word)
    return (_screen_width / 2) - ((#word * _letter_width) / 2)
end

-->8
-- menus
function get_menu_offset(options, active_idx)
    local center_x = center(options[active_idx])
    local cursor_x = center_x
    local cursor = active_idx

    while (cursor > 1) do
        cursor = cursor - 1
        cursor_x = cursor_x - (_letter_width + _letter_width + (#options[cursor] * _letter_width))
    end

    return cursor_x
end

function set_menu_offset(value)
    _menu_offset = value
end

function print_menu(options)
    local cursor_x = _menu_offset
    for i=1,#options do
        local color = 5
        if (_menu_option == i) then
            color = 7
        end
        print(options[i], cursor_x, 128 - _margin - _line_height, color)
        cursor_x = cursor_x + (_letter_width + _letter_width + (#options[i] * _letter_width))
    end
end

-->8
-- lifecycle
function _init()
    _menu_offset = get_menu_offset(opts, _menu_option)
end

function _update60()
    if (btnp(0) and _menu_option > 1 and _menu_tween == nil) then
        _menu_option = _menu_option - 1
        _menu_tween = cocreate( coroutween(_anim_duration, _menu_offset, get_menu_offset(opts, _menu_option), set_menu_offset) )
    end

    if (btnp(1) and _menu_option < 6 and _menu_tween == nil) then
        _menu_option = _menu_option + 1
        _menu_tween = cocreate( coroutween(_anim_duration, _menu_offset, get_menu_offset(opts, _menu_option), set_menu_offset) )
    end

    if _menu_tween and costatus(_menu_tween) != 'dead' then
        coresume(_menu_tween)
    else
        _menu_tween = nil
    end
end

function _draw()
    cls(0)
    local y = 0
    y = print_text("you find yourself in a small room. the walls and ceilings are damp.", y + _margin)
    y = print_text("before you stretches an open corridor that you cannot see the end of.", y + (_line_height * 2))
    y = print_text("rummaging in your pockets, you find a small key.", y + (_line_height * 2))

    print_menu(opts, _menu_offset)

    rect(0, 0, 127, 127, 1)
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
