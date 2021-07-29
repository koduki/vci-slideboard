print("slideboard: ver02")

local MAX_SLIDE_PAGE = 4
local UseCount = 0
local DummyRightScreen = vci.assets.GetSubItem("DummyRightScreen")
local DummyLeftScreen = vci.assets.GetSubItem("DummyLeftScreen")
local RightScreen = vci.assets.GetSubItem("RightScreen")
local LeftScreen = vci.assets.GetSubItem("LeftScreen")

function NextSlide(boardStatus)
    if boardStatus == "right" then
        UseCount = UseCount + 1
    elseif boardStatus == "left" then
        UseCount = UseCount - 1
    end

    local index = UseCount % MAX_SLIDE_PAGE
    local offset = Vector2.zero
    offset.y = 0
    offset.x = (1.0 / MAX_SLIDE_PAGE) * index
    print(string.format("page: %d, onUse: %d, offset.x: %d, offset.y: %d", index + 1, UseCount, offset.x, offset.y))
    vci.assets._ALL_SetMaterialTextureOffsetFromName("Slide", offset)
end

function OnLazerPointerMessage(sender, name, message)
    print(message.event)
    NextSlide(message.event)
end
vci.message.On("sendFromLazerPointer121", OnLazerPointerMessage)

function onUse(use)
    NextSlide("left")
end

function updateAll()
    RightScreen.SetPosition(DummyRightScreen.GetPosition())
    RightScreen.SetRotation(DummyRightScreen.GetRotation())
    LeftScreen.SetPosition(DummyLeftScreen.GetPosition())
    LeftScreen.SetRotation(DummyLeftScreen.GetRotation())

    local scale = vci.assets.GetSubItem("Board").GetLocalScale()
    scale.z = 6.123234e-17
    scale.x = scale.x - 0.1
    RightScreen.SetLocalScale(scale)
    LeftScreen.SetLocalScale(scale)
end