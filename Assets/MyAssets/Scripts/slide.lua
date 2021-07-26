print("slide: ver02")

local MAX_SLIDE_PAGE = 4
local UseCount = 0

function NextSlide()
    UseCount = UseCount + 1

    local index = UseCount % MAX_SLIDE_PAGE
    local offset = Vector2.zero
    offset.y = 0
    offset.x = (1.0 / MAX_SLIDE_PAGE) * index
    print(string.format("page: %d, onUse: %d, offset.x: %d, offset.y: %d", index + 1, UseCount, offset.x, offset.y))
    vci.assets._ALL_SetMaterialTextureOffsetFromName("Slide", offset)
end

function OnLazerPointerMessage(sender, name, message)
    print(message.event)
    NextSlide()
end
vci.message.On("sendFromLazerPointer121", OnLazerPointerMessage)

function OnUse(use)
    NextSlide()
end
