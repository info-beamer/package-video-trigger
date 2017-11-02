gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.noglobals()

local json = require "json"

local video_file
local play_audio = false

local video

util.file_watch("config.json", function(raw)
    local config = json.decode(raw)

    video_file = resource.open_file(config.video.asset_name)
    play_audio = config.audio

    -- Reset preloaded video
    if video and video:state() == "paused" then
        video:dispose()
        video = nil
    end
end)

util.data_mapper{
    trigger = function()
        if video then
            video:start()
        end
    end,
    abort = function()
        if video then
            video:dispose()
            video = nil
        end
    end,
}

function node.render()
    gl.clear(0, 0, 0, 1)

    if not video then
        video = resource.load_video{
            file = video_file:copy(),
            paused = true,
            audio = play_audio,
            raw = true,
        }
    end

    if video then
        local state, w, h = video:state()
        if state == "loaded" then
            local x1, y1, x2, y2 = util.scale_into(NATIVE_WIDTH, NATIVE_HEIGHT, w, h)
            video:target(x1, y1, x2, y2):layer(2)
        elseif state == "finished" or state == "error" then
            video:dispose()
            video = nil
        end
    end
end
