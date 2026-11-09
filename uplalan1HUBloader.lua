local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local MY_HUB_URL = "https://raw.githubusercontent.com/eacUPLALAN1/uplalan1HUB/main/uplalan1HUB.lua"
local KERT1_URL = "https://raw.githubusercontent.com/gagagaxoxlox1-eng/-New-Toilet-Verse-Tower-Defense/refs/heads/main/ToiletVerseTowerDefenseScriptKert1"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "uplalan1_Loader"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PG

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(9, 10, 16)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Card = Instance.new("Frame")
Card.Size = UDim2.fromOffset(370, 250)
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.Position = UDim2.fromScale(0.5, 0.5)
Card.BackgroundColor3 = Color3.fromRGB(22, 24, 36)
Card.BorderSizePixel = 0
Card.Parent = Frame
Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -24, 0, 42)
Title.Position = UDim2.fromOffset(12, 10)
Title.BackgroundTransparency = 1
Title.Text = "uplalan1"
Title.TextColor3 = Color3.fromRGB(235, 235, 250)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Card

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1, -24, 0, 50)
Info.Position = UDim2.fromOffset(12, 51)
Info.BackgroundTransparency = 1
Info.Text = "Select script to launch"
Info.TextColor3 = Color3.fromRGB(155, 160, 180)
Info.Font = Enum.Font.Gotham
Info.TextSize = 11
Info.TextWrapped = true
Info.TextYAlignment = Enum.TextYAlignment.Top
Info.Parent = Card

local loaderChoice = nil

local function makeBtn(btnText, y, color, choice)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -32, 0, 55)
    b.Position = UDim2.fromOffset(16, y)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = btnText
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.AutoButtonColor = true
    b.Parent = Card
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
    
    b.MouseButton1Click:Connect(function()
        if loaderChoice ~= nil then return end
        loaderChoice = choice
        Info.Text = "Downloading..."
    end)
end

makeBtn("1  |  Launch my uplalan1 HUB", 115, Color3.fromRGB(105, 75, 210), 1)
makeBtn("2  |  Launch Kert1 script", 180, Color3.fromRGB(45, 125, 185), 2)

repeat task.wait(0.05) until loaderChoice ~= nil

local urlToLoad = (loaderChoice == 1) and MY_HUB_URL or KERT1_URL

local function downloadScript(url)
    local body = nil
    
    if syn and syn.request then
        local ok, res = pcall(function() return syn.request({Url = url, Method = "GET"}) end)
        if ok and res and res.Body then body = res.Body end
    end
    
    if not body and http_request then
        local ok, res = pcall(function() return http_request({Url = url, Method = "GET"}) end)
        if ok and res and res.Body then body = res.Body end
    end
    
    if not body and request then
        local ok, res = pcall(function() return request({Url = url, Method = "GET"}) end)
        if ok and res and res.Body then body = res.Body end
    end
    
    if not body then
        local ok, res = pcall(function() return game:HttpGet(url) end)
        if ok and res then body = res end
    end
    
    return body
end

Info.Text = "Downloading..."

local source = downloadScript(urlToLoad)

if not source or #source < 10 then
    Info.Text = "ERROR: Failed to download. Check your executor."
    Info.TextColor3 = Color3.fromRGB(255, 100, 100)
    return
end

local compileSuccess, func = pcall(loadstring, source)

if not compileSuccess or type(func) ~= "function" then
    Info.Text = "ERROR: Syntax error in script!"
    Info.TextColor3 = Color3.fromRGB(255, 100, 100)
    return
end

local runSuccess, runError = pcall(func)

if not runSuccess then
    Info.Text = "RUN ERROR: " .. tostring(runError)
    Info.TextColor3 = Color3.fromRGB(255, 100, 100)
    return
else
    ScreenGui:Destroy()
end
