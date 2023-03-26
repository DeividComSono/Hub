local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local worldToViewportPoint = Camera.worldToViewportPoint
local EspLibrary = {}

function EspLibrary.TextEsp(name, color, obj, center)
    local TextEsp = Drawing.new("Text")
    TextEsp.Visible = false
    TextEsp.Center = center
    TextEsp.Outline = true
    TextEsp.Color = color
    TextEsp.Size = 16

    local c1
    c1 = RunService.RenderStepped:Connect(function()
        if obj then
            local pos, onscreen = Camera:WorldToViewportPoint(obj.Position)

            if onscreen then
                TextEsp.Position = Vector2.new(pos.X, pos.Y)
                TextEsp.Text = name
                TextEsp.Visible = true
            else
                TextEsp.Visible = false
            end
        else
            TextEsp.Visible = false
            TextEsp:Remove()
            c1:Disconnect()
        end
    end)

    local ret = {}

    ret.update = function(newText)
        if c1 ~= nil then
            name = newText
        end
    end

    ret.delete = function()
        if c1 then
            c1:Disconnect()
            c1 = nil
            TextEsp.Visible = false
            TextEsp:Remove()
        end
    end

    return ret
end

function EspLibrary.LineEsp(color, obj)
    local LineEsp = Drawing.new("Line")
    LineEsp.Visible = false
    LineEsp.Color = color
    LineEsp.Thickness = 1
    LineEsp.Transparency = 1

    local c1
    c1 = RunService.RenderStepped:Connect(function()
        if obj ~= nil then
            local pos, onscreen = Camera:WorldToViewportPoint(obj.Position)

            if onscreen then
                LineEsp.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 1)
                LineEsp.To = Vector2.new(pos.X, pos.Y)
                LineEsp.Visible = true
            else
                LineEsp.Visible = false
            end
        else
            LineEsp.Visible = false
            LineEsp:Remove()
            c1:Disconnect()
        end
    end)

    local ret = {}

    ret.delete = function()
        if c1 then
            c1:Disconnect()
            c1 = nil
            LineEsp.Visible = false
            LineEsp:Remove()
        end
    end

    return ret
end


function EspLibrary.PlayerTextEsp(color, who, center, teamcheck)
    local TextEsp = Drawing.new("Text")
    TextEsp.Visible = false
    TextEsp.Center = center
    TextEsp.Outline = true
    TextEsp.Color = color
    TextEsp.Size = 16
    TextEsp.ZIndex = 2

    local c1

    c1 = RunService.RenderStepped:Connect(function()
        if who.Character ~= nil and who.Character:FindFirstChild("Humanoid") ~= nil and who.Character:FindFirstChild("HumanoidRootPart") ~= nil and who ~= game.Players.LocalPlayer and who.Character.Humanoid.Health > 0 then
            local pos, onscreen = Camera:WorldToViewportPoint(who.Character.HumanoidRootPart.Position)

            if onscreen then
                TextEsp.Position = Vector2.new(pos.X, pos.Y)
                TextEsp.Text = who.Name

                if teamcheck and who.TeamColor == game.Players.LocalPlayer.TeamColor then
                    TextEsp.Visible = false
                else
                    TextEsp.Visible = true
                end
            else
                TextEsp.Visible = false
            end        
        else
            TextEsp.Visible = false
            TextEsp:Remove()
            c1:Disconnect()
        end
    end)

    local ret = {}

    ret.update = function(newText)
        if c1 ~= nil then
            name = newText
        end
    end

    ret.delete = function()
        if c1 then
            c1:Disconnect()
            c1 = nil
            TextEsp.Visible = false
            TextEsp:Remove()
        end
    end

    return ret
end

