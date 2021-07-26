print("slide: ver02")

local MAX_SLIDE_PAGE = 4
local UseCount = 0
local DummyRightScreen = vci.assets.GetSubItem("DummyRightScreen")
local RightScreen = vci.assets.GetSubItem("RightScreen")

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

function onUse(use)
    NextSlide()
end

function updateAll()
    print(vci.assets.GetSubItem("Board").GetLocalScale())
    RightScreen.SetPosition(DummyRightScreen.GetPosition())
    RightScreen.SetRotation(DummyRightScreen.GetRotation())

    local scale = vci.assets.GetSubItem("Board").GetLocalScale()
    scale.z = 6.123234e-17
    scale.x = scale.x - 0.1
    RightScreen.SetLocalScale(scale)
end