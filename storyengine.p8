pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- globals
MARGIN = 4
SCREEN_WIDTH = 128
LINE_HEIGHT = 6
LETTER_WIDTH = 4

-->8
-- text functions
function wrap_text(sentence, screen_y)
    local words = split(sentence, " ", false)
    screen_cursor_x = MARGIN
    screen_cursor_y = screen_y

    foreach( words, function(word)
        if (#word * LETTER_WIDTH + screen_cursor_x > SCREEN_WIDTH - MARGIN) then
            screen_cursor_y = screen_cursor_y + LINE_HEIGHT
            screen_cursor_x = MARGIN
        end

        print(word, screen_cursor_x, screen_cursor_y, 7)
        screen_cursor_x = screen_cursor_x + (#word * LETTER_WIDTH) + LETTER_WIDTH
    end )

    return screen_cursor_y
end

function menu()
    print("< option 1 >", MARGIN, SCREEN_WIDTH - MARGIN - LINE_HEIGHT, 7)
end

-->8
-- lifecycle
function _init()

end

function _update60()

end

function _draw()
    cls(0)
    local y = 0
    y = wrap_text("hello world this is a long sentence that keeps going and going and going and going.", y + MARGIN)
    y = wrap_text("this is another paragraph.", y + (LINE_HEIGHT * 2))
    y = wrap_text("and yet another! how many will there be?", y + (LINE_HEIGHT * 2))

    menu()

    rect(0, 0, 127, 127, 1)
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
