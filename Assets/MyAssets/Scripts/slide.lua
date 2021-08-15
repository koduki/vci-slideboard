print("slideboard: ver05")

local MAX_SLIDE_PAGE = 8
local MAX_SLIDE_X_INDEX = 4
local MAX_SLIDE_Y_INDEX = 2

local UseCount = 0
local DummyRightScreen = vci.assets.GetTransform("DummyRightScreen")
local DummyLeftScreen  = vci.assets.GetTransform("DummyLeftScreen")
local RightScreen      = vci.assets.GetTransform("RightScreen")
local LeftScreen       = vci.assets.GetTransform("LeftScreen")

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
    local yidx = math.ceil((UseCount + 1 ) / MAX_SLIDE_X_INDEX) % MAX_SLIDE_Y_INDEX
    local width = (1.0 / MAX_SLIDE_X_INDEX)
    local height = (1.0 / MAX_SLIDE_Y_INDEX)
    local offset = Vector2.zero
    offset.y = 1 - height * yidx
    offset.x = width * xidx

    local page = UseCount % (MAX_SLIDE_X_INDEX * MAX_SLIDE_Y_INDEX) + 1
    print(String.format("onUse: %d, index-x: %d, index-y: %d, page: %d, offset.x: %f, offset.y: %f", UseCount, xidx, yidx, page, offset.x, offset.y))

    vci.assets._ALL_SetMaterialTextureOffsetFromName("Slide", offset)
end

function OnLazerPointerMessage(sender, name, message)
    print(message.event)
    NextSlide(message.event)
end
vci.message.On("sendFromLazerPointer121", OnLazerPointerMessage)

function onUse(use)
    -- NextSlide("right")
    print("onUse")

    local cam = vci.studio.GetHandiCamera()
    cam.SetPosition(Vector3.__new(0, 1, 0))
end

function updateAll()
    local cam = vci.studio.GetHandiCamera()
    local camPos = cam.GetPosition()
    local scrnPos = LeftScreen.GetPosition()
    print(string.format("camPos : %f, %f, %f", camPos.x, camPos.y, camPos.z))
    print(string.format("scrnPos: %f, %f, %f", scrnPos.x, scrnPos.y, scrnPos.z))

    local dist = math.sqrt((camPos.x - scrnPos.x)^2 + (camPos.y - scrnPos.y)^2)
    print(string.format("dist: %f", dist))


    local r = 0
    local angle = DummyLeftScreen.GetRotation().eulerAngles
    print(angle)
    -- print(String.format("angle: %f, %f, %f", angle.x, angle.y, angle.z))
    -- local x = r * math.sin(angle.z) * math.cos(angle.x)
    -- local y = r * math.sin(angle.z) * math.sin(angle.x)
    -- local z = r * math.cos(angle.z)

    local t = angle.y * math.pi/180
    local x = r * math.sin(t) + scrnPos.x
    local y = r * math.sin(angle.x) * math.sin(angle.y)
    local z = r * math.cos(t) + scrnPos.z
    local pos = Vector3.__new(x, 1, z)
    print(string.format("camPos2: %f, %f, %f", pos.x, pos.y, pos.z))
    -- cam.SetPosition(pos)

    -- cam.SetRotation(LeftScreen.GetRotation())
    local rotate = Quaternion.AngleAxis(DummyLeftScreen.GetRotation().eulerAngles.y , Vector3.up)
    cam.SetRotation(rotate)

    -- print("pos2")
    -- print(RightScreen.GetPosition())

    RightScreen.SetPosition(DummyRightScreen.GetPosition())
    RightScreen.SetRotation(DummyRightScreen.GetRotation())
    LeftScreen.SetPosition(DummyLeftScreen.GetPosition())
    LeftScreen.SetRotation(DummyLeftScreen.GetRotation())
    -- math.sin
    local scale = vci.assets.GetSubItem("Board").GetLocalScale()
    scale.z = 6.123234e-17
    scale.x = scale.x - 0.1
    RightScreen.SetLocalScale(scale)
    LeftScreen.SetLocalScale(scale)
end