function EspLibrary.PlayerLineEsp(color, who, teamcheck)
    local LineEsp = Drawing.new("Line")
    LineEsp.Visible = false
    LineEsp.Color = color
    LineEsp.Thickness = 1
    LineEsp.Transparency = 1
    LineEsp.ZIndex = 3

    local c1
    c1 = RunService.RenderStepped:Connect(function()
        if who.Character ~= nil and who.Character:FindFirstChild("Humanoid") ~= nil and who.Character:FindFirstChild("HumanoidRootPart") ~= nil and who ~= game.Players.LocalPlayer and who.Character.Humanoid.Health > 0 then
            local pos, onscreen = Camera:WorldToViewportPoint(who.Character.HumanoidRootPart.Position)

            if onscreen then
                LineEsp.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 1)
                LineEsp.To = Vector2.new(pos.X, pos.Y)
                

                if teamcheck and who.TeamColor == game.Players.LocalPlayer.TeamColor then
                    LineEsp.Visible = false
                else
                    LineEsp.Visible = true
                end
            else
                LineEsp.Visible = false
            end        
        else
            LineEsp.Visible = false
            LineEsp:Remove()
            c1:Disconnect()
        end
    end)

    local ret = {}

    ret.delete = function()
        if c1 then
            c1:Disconnect()
            c1 = nil
            LineEsp.Visible = false
            LineEsp:Remove()
        end
    end

    return ret
end

function EspLibrary.PlayerBoxEsp(color, who, filled, teamcheck)
    local headoff = Vector3.new(0, 0.5, 0)
    local legoff = Vector3.new(0, 3, 0)

    local BoxOutlineEsp = Drawing.new("Square")
    BoxOutlineEsp.Visible = false
    BoxOutlineEsp.Color = Color3.new(0, 0, 0)
    BoxOutlineEsp.Thickness = 3
    BoxOutlineEsp.Transparency = 1
    BoxOutlineEsp.Filled = false
    BoxOutlineEsp.ZIndex = 0

    local BoxEsp = Drawing.new("Square")
    BoxEsp.Visible = false
    BoxEsp.Color = color
    BoxEsp.Thickness = 1
    BoxEsp.Transparency = 1
    BoxEsp.Filled = filled
    BoxEsp.ZIndex = 1

    local c1
    c1 = RunService.RenderStepped:Connect(function()
        if who.Character ~= nil and who.Character:FindFirstChild("Humanoid") ~= nil and who.Character:FindFirstChild("HumanoidRootPart") ~= nil and who ~= game.Players.LocalPlayer and who.Character.Humanoid.Health > 0 then
            local pos, onscreen = Camera:WorldToViewportPoint(who.Character.HumanoidRootPart.Position)

            local rootpart = who.Character.HumanoidRootPart
            local head = who.Character.Head
            local rootpos, rootvis = worldToViewportPoint(Camera, rootpart.Position)
            local headpos = worldToViewportPoint(Camera, head.Position + headoff)
            local legpos = worldToViewportPoint(Camera, rootpart.Position - legoff)

            if onscreen then
                BoxOutlineEsp.Size = Vector2.new(1000 / rootpos.Z, headpos.Y - legpos.Y)
                BoxOutlineEsp.Position = Vector2.new(rootpos.X - BoxOutlineEsp.Size.X / 2, rootpos.Y - BoxOutlineEsp.Size.Y / 2)
                BoxOutlineEsp.Visible = true

                BoxEsp.Size = Vector2.new(1000 / rootpos.Z, headpos.Y - legpos.Y)
                BoxEsp.Position = Vector2.new(rootpos.X - BoxEsp.Size.X / 2, rootpos.Y - BoxEsp.Size.Y / 2)
                BoxEsp.Visible = true

                if teamcheck and who.TeamColor == game.Players.LocalPlayer.TeamColor then
                    BoxOutlineEsp.Visible = false
                    BoxEsp.Visible = false
                else
                    BoxOutlineEsp.Visible = true
                    BoxEsp.Visible = true
                end
            else
                BoxOutlineEsp.Visible = false
                BoxEsp.Visible = false
            end
        else
            BoxOutlineEsp.Visible = false
            BoxEsp.Visible = false
        end
    end)

    local ret = {}

    ret.delete = function()
        if c1 then
            c1:Disconnect()
            c1 = nil
            BoxOutlineEsp.Visible = false
            BoxEsp.Visible = false
            BoxOutlineEsp:Remove()
            BoxEsp:Remove()
        end
    end

    return ret
end

return EspLibrary
