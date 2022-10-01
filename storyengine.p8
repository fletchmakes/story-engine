pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- globals
_margin = 4
_screen_width = 128
_line_height = 6
_letter_width = 4

_menu_option = 1

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
function print_menu(options, active_idx)
    local center_x = center(options[active_idx])
    local cursor_x = center_x
    local cursor = active_idx

    while (cursor > 1) do
        cursor = cursor - 1
        cursor_x = cursor_x - (_letter_width + _letter_width + (#options[cursor] * _letter_width))
    end

    for i=1,#options do
        local color = 5
        if (active_idx == i) then
            color = 7
        end
        print(options[i], cursor_x, 128 - _margin - _line_height, color)
        cursor_x = cursor_x + (_letter_width + _letter_width + (#options[i] * _letter_width))
    end
end

-->8
-- lifecycle
function _init()

end

function _update60()
    if (btnp(0) and _menu_option > 1) then
        _menu_option = _menu_option - 1
    end

    if (btnp(1) and _menu_option < 6) then
        _menu_option = _menu_option + 1
    end
end

function _draw()
    cls(0)
    local y = 0
    y = print_text("hello world this is a long sentence that keeps going and going and going and going.", y + _margin)
    y = print_text("this is another paragraph.", y + (_line_height * 2))
    y = print_text("and yet another! how many will there be?", y + (_line_height * 2))

    print_menu({"walk", "run", "check", "inventory", "save", "exit"}, _menu_option)

    rect(0, 0, 127, 127, 1)
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
