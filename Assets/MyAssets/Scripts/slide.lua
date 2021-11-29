print("slideboard: ver01")

local MAX_SLIDE_PAGE = 22
local MAX_SLIDE_X_INDEX = 10
local MAX_SLIDE_Y_INDEX = 3

local UseCount = 0
local DummyRightScreen = vci.assets.GetSubItem("DummyRightScreen")
local DummyLeftScreen = vci.assets.GetSubItem("DummyLeftScreen")
local RightScreen = vci.assets.GetSubItem("RightScreen")
local LeftScreen = vci.assets.GetSubItem("LeftScreen")

local Msgid = ""

function NextSlide(boardStatus)
    if boardStatus == "right" then
        UseCount = UseCount + 1
        if (UseCount > (MAX_SLIDE_PAGE - 1)) then
            UseCount = 0
        end
        print("next")
    elseif boardStatus == "left" then
        UseCount = UseCount - 1
        if (UseCount < 0) then
            UseCount = (MAX_SLIDE_PAGE - 1)
        end
        print("prev")
    end

    local xidx = UseCount % MAX_SLIDE_X_INDEX
    local yidx = math.ceil((UseCount + 1) / MAX_SLIDE_X_INDEX) % MAX_SLIDE_Y_INDEX
    local width = (1.0 / MAX_SLIDE_X_INDEX)
    local height = (1.0 / MAX_SLIDE_Y_INDEX)
    local offset = Vector2.zero
    offset.y = 1 - height * yidx
    offset.x = width * xidx

    local page = UseCount % (MAX_SLIDE_X_INDEX * MAX_SLIDE_Y_INDEX) + 1
    print(
        string.format(
            "onUse: %d, index-x: %d, index-y: %d, page: %d, offset.x: %f, offset.y: %f",
            UseCount,
            xidx,
            yidx,
            page,
            offset.x,
            offset.y
        )
    )

    vci.assets._ALL_SetMaterialTextureOffsetFromName("Slide", offset)
end

function OnLazerPointerMessage(sender, name, message)
    print(string.format("sender messageID:%s, own messageID:%s, event:%s", message.msgid, Msgid, message.event))
    if (message.msgid == Msgid) then
        NextSlide(message.event)
    end
end
vci.message.On("sendFromLazerPointer", OnLazerPointerMessage)

function onUse(use)
    NextSlide("right")
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

function onTriggerEnter(item, hit)
    Msgid = os.date("%Y%m%d%H%M%S")
end