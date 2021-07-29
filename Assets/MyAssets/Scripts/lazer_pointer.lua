print("lazer-pointer: ver02")

local Lazer = {
     obj = vci.assets.GetSubItem("Lazer"),
     length = 5,
     lightSource = 0.52 + 2 * 5
}
local Stick = vci.assets.GetSubItem("Stick")
local DummyLazer = vci.assets.GetSubItem("DummyLazer")
local BoardStatus = "" --'left'|'right'

function SetLazerLength(len)
     Lazer.length = len
     Lazer.lightSource = 0.52 + 2 * len
     print(string.format("Lazer.length: %d, Lazer.lightSource: %d", Lazer.length, Lazer.lightSource))
end

function TurnOnLazer()
     local scale = Vector3.__new(0.005, 0.005, Lazer.length)
     local pos = Vector3.__new(0, 0, Lazer.lightSource)
     DummyLazer.SetLocalPosition(pos)
     DummyLazer.SetLocalScale(scale)
end

function TurnOffLazer()
     local scale = Vector3.__new(0.005, 0.005, 0)
     local pos = Vector3.__new(Stick.getLocalPosition().x, Stick.getLocalPosition().y, 0)
     DummyLazer.SetLocalPosition(pos)
     DummyLazer.SetLocalScale(scale)
end

function onGrab(use)
     TurnOnLazer()
end

function onUngrab(use)
     TurnOffLazer()
end

function updateAll()
     Lazer.obj.SetPosition(DummyLazer.GetPosition())
     Lazer.obj.SetRotation(DummyLazer.GetRotation())
     Lazer.obj.SetLocalScale(DummyLazer.GetLocalScale())
end

function onTriggerEnter(item, hit)
     if (item == "Lazer") then
          if (hit == "LeftScreen") then
               BoardStatus = "left"
               print(string.format("onTriggerEnter: item=%s, item=%s", item, hit))
          elseif (hit == "RightScreen") then
               BoardStatus = "right"
               print(string.format("onTriggerEnter: item=%s, item=%s", item, hit))
          end
     end
end

function onTriggerExit(item, hit)
end

function onUse()
     vci.message.EmitWithId("sendFromLazerPointer121", { event = BoardStatus })
end 