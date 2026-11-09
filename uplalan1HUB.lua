-- uplalan1 HUB v10.5 | Gold Edition | Animated Buttons + Loader
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TweenService=game:GetService("TweenService")
local TeleportService=game:GetService("TeleportService")
local RunService=game:GetService("RunService")
local RS=game:GetService("ReplicatedStorage")
local VIM=game:GetService("VirtualInputManager")
local HttpService=game:GetService("HttpService")
local LP=Players.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")

-- ================= START LOADER =================
local loaderParent = nil
pcall(function() if type(gethui) == "function" then loaderParent = gethui() end end)
if not loaderParent then pcall(function() loaderParent = game:GetService("CoreGui") end) end
if not loaderParent then loaderParent = PG end

pcall(function()
    local old = loaderParent:FindFirstChild("uplalan1_StartupLoader")
    if old then old:Destroy() end
end)

local loaderGui = Instance.new("ScreenGui")
loaderGui.Name = "uplalan1_StartupLoader"
loaderGui.ResetOnSpawn = false
loaderGui.IgnoreGuiInset = true
loaderGui.DisplayOrder = 100000
loaderGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parentOk = pcall(function() loaderGui.Parent = loaderParent end)
if not parentOk then loaderParent = PG; loaderGui.Parent = loaderParent end

local loaderBg = Instance.new("Frame")
loaderBg.Name = "Background"
loaderBg.Size = UDim2.fromScale(1, 1)
loaderBg.BackgroundColor3 = Color3.fromRGB(9, 10, 16)
loaderBg.BorderSizePixel = 0
loaderBg.Active = true
loaderBg.Parent = loaderGui

local loaderCard = Instance.new("Frame")
loaderCard.Name = "Card"
loaderCard.Size = UDim2.fromOffset(370, 250)
loaderCard.AnchorPoint = Vector2.new(0.5, 0.5)
loaderCard.Position = UDim2.fromScale(0.5, 0.5)
loaderCard.BackgroundColor3 = Color3.fromRGB(22, 24, 36)
loaderCard.BorderSizePixel = 0
loaderCard.Parent = loaderBg
Instance.new("UICorner", loaderCard).CornerRadius = UDim.new(0, 14)

local loaderTitle = Instance.new("TextLabel")
loaderTitle.Size = UDim2.new(1, -24, 0, 42)
loaderTitle.Position = UDim2.fromOffset(12, 10)
loaderTitle.BackgroundTransparency = 1
loaderTitle.Text = "uplalan1  |  SCRIPT LOADER"
loaderTitle.TextColor3 = Color3.fromRGB(235, 235, 250)
loaderTitle.Font = Enum.Font.GothamBold
loaderTitle.TextSize = 17
loaderTitle.Parent = loaderCard

local loaderInfo = Instance.new("TextLabel")
loaderInfo.Size = UDim2.new(1, -24, 0, 28)
loaderInfo.Position = UDim2.fromOffset(12, 51)
loaderInfo.BackgroundTransparency = 1
loaderInfo.Text = "Выбери скрипт для запуска"
loaderInfo.TextColor3 = Color3.fromRGB(155, 160, 180)
loaderInfo.Font = Enum.Font.Gotham
loaderInfo.TextSize = 12
loaderInfo.Parent = loaderCard

local loaderChoice = nil
local function chooseLoaderOption(choice)
    if loaderChoice ~= nil then return end
    loaderChoice = choice
    loaderInfo.Text = choice == 1 and "Запускаю uplalan1 HUB..." or "Загружаю Kert1..."
end

local function makeLoaderButton(buttonText, y, color, choice)
    local b = Instance.new("TextButton")
    b.Name = "Choice" .. tostring(choice)
    b.Size = UDim2.new(1, -32, 0, 55)
    b.Position = UDim2.fromOffset(16, y)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = buttonText
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.AutoButtonColor = true
    b.Active = true
    b.Selectable = true
    b.Parent = loaderCard
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
    b.MouseButton1Click:Connect(function() chooseLoaderOption(choice) end)
end

makeLoaderButton("1  |  Запустить мой uplalan1 HUB", 91, Color3.fromRGB(105, 75, 210), 1)
makeLoaderButton("2  |  Запустить скрипт Kert1", 156, Color3.fromRGB(45, 125, 185), 2)

local loaderInputConnection
loaderInputConnection = UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or loaderChoice ~= nil then return end
    if input.KeyCode == Enum.KeyCode.One or input.KeyCode == Enum.KeyCode.KeypadOne then chooseLoaderOption(1)
    elseif input.KeyCode == Enum.KeyCode.Two or input.KeyCode == Enum.KeyCode.KeypadTwo then chooseLoaderOption(2) end
end)

repeat task.wait(0.05) until loaderChoice ~= nil
if loaderInputConnection then loaderInputConnection:Disconnect() end

if loaderChoice == 2 then
    local kertUrl = "https://raw.githubusercontent.com/gagagaxoxlox1-eng/-New-Toilet-Verse-Tower-Defense/refs/heads/main/ToiletVerseTowerDefenseScriptKert1"
    loaderInfo.Text = "Получаю скрипт Kert1..."
    local httpOk, source = pcall(function() return game:HttpGet(kertUrl) end)
    if not httpOk or type(source) ~= "string" or source == "" then
        loaderInfo.Text = "Ошибка загрузки Kert1: не удалось получить код"
        task.wait(3); loaderGui:Destroy(); return
    end
    if type(loadstring) ~= "function" then
        loaderInfo.Text = "Ошибка: loadstring недоступен в этом окружении"
        task.wait(3); loaderGui:Destroy(); return
    end
    local compileOk, kertChunk = pcall(loadstring, source)
    if not compileOk or type(kertChunk) ~= "function" then
        loaderInfo.Text = "Ошибка компиляции скрипта Kert1"
        task.wait(3); loaderGui:Destroy(); return
    end
    loaderGui:Destroy()
    local runOk, runErr = pcall(kertChunk)
    if not runOk then warn("Kert1 script error: " .. tostring(runErr)) end
    return
end
loaderGui:Destroy()
-- ================= END START LOADER =================

local PLACE_ID=101605697341796
local HUB_SHORT="uplalan1"
local HUB_FOLDER="uplalan1_HUB"
local CONFIG_FILE="uplalan1_config.json"
local MACRO_FILE="uplalan1_macro.json"

for _,n in ipairs({HUB_FOLDER,"uplalan1_HUB","uplalan1_GlobalChat","uplalan1_LiveView"}) do local o=PG:FindFirstChild(n);if o then o:Destroy() end end

-- ================= ЗОЛОТАЯ ПАЛИТРА (не изменена) =================
local ROLE_DEFAULTS={bg={15,12,10},panel={25,20,15},card={35,28,20},hover={60,50,35},purple={212,175,55},blue={255,215,0},green={180,150,60},red={200,80,80},orange={220,140,60},white={245,240,230},muted={160,140,110},line={80,70,50}}
local Defaults={spawnDelay=10,loopDelay=6,sellBatchAmount=100,sellPassWait=2,autoLoopWait=6,autoFarmBoxType="Starter",autoOpenBoxCount=300,traitRollDelay=0.4,autoEInterval=0.5,autoEKey="E",autoClickerInterval=0.1,autoClickerX=0,autoClickerY=0,autoJumpInterval=2,autoWinInitialDelay=23,autoWinVote="Easy",autoWinSpeed="5",tpTowerName="God G-Man 5.0",tpTowerId="7119227935_1549868",tpDirection="FORWARD",tpDistance=10,tpYOffset=10,collectNames="Coin,Heal",collectLoopInterval=0.1,theme="Gold",themeAnimated=false,animatedTheme="",bgImage="",bgImageFit="crop",bgTarget="main",bgImageTransparency=0.4,bgImageOverlay=0.55,macroMouseOffsetX=0,macroMouseOffsetY=0,macroPlaySpeed=1.0,chatSpamText="gg",chatSpamInterval=1,traitTargets={},autoWinSlots={},autoWinAutoPlayGame=true,autoWinEnabled=false,autoWinSlotDelay=0.5,autoVoteOnSpawn=false,collectAutoStart=false,autoUpgradeEnabled=false,autoUpgradeInterval=2,optImages=false,optImageBtns=false,optCorners=false,optStrokes=false,optGradients=false,optHideGuis=false,clickerBest=0,reactionBest=9999,tetrisBest=0,otherTheme="None",otherThemeGuis={},globalChatName=""}
for role in pairs(ROLE_DEFAULTS) do Defaults["color_"..role]=ROLE_DEFAULTS[role] end
local Config={values={}}
local function cfgGet(k) return Config.values[k]~=nil and Config.values[k] or Defaults[k] end
local function cfgSet(k,v) Config.values[k]=v;Config.save() end
function Config.save() if not writefile then return false end;return pcall(function() writefile(CONFIG_FILE,HttpService:JSONEncode(Config.values)) end) end
function Config.load() for k,v in pairs(Defaults) do if type(v)=="table" then local c={};for kk,vv in pairs(v) do c[kk]=vv end;Config.values[k]=c else Config.values[k]=v end end;if not (readfile and isfile) then return false end;local ok,data=pcall(function() if isfile(CONFIG_FILE) then return HttpService:JSONDecode(readfile(CONFIG_FILE)) end end);if ok and type(data)=="table" then for k,v in pairs(data) do if Defaults[k]~=nil then Config.values[k]=v end end end end
function Config.reset() for k,v in pairs(Defaults) do if type(v)=="table" then local c={};for kk,vv in pairs(v) do c[kk]=vv end;Config.values[k]=c else Config.values[k]=v end end;Config.save() end
function Config.export() return HttpService:JSONEncode(Config.values) end
function Config.import(json) local ok,data=pcall(HttpService.JSONDecode,HttpService,json);if not ok or type(data)~="table" then return false end;for k,v in pairs(data) do if Defaults[k]~=nil then Config.values[k]=v end end;Config.save();return true end
Config.load()
local C={}
for role,rgb in pairs(ROLE_DEFAULTS) do local c=cfgGet("color_"..role) or rgb;if type(c)=="table" and #c==3 then C[role]=Color3.fromRGB(c[1],c[2],c[3]) else C[role]=Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end end

-- ================= MACRO =================
local Macro={data={},events={},recording=false,playing=false,autoPlayOnSpawn=false,playMouseEvents=false,playSpeed=tonumber(cfgGet("macroPlaySpeed")) or 1.0,recordInterval=0.05,maxDuration=9999,_recordConn=nil,_beganConn=nil,_endedConn=nil,_playToken=0,_startTime=0,_origCamType=nil,_autoPlayToken=0}
local function macroGetRoot() local ch=LP.Character;return ch and ch:FindFirstChild("HumanoidRootPart") end
local function macroWaitRoot(t) t=t or 6;local d=tick()+t;while tick()<d do local r=macroGetRoot();if r then return r end;task.wait(0.2) end end
local function macroAddInput(input,state_) if not Macro.recording then return end;local now=tick()-Macro._startTime;if now>Macro.maxDuration then return end;local kind,code,x,y;local uit=input.UserInputType;if uit==Enum.UserInputType.Keyboard then kind,code="key",input.KeyCode.Name elseif uit==Enum.UserInputType.MouseButton1 then kind,code="mouse",0;x,y=input.Position.X,input.Position.Y elseif uit==Enum.UserInputType.MouseButton2 then kind,code="mouse",1;x,y=input.Position.X,input.Position.Y elseif uit==Enum.UserInputType.MouseButton3 then kind,code="mouse",2;x,y=input.Position.X,input.Position.Y else return end;table.insert(Macro.events,{t=now,kind=kind,code=code,state=state_,x=x,y=y}) end
local function macroRestoreCamera() local cm=workspace.CurrentCamera;if cm and Macro._origCamType then pcall(function() cm.CameraType=Macro._origCamType end) end;Macro._origCamType=nil end
local function macroForceScriptableCamera() local cm=workspace.CurrentCamera;if cm then Macro._origCamType=cm.CameraType;pcall(function() cm.CameraType=Enum.CameraType.Scriptable end) end end
function Macro.save() if not writefile then return end;return pcall(function() writefile(MACRO_FILE,HttpService:JSONEncode({data=Macro.data,events=Macro.events,autoPlayOnSpawn=Macro.autoPlayOnSpawn,playMouseEvents=Macro.playMouseEvents,playSpeed=Macro.playSpeed})) end) end
function Macro.load() if not (readfile and isfile) then return end;local ok,parsed=pcall(function() if isfile(MACRO_FILE) then return HttpService:JSONDecode(readfile(MACRO_FILE)) end end);if ok and type(parsed)=="table" then Macro.data=type(parsed.data)=="table" and parsed.data or {};Macro.events=type(parsed.events)=="table" and parsed.events or {};Macro.autoPlayOnSpawn=parsed.autoPlayOnSpawn==true;Macro.playMouseEvents=parsed.playMouseEvents==true;Macro.playSpeed=tonumber(parsed.playSpeed) or 1.0 end end
function Macro.clear() Macro.data={};Macro.events={};Macro.save() end
function Macro.startRecording() if Macro.recording then return false,"already recording" end;local rt=macroWaitRoot(6);if not rt then return false,"no root" end;if not workspace.CurrentCamera then return false,"no cam" end;Macro.data={};Macro.events={};Macro.recording=true;Macro._startTime=tick();if Macro._recordConn then Macro._recordConn:Disconnect() end;if Macro._beganConn then Macro._beganConn:Disconnect() end;if Macro._endedConn then Macro._endedConn:Disconnect() end;local lastT=-math.huge;Macro._recordConn=RunService.Heartbeat:Connect(function() if not Macro.recording then return end;local r=macroGetRoot();if not r then return end;local now=tick()-Macro._startTime;if now>=Macro.maxDuration then Macro.stopRecording();return end;if now-lastT<Macro.recordInterval then return end;lastT=now;local cam=workspace.CurrentCamera;table.insert(Macro.data,{t=now,c={r.CFrame:GetComponents()},cam=cam and {cam.CFrame:GetComponents()} or nil}) end);Macro._beganConn=UIS.InputBegan:Connect(function(input) macroAddInput(input,true) end);Macro._endedConn=UIS.InputEnded:Connect(function(input) macroAddInput(input,false) end);return true end
function Macro.stopRecording() Macro.recording=false;if Macro._recordConn then Macro._recordConn:Disconnect();Macro._recordConn=nil end;if Macro._beganConn then Macro._beganConn:Disconnect();Macro._beganConn=nil end;if Macro._endedConn then Macro._endedConn:Disconnect();Macro._endedConn=nil end;Macro.save() end
function Macro.play() if Macro.playing then Macro.playing=false;Macro._playToken+=1;macroRestoreCamera() end;if #Macro.data<2 then return false,"no data" end;local rt=macroWaitRoot(6);if not rt then return false,"no root" end;if not workspace.CurrentCamera then return false,"no cam" end;Macro.playing=true;Macro._playToken+=1;local myToken=Macro._playToken;local speed=math.clamp(tonumber(Macro.playSpeed) or 1,0.1,5);local allowMouse=Macro.playMouseEvents;local offX=tonumber(cfgGet("macroMouseOffsetX")) or 0;local offY=tonumber(cfgGet("macroMouseOffsetY")) or 0;macroForceScriptableCamera();local tl={};for _,f in ipairs(Macro.data) do if type(f)=="table" and f.t and f.c then table.insert(tl,{t=f.t,kind="cframe",c=f.c,cam=f.cam}) end end;for _,ev in ipairs(Macro.events) do if type(ev)=="table" and ev.t then if ev.kind~="mouse" or allowMouse then table.insert(tl,{t=ev.t,kind=ev.kind,code=ev.code,state=ev.state,x=ev.x,y=ev.y}) end end end;table.sort(tl,function(a,b) return (a.t or 0)<(b.t or 0) end);task.spawn(function() pcall(function() local startReal=tick();for _,item in ipairs(tl) do if not Macro.playing or Macro._playToken~=myToken then return end;local target=startReal+((item.t or 0)/speed);local now=tick();if target>now then task.wait(target-now) end;if not Macro.playing or Macro._playToken~=myToken then return end;if item.kind=="cframe" then local c=item.c;if type(c)=="table" and #c>=12 then local rt2=macroGetRoot();if not rt2 then return end;pcall(function() rt2.CFrame=CFrame.new(c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12]) end) end;local cc=item.cam;if type(cc)=="table" and #cc>=12 then local cm=workspace.CurrentCamera;if cm then pcall(function() cm.CFrame=CFrame.new(cc[1],cc[2],cc[3],cc[4],cc[5],cc[6],cc[7],cc[8],cc[9],cc[10],cc[11],cc[12]) end) end end elseif item.kind=="key" then local kc=Enum.KeyCode[item.code];if kc then pcall(function() VIM:SendKeyEvent(item.state,kc,false,game) end) end elseif item.kind=="mouse" and allowMouse then pcall(function() VIM:SendMouseButtonEvent((item.x or 0)+offX,(item.y or 0)+offY,item.code or 0,item.state,game,0) end) end end end);if Macro._playToken==myToken then Macro.playing=false;macroRestoreCamera() end end);return true end
function Macro.stop() Macro.playing=false;Macro._playToken+=1;macroRestoreCamera() end
local function macroAutoPlayTry() task.spawn(function() if not Macro.autoPlayOnSpawn or #Macro.data<2 or Macro.playing then return end;Macro._autoPlayToken+=1;local myAuto=Macro._autoPlayToken;local deadline=tick()+20;while tick()<deadline do if Macro._autoPlayToken~=myAuto or Macro.playing or not Macro.autoPlayOnSpawn then return end;local rt=macroGetRoot();local ch=LP.Character;local hum=ch and ch:FindFirstChildOfClass("Humanoid");if rt and hum and hum.Health>0 then task.wait(0.5);if Macro._autoPlayToken~=myAuto or Macro.playing or not Macro.autoPlayOnSpawn then return end;Macro.play();return end;task.wait(0.3) end end) end
Macro.load()
LP.CharacterAdded:Connect(function() if Macro.playing then Macro.playing=false;Macro._playToken+=1;macroRestoreCamera() end;macroAutoPlayTry() end)

local state={shuttingDown=false,running={sell=false,box=false,auto100=false,auto200=false,auto300=false,trait=false,autoE=false,autoClicker=false,autoJump=false,antiAfk=false,autoWin=false,hideBox=false,confetti=false,spawnBusy=false,chatSpam=false,collectLoop=false,autoUpgrade=false},stats={sold=0,startTime=tick()},selectedTower=nil,selectedPlayer=nil}
local function detectDevice() local t,k=UIS.TouchEnabled,UIS.KeyboardEnabled;if t and not k then local c=workspace.CurrentCamera;return ((c and c.ViewportSize.X or 0)>=900) and "tablet" or "mobile" end;return k and "desktop" or "mobile" end
local DEVICE=detectDevice()
local Scale=Instance.new("UIScale")
local function computeScale() local cam=workspace.CurrentCamera;if not cam then return 1 end;local v=cam.ViewportSize;local s=math.min((v.X-40)/820,(v.Y-60)/560);if DEVICE=="mobile" then return math.clamp(s,0.42,0.88) elseif DEVICE=="tablet" then return math.clamp(s,0.58,1) end;return math.clamp(s,0.72,1) end
local function updateScale() Scale.Scale=computeScale() end
local function Corner(o,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 10);c.Parent=o end
local function Stroke(o,col,th,tr) local s=Instance.new("UIStroke");s.Color=col or C.line;s.Thickness=th or 1;s.Transparency=tr or 0;s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border;s.Parent=o;return s end
local function Tween(o,p,d) local t=TweenService:Create(o,TweenInfo.new(d or 0.18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p);t:Play();return t end
local function Register(o,role,prop) prop=prop or "BackgroundColor3";o[prop]=C[role];o:SetAttribute("_r",role);o:SetAttribute("_p",prop);return o end
local function hexOf(c) return string.format("#%02X%02X%02X",math.floor(c.R*255+.5),math.floor(c.G*255+.5),math.floor(c.B*255+.5)) end
local function rgbOf(c) return {math.floor(c.R*255+.5),math.floor(c.G*255+.5),math.floor(c.B*255+.5)} end
local function FindDescendant(root,name) if not root then return end;for _,i in ipairs(root:GetDescendants()) do if i.Name==name then return i end end end
local function getRemote(svc,rem,grp) grp=grp or "RF";local ok,r=pcall(function() return RS:WaitForChild("Packages",8):WaitForChild("_Index",8):WaitForChild("sleitnick_knit@1.5.1",8):WaitForChild("knit",8):WaitForChild("Services",8):WaitForChild(svc,8):WaitForChild(grp,8):WaitForChild(rem,8) end);return ok and r or nil end
local function callRemote(r,...) if not r then return false,"no remote" end;if r:IsA("RemoteFunction") then return pcall(r.InvokeServer,r,...) end;if r:IsA("RemoteEvent") then return pcall(r.FireServer,r,...) end;return false,"unsupported" end
local function getSellFolder() local mg=PG:FindFirstChild("MainGUI");local m=mg and mg:FindFirstChild("Middle");local i=m and m:FindFirstChild("Inventory");return i and i:FindFirstChild("Tower") end
local function getTraitFolder() local mg=PG:FindFirstChild("MainGUI");local m=mg and mg:FindFirstChild("Middle");local i=m and m:FindFirstChild("Inventory");local t=i and i:FindFirstChild("TowerInventory");local b=t and t:FindFirstChild("Background");return b and b:FindFirstChild("Tower") end
local function isTower(o) return o and o:IsA("ImageButton") and o.Name:match("^%d+_%d+$")~=nil end
local function towerDisplayName(o) for _,v in ipairs(o:GetDescendants()) do if v:IsA("TextLabel") and v.Text~="" and v.Name~="Count" then return v.Text end end;return o.Name end
local refreshSlots,sendUnitToSlot,runAutoWin,startCollectLoop,fireVote
local startTetris,stopTetris,applyOtherTheme,restoreOtherTheme
local pNewDeck,pHandRank,chatGui,hasHttp,openGlobalChat
local stopChatPoll,stopLiveView
local startAnimatedTheme,stopAnimatedTheme,stopOtherRainbow
local PRESETS,ANIMATED
local function getSlots() local s=cfgGet("autoWinSlots");if type(s)~="table" then s={};cfgSet("autoWinSlots",s) end;return s end
local repaintAll,applyNavActive,updateBgImage
hasHttp=function() return ((syn and syn.request) or http_request or request or (http and http.request))~=nil end

-- GUI ROOT
local GUI=Instance.new("ScreenGui");GUI.Name=HUB_FOLDER;GUI.ResetOnSpawn=false;GUI.IgnoreGuiInset=true;GUI.DisplayOrder=100;GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;GUI.Parent=PG
Scale.Parent=GUI;updateScale()
local Main=Instance.new("Frame");Main.Size=UDim2.fromOffset(820,560);Main.Position=UDim2.new(0.5,-410,0.5,-280);Main.BackgroundTransparency=1;Main.BorderSizePixel=0;Main.ClipsDescendants=true;Main.ZIndex=1;Main.Parent=GUI;Corner(Main,18)
local Shadow=Instance.new("Frame");Shadow.Size=UDim2.new(1,0,1,0);Shadow.BackgroundColor3=Color3.new(0,0,0);Shadow.BackgroundTransparency=0.55;Shadow.BorderSizePixel=0;Shadow.ZIndex=0;Shadow.Parent=Main;Corner(Shadow,18)
local BGFrame=Instance.new("Frame");BGFrame.Size=UDim2.new(1,0,1,0);BGFrame.BorderSizePixel=0;BGFrame.ZIndex=1;BGFrame.Parent=Main;Corner(BGFrame,18);Register(BGFrame,"bg")
local BGImage=Instance.new("ImageLabel");BGImage.Size=UDim2.new(1,0,1,0);BGImage.BackgroundTransparency=1;BGImage.Image="";BGImage.ScaleType=Enum.ScaleType.Crop;BGImage.ZIndex=1;BGImage.Parent=Main;Corner(BGImage,18)
local BGOverlay=Instance.new("Frame");BGOverlay.Size=UDim2.new(1,0,1,0);BGOverlay.BackgroundTransparency=0.55;BGOverlay.BorderSizePixel=0;BGOverlay.ZIndex=1;BGOverlay.Visible=false;BGOverlay.Parent=Main;Corner(BGOverlay,18);Register(BGOverlay,"bg")
local AccentBar=Instance.new("Frame");AccentBar.Size=UDim2.new(1,0,0,3);AccentBar.BorderSizePixel=0;AccentBar.ZIndex=5;AccentBar.Parent=Main;Register(AccentBar,"blue")
local AccentGrad=Instance.new("UIGradient");AccentGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.purple),ColorSequenceKeypoint.new(0.5,C.blue),ColorSequenceKeypoint.new(1,C.orange)});AccentGrad.Parent=AccentBar
local Sidebar=Instance.new("Frame");Sidebar.Size=UDim2.new(0,185,1,0);Sidebar.BorderSizePixel=0;Sidebar.BackgroundTransparency=0.1;Sidebar.ZIndex=2;Sidebar.ClipsDescendants=true;Sidebar.Parent=Main;Register(Sidebar,"panel");Corner(Sidebar,18)
local SideBGImage=Instance.new("ImageLabel");SideBGImage.Size=UDim2.new(1,0,1,0);SideBGImage.BackgroundTransparency=1;SideBGImage.Image="";SideBGImage.ScaleType=Enum.ScaleType.Crop;SideBGImage.ZIndex=1;SideBGImage.Visible=false;SideBGImage.Parent=Sidebar
local SideBGOverlay=Instance.new("Frame");SideBGOverlay.Size=UDim2.new(1,0,1,0);SideBGOverlay.BackgroundTransparency=0.55;SideBGOverlay.BorderSizePixel=0;SideBGOverlay.ZIndex=2;SideBGOverlay.Visible=false;SideBGOverlay.Parent=Sidebar;Register(SideBGOverlay,"bg")
local SideGrad=Instance.new("Frame");SideGrad.Size=UDim2.new(1,0,0,80);SideGrad.BackgroundTransparency=0.85;SideGrad.BorderSizePixel=0;SideGrad.ZIndex=3;SideGrad.Parent=Sidebar;Register(SideGrad,"blue")
local SGGrad=Instance.new("UIGradient");SGGrad.Rotation=90;SGGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.purple),ColorSequenceKeypoint.new(1,C.panel)});SGGrad.Parent=SideGrad
local Logo=Instance.new("TextLabel");Logo.Position=UDim2.fromOffset(14,16);Logo.Size=UDim2.new(1,-22,0,26);Logo.BackgroundTransparency=1;Logo.Text=HUB_SHORT;Logo.Font=Enum.Font.GothamBold;Logo.TextSize=18;Logo.TextXAlignment=Enum.TextXAlignment.Left;Logo.ZIndex=4;Logo.Parent=Sidebar;Register(Logo,"white","TextColor3")
local Version=Instance.new("TextLabel");Version.Position=UDim2.fromOffset(15,42);Version.Size=UDim2.new(1,-22,0,14);Version.BackgroundTransparency=1;Version.Text="v10.1 GOLD";Version.Font=Enum.Font.GothamMedium;Version.TextSize=8;Version.TextXAlignment=Enum.TextXAlignment.Left;Version.ZIndex=4;Version.Parent=Sidebar;Register(Version,"blue","TextColor3")
local DeviceLabel=Instance.new("TextLabel");DeviceLabel.Position=UDim2.fromOffset(15,56);DeviceLabel.Size=UDim2.new(1,-22,0,14);DeviceLabel.BackgroundTransparency=1;DeviceLabel.Text=string.upper(DEVICE).." MODE";DeviceLabel.Font=Enum.Font.Gotham;DeviceLabel.TextSize=9;DeviceLabel.TextXAlignment=Enum.TextXAlignment.Left;DeviceLabel.ZIndex=4;DeviceLabel.Parent=Sidebar;Register(DeviceLabel,"muted","TextColor3")
local Nav=Instance.new("ScrollingFrame");Nav.Position=UDim2.fromOffset(12,86);Nav.Size=UDim2.new(1,-24,1,-140);Nav.BackgroundTransparency=1;Nav.BorderSizePixel=0;Nav.ScrollBarThickness=2;Nav.ScrollBarImageColor3=C.blue;Nav.CanvasSize=UDim2.new(0,0,0,0);Nav.AutomaticCanvasSize=Enum.AutomaticSize.Y;Nav.ZIndex=3;Nav.Parent=Sidebar
local NavLayout=Instance.new("UIListLayout");NavLayout.Padding=UDim.new(0,5);NavLayout.SortOrder=Enum.SortOrder.LayoutOrder;NavLayout.Parent=Nav
local StatusLabel=Instance.new("TextLabel");StatusLabel.Position=UDim2.new(0,14,1,-46);StatusLabel.Size=UDim2.new(1,-28,0,34);StatusLabel.BackgroundTransparency=1;StatusLabel.Text="● Ready";StatusLabel.Font=Enum.Font.GothamMedium;StatusLabel.TextSize=10;StatusLabel.TextWrapped=true;StatusLabel.TextXAlignment=Enum.TextXAlignment.Left;StatusLabel.ZIndex=4;StatusLabel.Parent=Sidebar;Register(StatusLabel,"green","TextColor3")
local Content=Instance.new("Frame");Content.Position=UDim2.fromOffset(185,0);Content.Size=UDim2.new(1,-185,1,0);Content.BackgroundTransparency=1;Content.ZIndex=2;Content.ClipsDescendants=true;Content.Parent=Main
local ContentBGImage=Instance.new("ImageLabel");ContentBGImage.Size=UDim2.new(1,0,1,0);ContentBGImage.BackgroundTransparency=1;ContentBGImage.Image="";ContentBGImage.ScaleType=Enum.ScaleType.Crop;ContentBGImage.ZIndex=1;ContentBGImage.Visible=false;ContentBGImage.Parent=Content
local ContentBGOverlay=Instance.new("Frame");ContentBGOverlay.Size=UDim2.new(1,0,1,0);ContentBGOverlay.BackgroundTransparency=0.55;ContentBGOverlay.BorderSizePixel=0;ContentBGOverlay.ZIndex=2;ContentBGOverlay.Visible=false;ContentBGOverlay.Parent=Content;Register(ContentBGOverlay,"bg")
local Topbar=Instance.new("Frame");Topbar.Size=UDim2.new(1,0,0,64);Topbar.BackgroundTransparency=1;Topbar.ZIndex=3;Topbar.Parent=Content
local Heading=Instance.new("TextLabel");Heading.Position=UDim2.fromOffset(22,12);Heading.Size=UDim2.new(1,-140,0,28);Heading.BackgroundTransparency=1;Heading.Text="Dashboard";Heading.Font=Enum.Font.GothamBold;Heading.TextSize=20;Heading.TextXAlignment=Enum.TextXAlignment.Left;Heading.ZIndex=4;Heading.Parent=Topbar;Register(Heading,"white","TextColor3")
local Subtitle=Instance.new("TextLabel");Subtitle.Position=UDim2.fromOffset(23,40);Subtitle.Size=UDim2.new(1,-140,0,16);Subtitle.BackgroundTransparency=1;Subtitle.Text=HUB_SHORT.." / DASHBOARD";Subtitle.Font=Enum.Font.Gotham;Subtitle.TextSize=10;Subtitle.TextXAlignment=Enum.TextXAlignment.Left;Subtitle.ZIndex=4;Subtitle.Parent=Topbar;Register(Subtitle,"muted","TextColor3")
local function topButton(text,x,role) local b=Instance.new("TextButton");b.Size=UDim2.fromOffset(32,30);b.Position=UDim2.new(1,x,0,16);b.BorderSizePixel=0;b.Text=text;b.TextColor3=C.white;b.Font=Enum.Font.GothamBold;b.TextSize=13;b.ZIndex=4;b.Parent=Topbar;Corner(b,9);Register(b,role);Stroke(b,C.line,1,0.4);return b end
local MinButton=topButton("—",-78,"card");local CloseButton=topButton("×",-40,"red")
local Restore=Instance.new("TextButton");Restore.Size=UDim2.fromOffset(185,44);Restore.Position=UDim2.new(1,-200,0,18);Restore.BorderSizePixel=0;Restore.Text=HUB_SHORT.." +";Restore.TextColor3=C.white;Restore.Font=Enum.Font.GothamBold;Restore.TextSize=12;Restore.Visible=false;Restore.ZIndex=5;Restore.Parent=GUI;Corner(Restore,12);Register(Restore,"blue");Stroke(Restore,C.line,1,0.4)
MinButton.Activated:Connect(function() Main.Visible=false;Restore.Visible=true end)
Restore.Activated:Connect(function() Main.Visible=true;Restore.Visible=false;updateScale() end)
local function SetStatus(msg,color) StatusLabel.Text="● "..tostring(msg);StatusLabel.TextColor3=color or C.muted end

local pages,navButtons={}, {};local currentPage="Dashboard"
local function NewPage(name) local page=Instance.new("ScrollingFrame");page.Name=name:gsub("%s+","").."Page";page.Position=UDim2.fromOffset(18,72);page.Size=UDim2.new(1,-36,1,-88);page.BackgroundTransparency=1;page.BorderSizePixel=0;page.ScrollBarThickness=3;page.ScrollBarImageColor3=C.blue;page.AutomaticCanvasSize=Enum.AutomaticSize.Y;page.CanvasSize=UDim2.new(0,0,0,0);page.Visible=false;page.ZIndex=3;page.Parent=Content;local l=Instance.new("UIListLayout");l.Padding=UDim.new(0,12);l.SortOrder=Enum.SortOrder.LayoutOrder;l.Parent=page;pages[name]=page;return page end
applyNavActive=function(name) for n,b in pairs(navButtons) do local active=(n==name);b.BackgroundColor3=active and C.blue or C.card;b.TextColor3=active and C.white or C.muted;b:SetAttribute("_r",active and "blue" or "card");b:SetAttribute("_p","BackgroundColor3") end end
local function ShowPage(name) if not pages[name] then return end;currentPage=name;for n,p in pairs(pages) do p.Visible=(n==name) end;applyNavActive(name);Heading.Text=name;Subtitle.Text=HUB_SHORT.." / "..string.upper(name) end
local function AddNav(name,order,symbol) local b=Instance.new("TextButton");b.Size=UDim2.new(1,0,0,34);b.BorderSizePixel=0;b.Text="  "..(symbol or "•").."   "..name;b.TextColor3=C.muted;b.Font=Enum.Font.GothamMedium;b.TextSize=11;b.TextXAlignment=Enum.TextXAlignment.Left;b.LayoutOrder=order;b.AutoButtonColor=false;b.ZIndex=4;b.Parent=Nav;Corner(b,9);Register(b,"card");Stroke(b,C.line,1,0.5);b.MouseEnter:Connect(function() if currentPage~=name then Tween(b,{BackgroundColor3=C.hover},0.12) end end);b.MouseLeave:Connect(function() if currentPage~=name then Tween(b,{BackgroundColor3=C.card},0.12) end end);b.Activated:Connect(function() ShowPage(name) end);navButtons[name]=b end
local function Section(parent,title,subtitle) local f=Instance.new("Frame");f.Size=UDim2.new(1,-3,0,70);f.BorderSizePixel=0;f.ZIndex=3;f.Parent=parent;Corner(f,12);Register(f,"card");Stroke(f,C.line,1,0.35);local a=Instance.new("Frame");a.Position=UDim2.fromOffset(0,12);a.Size=UDim2.new(0,4,0,46);a.BorderSizePixel=0;a.Parent=f;Corner(a,2);Register(a,"blue");local tl=Instance.new("TextLabel");tl.Position=UDim2.fromOffset(16,10);tl.Size=UDim2.new(1,-28,0,24);tl.BackgroundTransparency=1;tl.Text=title;tl.Font=Enum.Font.GothamBold;tl.TextSize=14;tl.TextXAlignment=Enum.TextXAlignment.Left;tl.Parent=f;Register(tl,"white","TextColor3");local sb=Instance.new("TextLabel");sb.Position=UDim2.fromOffset(16,36);sb.Size=UDim2.new(1,-28,0,20);sb.BackgroundTransparency=1;sb.Text=subtitle or "";sb.Font=Enum.Font.Gotham;sb.TextSize=10;sb.TextXAlignment=Enum.TextXAlignment.Left;sb.TextWrapped=true;sb.Parent=f;Register(sb,"muted","TextColor3");return f end
local function Label(parent,text,roleOrColor) local l=Instance.new("TextLabel");l.Size=UDim2.new(1,-3,0,22);l.BackgroundTransparency=1;l.Text=text;l.Font=Enum.Font.GothamSemibold;l.TextSize=12;l.TextXAlignment=Enum.TextXAlignment.Left;l.Parent=parent;if type(roleOrColor)=="string" then Register(l,roleOrColor,"TextColor3") else l.TextColor3=roleOrColor or C.white end;return l end

-- Кнопка с анимацией
local function Button(parent,text,role,callback) 
    role=role or "blue"
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1,-3,0,45)
    b.BorderSizePixel=0
    b.Text="   "..text
    b.TextColor3=C.white
    b.Font=Enum.Font.GothamSemibold
    b.TextSize=12
    b.TextXAlignment=Enum.TextXAlignment.Left
    b.AutoButtonColor=false
    b.Parent=parent
    Corner(b,11)
    Register(b,role)
    Stroke(b,C.line,1,0.5)
    
    b.MouseEnter:Connect(function() Tween(b,{BackgroundColor3=C.hover,Size=UDim2.new(1,4,0,45)},0.15) end)
    b.MouseLeave:Connect(function() Tween(b,{BackgroundColor3=C[role] or C.blue,Size=UDim2.new(1,-3,0,45)},0.15) end)
    b.MouseButton1Down:Connect(function() Tween(b,{Size=UDim2.new(0.98,0,0,43)},0.08) end)
    b.MouseButton1Up:Connect(function() Tween(b,{Size=UDim2.new(1,-3,0,45)},0.08) end)
    b.Activated:Connect(function() if callback then local ok,err=pcall(callback);if not ok then SetStatus("Error: "..tostring(err),C.red) end end end)
    return b 
end

local function Field(parent,title,placeholder,default,configKey) local h=Instance.new("Frame");h.Size=UDim2.new(1,-3,0,60);h.BackgroundTransparency=1;h.Parent=parent;local lb=Instance.new("TextLabel");lb.Size=UDim2.new(1,0,0,20);lb.BackgroundTransparency=1;lb.Text=title;lb.Font=Enum.Font.GothamMedium;lb.TextSize=10;lb.TextXAlignment=Enum.TextXAlignment.Left;lb.Parent=h;Register(lb,"muted","TextColor3");local init=default or "";if configKey then init=tostring(cfgGet(configKey)) end;local input=Instance.new("TextBox");input.Position=UDim2.fromOffset(0,22);input.Size=UDim2.new(1,0,0,34);input.BorderSizePixel=0;input.Text=init;input.PlaceholderText=placeholder or "Enter...";input.PlaceholderColor3=C.muted;input.TextColor3=C.white;input.Font=Enum.Font.Gotham;input.TextSize=11;input.ClearTextOnFocus=false;input.TextXAlignment=Enum.TextXAlignment.Left;input.Parent=h;Corner(input,9);Register(input,"panel");Stroke(input,C.line,1,0.3);if configKey then input.FocusLost:Connect(function() local raw=input.Text;local num=tonumber(raw);if type(cfgGet(configKey))=="number" and not num then input.Text=tostring(cfgGet(configKey));return end;cfgSet(configKey,num or raw);SetStatus(title.." = "..tostring(num or raw),C.green) end) end;return input end
local function Toggle(parent,title,description,callback,initialState) local f=Instance.new("Frame");f.Size=UDim2.new(1,-3,0,60);f.BorderSizePixel=0;f.Parent=parent;Corner(f,11);Register(f,"card");Stroke(f,C.line,1,0.35);local tl=Instance.new("TextLabel");tl.Position=UDim2.fromOffset(12,6);tl.Size=UDim2.new(1,-100,0,22);tl.BackgroundTransparency=1;tl.Text=title;tl.Font=Enum.Font.GothamSemibold;tl.TextSize=11;tl.TextXAlignment=Enum.TextXAlignment.Left;tl.Parent=f;Register(tl,"white","TextColor3");local sb=Instance.new("TextLabel");sb.Position=UDim2.fromOffset(12,30);sb.Size=UDim2.new(1,-100,0,20);sb.BackgroundTransparency=1;sb.Text=description or "";sb.Font=Enum.Font.Gotham;sb.TextSize=9;sb.TextXAlignment=Enum.TextXAlignment.Left;sb.TextWrapped=true;sb.Parent=f;Register(sb,"muted","TextColor3");local enabled=initialState==true;local b=Instance.new("TextButton");b.Size=UDim2.fromOffset(66,30);b.Position=UDim2.new(1,-78,0.5,-15);b.BorderSizePixel=0;b.Text=enabled and "ON" or "OFF";b.TextColor3=C.white;b.Font=Enum.Font.GothamBold;b.TextSize=10;b.Parent=f;Corner(b,9);b.BackgroundColor3=enabled and C.green or C.red;b:SetAttribute("_r",enabled and "green" or "red");b.Activated:Connect(function() enabled=not enabled;b.Text=enabled and "ON" or "OFF";b.BackgroundColor3=enabled and C.green or C.red;b:SetAttribute("_r",enabled and "green" or "red");if callback then local ok,err=pcall(callback,enabled);if not ok then SetStatus("Error: "..tostring(err),C.red) end end end);return f end
local function SearchSelect(parent,title,optionsProvider,configKey,onSelect) local h=Instance.new("Frame");h.Size=UDim2.new(1,-3,0,60);h.BackgroundTransparency=1;h.Parent=parent;local lb=Instance.new("TextLabel");lb.Size=UDim2.new(1,0,0,20);lb.BackgroundTransparency=1;lb.Text=title;lb.Font=Enum.Font.GothamMedium;lb.TextSize=10;lb.TextXAlignment=Enum.TextXAlignment.Left;lb.Parent=h;Register(lb,"muted","TextColor3");local current=configKey and cfgGet(configKey) or nil;local btn=Instance.new("TextButton");btn.Position=UDim2.fromOffset(0,22);btn.Size=UDim2.new(1,0,0,34);btn.BorderSizePixel=0;btn.Text="  "..(current and tostring(current) or "Select...").."  ▼";btn.TextColor3=C.white;btn.Font=Enum.Font.Gotham;btn.TextSize=11;btn.TextXAlignment=Enum.TextXAlignment.Left;btn.AutoButtonColor=false;btn.Parent=h;Corner(btn,9);Register(btn,"card");Stroke(btn,C.line,1,0.3);local panel=Instance.new("Frame");panel.Position=UDim2.fromOffset(0,60);panel.Size=UDim2.new(1,0,0,180);panel.BorderSizePixel=0;panel.Visible=false;panel.Parent=h;Corner(panel,9);Register(panel,"panel");Stroke(panel,C.line,1,0.35);local si=Instance.new("TextBox");si.Position=UDim2.fromOffset(5,5);si.Size=UDim2.new(1,-10,0,28);si.BorderSizePixel=0;si.Text="";si.PlaceholderText="Search...";si.PlaceholderColor3=C.muted;si.TextColor3=C.white;si.Font=Enum.Font.Gotham;si.TextSize=11;si.TextXAlignment=Enum.TextXAlignment.Left;si.ClearTextOnFocus=false;si.Parent=panel;Corner(si,7);Register(si,"card");local list=Instance.new("ScrollingFrame");list.Position=UDim2.fromOffset(5,38);list.Size=UDim2.new(1,-10,1,-43);list.BackgroundTransparency=1;list.BorderSizePixel=0;list.ScrollBarThickness=3;list.ScrollBarImageColor3=C.blue;list.CanvasSize=UDim2.new(0,0,0,0);list.AutomaticCanvasSize=Enum.AutomaticSize.Y;list.Parent=panel;local ll=Instance.new("UIListLayout");ll.Padding=UDim.new(0,3);ll.Parent=list;local function rebuild() for _,c in ipairs(list:GetChildren()) do if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end end;local opts=type(optionsProvider)=="function" and optionsProvider() or optionsProvider or {};local q=si.Text:lower();local n=0;for _,opt in ipairs(opts) do local s=tostring(opt);if q=="" or s:lower():find(q,1,true) then n+=1;if n<=100 then local e=Instance.new("TextButton");e.Size=UDim2.new(1,0,0,26);e.BorderSizePixel=0;e.Text="  "..s;e.TextColor3=C.white;e.Font=Enum.Font.Gotham;e.TextSize=10;e.TextXAlignment=Enum.TextXAlignment.Left;e.Parent=list;Corner(e,6);Register(e,(current==opt) and "blue" or "card");e.Activated:Connect(function() current=opt;btn.Text="  "..s.."  ▼";panel.Visible=false;h.Size=UDim2.new(1,-3,0,60);if configKey then cfgSet(configKey,opt) end;if onSelect then onSelect(opt) end;SetStatus(title..": "..s,C.green) end) end end end;if n==0 then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,0,0,24);e.BackgroundTransparency=1;e.Text="No results";e.Font=Enum.Font.Gotham;e.TextSize=10;e.Parent=list;Register(e,"muted","TextColor3") end end;btn.Activated:Connect(function() panel.Visible=not panel.Visible;h.Size=UDim2.new(1,-3,0,panel.Visible and 250 or 60);if panel.Visible then rebuild() end end);si:GetPropertyChangedSignal("Text"):Connect(rebuild);return {get=function() return current end,set=function(v) current=v;btn.Text="  "..tostring(v).."  ▼" end} end
local function ColorPicker(parent,title,role) local h=Instance.new("Frame");h.Size=UDim2.new(1,-3,0,94);h.BorderSizePixel=0;h.Parent=parent;Corner(h,11);Register(h,"card");Stroke(h,C.line,1,0.35);local lb=Instance.new("TextLabel");lb.Position=UDim2.fromOffset(12,6);lb.Size=UDim2.new(1,-100,0,20);lb.BackgroundTransparency=1;lb.Text=title.."  ("..role..")";lb.Font=Enum.Font.GothamSemibold;lb.TextSize=11;lb.TextXAlignment=Enum.TextXAlignment.Left;lb.Parent=h;Register(lb,"white","TextColor3");local prev=Instance.new("Frame");prev.Position=UDim2.new(1,-72,0,6);prev.Size=UDim2.fromOffset(60,20);prev.BorderSizePixel=0;prev.BackgroundColor3=C[role];prev.Parent=h;Corner(prev,5);Stroke(prev,C.line,1,0.5);local hex=Instance.new("TextBox");hex.Position=UDim2.fromOffset(12,32);hex.Size=UDim2.new(1,-24,0,26);hex.BorderSizePixel=0;hex.Text=hexOf(C[role]);hex.TextColor3=C.white;hex.PlaceholderText="#RRGGBB";hex.PlaceholderColor3=C.muted;hex.Font=Enum.Font.Code;hex.TextSize=11;hex.ClearTextOnFocus=false;hex.Parent=h;Corner(hex,7);Register(hex,"panel");Stroke(hex,C.line,1,0.25);local rgbH=Instance.new("Frame");rgbH.Position=UDim2.fromOffset(12,64);rgbH.Size=UDim2.new(1,-24,0,22);rgbH.BackgroundTransparency=1;rgbH.Parent=h;local boxes={};for i,ch in ipairs({"R","G","B"}) do local b=Instance.new("TextBox");b.Position=UDim2.new((i-1)/3,2,0,0);b.Size=UDim2.new(1/3,-4,1,0);b.BorderSizePixel=0;b.Text=tostring(rgbOf(C[role])[i]);b.PlaceholderText=ch;b.PlaceholderColor3=C.muted;b.TextColor3=C.white;b.Font=Enum.Font.Code;b.TextSize=11;b.ClearTextOnFocus=false;b.Parent=rgbH;Corner(b,6);Register(b,"panel");boxes[i]=b end;local function apply(col) C[role]=col;prev.BackgroundColor3=col;hex.Text=hexOf(col);local rgb=rgbOf(col);for i=1,3 do boxes[i].Text=tostring(rgb[i]) end;cfgSet("color_"..role,rgb);repaintAll() end;hex.FocusLost:Connect(function() local s=hex.Text:gsub("#","");if #s==6 and s:match("^%x+$") then apply(Color3.fromRGB(tonumber(s:sub(1,2),16) or 0,tonumber(s:sub(3,4),16) or 0,tonumber(s:sub(5,6),16) or 0)) else hex.Text=hexOf(C[role]) end end);for i=1,3 do boxes[i].FocusLost:Connect(function() local v=math.clamp(tonumber(boxes[i].Text) or 0,0,255);boxes[i].Text=tostring(v);local rgb=rgbOf(C[role]);rgb[i]=v;apply(Color3.fromRGB(rgb[1],rgb[2],rgb[3])) end) end end

repaintAll=function() for _,obj in ipairs(GUI:GetDescendants()) do local role=obj:GetAttribute("_r");if role and C[role] then local prop=obj:GetAttribute("_p") or "BackgroundColor3";pcall(function() obj[prop]=C[role] end) end end;AccentGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.purple),ColorSequenceKeypoint.new(0.5,C.blue),ColorSequenceKeypoint.new(1,C.green)});SGGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.purple),ColorSequenceKeypoint.new(1,C.panel)});SideGrad.BackgroundColor3=C.blue;applyNavActive(currentPage);updateBgImage() end
local function resolveBgSource(src) src=tostring(src or ""):gsub("^%s+",""):gsub("%s+$","");if src=="" then return nil,"empty" end;if src:match("^rbxassetid://%d+") then return src end;if src:match("^%d+$") then return "rbxassetid://"..src end;if src:match("^https?://") then if not (writefile and getcustomasset) then return nil,"URL needs writefile+getcustomasset" end;local cache="uplalan1_bg_"..tostring(#src)..".png";if not (isfile and isfile(cache)) then local body;local okReq=pcall(function() if syn and syn.request then body=syn.request({Url=src,Method="GET"}).Body elseif http and http.request then body=http.request({Url=src,Method="GET"}).Body elseif request then body=request({Url=src,Method="GET"}).Body elseif http_request then body=http_request({Url=src,Method="GET"}).Body elseif game.HttpGet then body=game:HttpGet(src) end end);if not (okReq and body and #body>0) then return nil,"URL download failed" end;pcall(writefile,cache,body) end;local okCA,a=pcall(getcustomasset,cache);if okCA and a then return a end;return nil,"getcustomasset failed" end;if isfile and isfile(src) then if not getcustomasset then return nil,"getcustomasset missing" end;local okCA,a=pcall(getcustomasset,src);if okCA and a then return a end;return nil,"getcustomasset failed" end;return nil,"file not found: "..src end
updateBgImage=function() local src=cfgGet("bgImage") or "";local target=cfgGet("bgTarget") or "main";BGImage.Image="";BGImage.Visible=false;BGOverlay.Visible=false;SideBGImage.Image="";SideBGImage.Visible=false;SideBGOverlay.Visible=false;ContentBGImage.Image="";ContentBGImage.Visible=false;ContentBGOverlay.Visible=false;Sidebar.BackgroundTransparency=0.1;Content.BackgroundTransparency=1;if src=="" then return end;local resolved,errMsg=resolveBgSource(src);if not resolved then SetStatus("BG: "..tostring(errMsg),C.red);return end;local fit=cfgGet("bgImageFit") or "crop";local scaleType=fit=="stretch" and Enum.ScaleType.Stretch or fit=="tile" and Enum.ScaleType.Tile or Enum.ScaleType.Crop;local trans=math.clamp(tonumber(cfgGet("bgImageTransparency")) or 0.4,0,1);local overlayT=math.clamp(tonumber(cfgGet("bgImageOverlay")) or 0.55,0,1);local useMain=(target=="main" or target=="both" or target=="all");local useSide=(target=="sidebar" or target=="both" or target=="all");local useContent=(target=="content" or target=="both" or target=="all");if useMain then BGImage.Image=resolved;BGImage.ImageTransparency=trans;BGImage.ScaleType=scaleType;BGImage.Visible=true;BGOverlay.BackgroundTransparency=overlayT;BGOverlay.Visible=true end;if useSide then SideBGImage.Image=resolved;SideBGImage.ImageTransparency=trans;SideBGImage.ScaleType=scaleType;SideBGImage.Visible=true;SideBGOverlay.BackgroundTransparency=overlayT;SideBGOverlay.Visible=true;Sidebar.BackgroundTransparency=0.45 end;if useContent then ContentBGImage.Image=resolved;ContentBGImage.ImageTransparency=trans;ContentBGImage.ScaleType=scaleType;ContentBGImage.Visible=true;ContentBGOverlay.BackgroundTransparency=overlayT;ContentBGOverlay.Visible=true end;SetStatus("BG applied ✓ ("..target..")",C.green) end

-- ================= PAGES =================
local dashboard=NewPage("Dashboard");local farm=NewPage("Auto Farm");local trait=NewPage("Trait Roller");local unitsPage=NewPage("Units")
local autoE=NewPage("Auto E");local trade=NewPage("Trade");local placer=NewPage("Tower Placer");local macro=NewPage("Macro")
local collect=NewPage("Collect");local minigames=NewPage("Minigames");local tetrisPg=NewPage("Block Blast");local globalChatPg=NewPage("Global Chat")
local liveViewPg=NewPage("Live View");local otherGui=NewPage("GUI Themer");local opti=NewPage("Optimization");local misc=NewPage("Misc");local extras=NewPage("Extras")
local themes=NewPage("Theme Studio");local settings=NewPage("Settings")
AddNav("Dashboard",1,"◆");AddNav("Auto Farm",2,"⚡");AddNav("Trait Roller",3,"✦");AddNav("Units",4,"👥");AddNav("Auto E",5,"◈");AddNav("Trade",6,"⇄");AddNav("Tower Placer",7,"🏗");AddNav("Macro",8,"⏺");AddNav("Collect",9,"🧲");AddNav("Minigames",10,"🎮");AddNav("Block Blast",11,"🧱");AddNav("Global Chat",12,"💬");AddNav("Live View",13,"👁");AddNav("GUI Themer",14,"🖌");AddNav("Optimization",15,"🧹");AddNav("Misc",16,"✧");AddNav("Extras",17,"★");AddNav("Theme Studio",18,"🎨");AddNav("Settings",19,"⚙")

-- ================= DASHBOARD =================
Section(dashboard,HUB_SHORT.." v10.5","Gold Edition · Animated")
Section(dashboard,"Authors","")
Label(dashboard,"  ◆  uplalan1  —  Full UI / Config / Auto Farm","blue")
Section(dashboard,"Device","")
Label(dashboard,"Detected: "..string.upper(DEVICE).."  |  Scale: "..string.format("%.2f",Scale.Scale),"orange")
Section(dashboard,"Quick Actions","")
Button(dashboard,"Teleport to Toilet Verse","purple",function() 
    local ok,err=pcall(function() TeleportService:Teleport(PLACE_ID,LP) end)
    if ok then SetStatus("Teleport requested",C.green) else SetStatus("Teleport failed: "..tostring(err),C.red) end 
end)
Button(dashboard,"Open Block Blast","orange",function() ShowPage("Block Blast") end)
Button(dashboard,"Open Global Chat","green",function() ShowPage("Global Chat");if openGlobalChat then openGlobalChat() end end)
Button(dashboard,"Open Live View","purple",function() ShowPage("Live View") end)
Button(dashboard,"Open Theme Studio","blue",function() ShowPage("Theme Studio") end)
Button(dashboard,"Stop All Loops","red",function() for k in pairs(state.running) do if type(state.running[k])=="boolean" then state.running[k]=false end end;Macro.stop();if stopTetris then pcall(stopTetris) end;if stopOtherRainbow then pcall(stopOtherRainbow) end;if stopChatPoll then pcall(stopChatPoll) end;if stopLiveView then pcall(stopLiveView) end;SetStatus("All loops stopped",C.green) end)

-- ================= AUTO FARM =================
Section(farm,"Statistics","")
local statsLabel=Label(farm,"Sold: 0  |  Time: 00:00","blue")
task.spawn(function() while not state.shuttingDown do local el=math.floor(tick()-state.stats.startTime);statsLabel.Text=string.format("Sold: %d  |  Time: %02d:%02d",state.stats.sold,math.floor(el/60),el%60);task.wait(1) end end)
local function spawnAndSell(count) if state.running.spawnBusy then return 0 end;local folder=getSellFolder();local sr=getRemote("EquipService","SellTower");local br=getRemote("BoxService","OpenSpecialBox");if not folder or not sr or not br then SetStatus("Sell remotes missing",C.red);return 0 end;state.running.spawnBusy=true;task.spawn(function() pcall(br.InvokeServer,br,cfgGet("autoFarmBoxType"),count,0) end);local ob=PG:FindFirstChild("MainGUI") and PG.MainGUI:FindFirstChild("Middle") and PG.MainGUI.Middle:FindFirstChild("OpenBox");if ob then ob.Visible=false end;task.wait(0.3);local towers={};for _,o in ipairs(folder:GetChildren()) do if isTower(o) then table.insert(towers,o.Name);if #towers>=count then break end end end;for _,n in ipairs(towers) do task.spawn(function() pcall(sr.InvokeServer,sr,n) end) end;task.wait(0.2);state.stats.sold=state.stats.sold+#towers;state.running.spawnBusy=false;return #towers end
local function sellAllNow() local folder=getSellFolder();local sr=getRemote("EquipService","SellTower");if not folder or not sr then SetStatus("Sell remotes missing",C.red);return 0 end;local list={};for _,o in ipairs(folder:GetChildren()) do if isTower(o) then table.insert(list,o.Name) end end;for _,n in ipairs(list) do task.spawn(function() pcall(sr.InvokeServer,sr,n) end) end;task.wait(0.2);state.stats.sold=state.stats.sold+#list;return #list end
Section(farm,"Box Type","")
SearchSelect(farm,"Box Type",{"Starter"},"autoFarmBoxType")
Section(farm,"Inventory Automation","")
Toggle(farm,"Auto Sell Loop","Repeats a full sell pass",function(on) state.running.sell=on;if not on then SetStatus("Auto Sell stopped",C.muted);return end;task.spawn(function() while state.running.sell and not state.shuttingDown do local n=sellAllNow();SetStatus("Sold "..n,C.green);task.wait(cfgGet("sellPassWait")) end end) end)
Button(farm,"Sell Now","purple",function() local n=sellAllNow();SetStatus("Sold "..n,C.green) end)
Section(farm,"Spawn + Sell","")
Button(farm,"Sell "..tostring(cfgGet("sellBatchAmount")),"blue",function() task.spawn(function() spawnAndSell(cfgGet("sellBatchAmount")) end) end)
Button(farm,"Sell 100","blue",function() task.spawn(function() spawnAndSell(100) end) end)
Button(farm,"Sell 200","blue",function() task.spawn(function() spawnAndSell(200) end) end)
Button(farm,"Sell 300","blue",function() task.spawn(function() spawnAndSell(300) end) end)
local customCount=Field(farm,"Custom Amount","e.g. 50",nil,"customSellAmount")
Button(farm,"Spawn + Sell N","orange",function() local n=tonumber(customCount.Text) or cfgGet("customSellAmount");if not n or n<=0 then SetStatus("Invalid amount",C.red);return end;task.spawn(function() spawnAndSell(n) end) end)
Section(farm,"Auto Loops","")
for _,k in ipairs({"100","200","300"}) do Toggle(farm,"Auto "..k,"",function(on) state.running["auto"..k]=on;if not on then return end;task.spawn(function() while state.running["auto"..k] and not state.shuttingDown do spawnAndSell(tonumber(k));task.wait(cfgGet("autoLoopWait")) end end) end) end
Section(farm,"Boxes & Effects","")
Toggle(farm,"Auto Open Boxes","",function(on) state.running.box=on;if not on then SetStatus("Auto Boxes stopped",C.muted);return end;task.spawn(function() while state.running.box and not state.shuttingDown do local r=getRemote("BoxService","OpenSpecialBox");if r then local ok=pcall(r.InvokeServer,r,cfgGet("autoFarmBoxType"),cfgGet("autoOpenBoxCount") or 300,0);SetStatus(ok and "Box request sent" or "Box failed",ok and C.green or C.red) else SetStatus("OpenSpecialBox missing",C.red);state.running.box=false;break end;task.wait(1) end end) end)
Toggle(farm,"Hide Open Box UI","",function(on) state.running.hideBox=on;if not on then return end;task.spawn(function() while state.running.hideBox and not state.shuttingDown do local b=FindDescendant(PG,"OpenBox");if b and b:IsA("GuiObject") then b.Visible=false end;task.wait(0.5) end end) end)
Toggle(farm,"Remove Confetti","",function(on) state.running.confetti=on;if not on then return end;task.spawn(function() while state.running.confetti and not state.shuttingDown do local cf=FindDescendant(PG,"Confetti");if cf then pcall(function() cf:Destroy() end) end;task.wait(0.5) end end) end)

-- ================= TRAIT ROLLER =================
Section(trait,"Tower Selector","")
local searchBox=Field(trait,"Search Towers","Name or ID...")
local selectedLabel=Label(trait,"Selected: None","muted")
local resultsFrame=Instance.new("ScrollingFrame");resultsFrame.Size=UDim2.new(1,-3,0,150);resultsFrame.BorderSizePixel=0;resultsFrame.ScrollBarThickness=3;resultsFrame.ScrollBarImageColor3=C.purple;resultsFrame.CanvasSize=UDim2.new(0,0,0,0);resultsFrame.AutomaticCanvasSize=Enum.AutomaticSize.Y;resultsFrame.Parent=trait;Corner(resultsFrame,10);Register(resultsFrame,"panel");Stroke(resultsFrame,C.line,1,0.3)
local rp=Instance.new("UIPadding");rp.PaddingTop=UDim.new(0,6);rp.PaddingBottom=UDim.new(0,6);rp.PaddingLeft=UDim.new(0,6);rp.PaddingRight=UDim.new(0,6);rp.Parent=resultsFrame
local rl=Instance.new("UIListLayout");rl.Padding=UDim.new(0,5);rl.SortOrder=Enum.SortOrder.LayoutOrder;rl.Parent=resultsFrame
local function refreshTowerResults() for _,c in ipairs(resultsFrame:GetChildren()) do if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end end;local q=searchBox.Text:lower():gsub("^%s+",""):gsub("%s+$","");local root=getTraitFolder();if not root then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,-4,0,32);e.BackgroundTransparency=1;e.Text="Tower inventory not found";e.Font=Enum.Font.Gotham;e.TextSize=10;e.Parent=resultsFrame;Register(e,"muted","TextColor3");return end;local list={};for _,it in ipairs(root:GetDescendants()) do if isTower(it) then table.insert(list,it) end end;table.sort(list,function(a,b) return a.Name<b.Name end);local n=0;for _,tw in ipairs(list) do local dn=towerDisplayName(tw);if q=="" or (tw.Name.." "..dn):lower():find(q,1,true) then n+=1;if n<=50 then local e=Instance.new("TextButton");e.Size=UDim2.new(1,-4,0,32);e.BorderSizePixel=0;e.Text="  "..dn.."  ["..tw.Name.."]";e.TextColor3=C.white;e.Font=Enum.Font.Gotham;e.TextSize=10;e.TextXAlignment=Enum.TextXAlignment.Left;e.LayoutOrder=n;e.Parent=resultsFrame;Corner(e,7);Register(e,(state.selectedTower==tw) and "purple" or "card");e.Activated:Connect(function() state.selectedTower=tw;selectedLabel.Text="Selected: "..dn.." ("..tw.Name..")";refreshTowerResults() end) end end end;if n==0 then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,-4,0,32);e.BackgroundTransparency=1;e.Text="No towers";e.Font=Enum.Font.Gotham;e.TextSize=10;e.Parent=resultsFrame;Register(e,"muted","TextColor3") end end
searchBox:GetPropertyChangedSignal("Text"):Connect(refreshTowerResults)
Button(trait,"Refresh List","blue",function() refreshTowerResults();SetStatus("Refreshed",C.green) end)
Section(trait,"Desired Traits (multi)","Stop on any match")
local traitInput=Field(trait,"Add trait","e.g. Legendary")
local traitTargetsHolder=Instance.new("Frame");traitTargetsHolder.Size=UDim2.new(1,-3,0,0);traitTargetsHolder.AutomaticSize=Enum.AutomaticSize.Y;traitTargetsHolder.BackgroundTransparency=1;traitTargetsHolder.Parent=trait
local tthLayout=Instance.new("UIListLayout");tthLayout.Padding=UDim.new(0,4);tthLayout.Parent=traitTargetsHolder
local function getTraitTargets() local t=cfgGet("traitTargets");if type(t)~="table" then t={};cfgSet("traitTargets",t) end;return t end
local refreshTraitTargets
refreshTraitTargets=function() for _,c in ipairs(traitTargetsHolder:GetChildren()) do if c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end end;local list=getTraitTargets();if #list==0 then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,0,0,22);e.BackgroundTransparency=1;e.Text="No traits added";e.Font=Enum.Font.Gotham;e.TextSize=10;e.Parent=traitTargetsHolder;Register(e,"muted","TextColor3");return end;for i,tr in ipairs(list) do local row=Instance.new("Frame");row.Size=UDim2.new(1,0,0,32);row.BorderSizePixel=0;row.Parent=traitTargetsHolder;Corner(row,7);Register(row,"card");Stroke(row,C.line,1,0.35);local lbl=Instance.new("TextLabel");lbl.Position=UDim2.fromOffset(10,0);lbl.Size=UDim2.new(1,-50,1,0);lbl.BackgroundTransparency=1;lbl.Text=tr;lbl.Font=Enum.Font.Gotham;lbl.TextSize=11;lbl.TextXAlignment=Enum.TextXAlignment.Left;lbl.Parent=row;Register(lbl,"white","TextColor3");local del=Instance.new("TextButton");del.Size=UDim2.fromOffset(38,24);del.Position=UDim2.new(1,-46,0.5,-12);del.BorderSizePixel=0;del.Text="×";del.TextColor3=C.white;del.Font=Enum.Font.GothamBold;del.TextSize=14;del.Parent=row;Corner(del,6);Register(del,"red");del.Activated:Connect(function() table.remove(list,i);cfgSet("traitTargets",list);refreshTraitTargets() end) end end
Button(trait,"Add Trait to List","green",function() local v=tostring(traitInput.Text or ""):gsub("^%s+",""):gsub("%s+$","");if v=="" then SetStatus("Enter trait name",C.red);return end;local list=getTraitTargets();for _,x in ipairs(list) do if x:lower()==v:lower() then SetStatus("Already in list",C.muted);return end end;table.insert(list,v);cfgSet("traitTargets",list);traitInput.Text="";refreshTraitTargets() end)
Button(trait,"Clear Trait List","orange",function() cfgSet("traitTargets",{});refreshTraitTargets() end)
refreshTraitTargets()
Section(trait,"Roll Controls","")
local traitStatus=Label(trait,"Status: idle","muted")
local function getTowerTraitLabel(tw) for _,v in ipairs(tw:GetDescendants()) do if v:IsA("TextLabel") and (v.Name=="Trait" or v.Text=="No Trait" or v.Text:find("Trait")) then return v.Text end end end
Button(trait,"Start Rolling","green",function() if state.running.trait then SetStatus("Already rolling",C.muted);return end;if not state.selectedTower or not state.selectedTower.Parent then SetStatus("Select tower first",C.red);refreshTowerResults();return end;local targets=getTraitTargets();if #targets==0 then SetStatus("Add at least one trait",C.red);return end;local r=getRemote("TraitService","RollTrait");if not r then SetStatus("RollTrait not found",C.red);return end;state.running.trait=true;traitStatus.Text="Rolling...";traitStatus.TextColor3=C.blue;task.spawn(function() local tw=state.selectedTower;local nm=tw.Name;while state.running.trait and not state.shuttingDown do if not tw or not tw.Parent then traitStatus.Text="Tower lost";traitStatus.TextColor3=C.red;state.running.trait=false;break end;local ok,res=pcall(r.InvokeServer,r,nm);local lbl=getTowerTraitLabel(tw);local function matchAny(text) if type(text)~="string" then return nil end;local low=text:lower();for _,target in ipairs(targets) do if low:find(target:lower(),1,true) then return target end end;return nil end;local hit=nil;if ok and typeof(res)=="string" then hit=matchAny(res) end;if not hit and lbl then hit=matchAny(lbl) end;if hit then traitStatus.Text="Found: "..hit;traitStatus.TextColor3=C.green;state.running.trait=false;break end;task.wait(cfgGet("traitRollDelay")) end end) end)
Button(trait,"Stop Rolling","red",function() state.running.trait=false;traitStatus.Text="Status: stopped";traitStatus.TextColor3=C.muted end)
refreshTowerResults()

-- ================= UNITS =================
Section(unitsPage,"Unit Browser","Workspace.Towers → Copy TowerID / Copy Name")
local unitSearch=Field(unitsPage,"Search Unit","Model name / любой атрибут")
local unitStatus=Label(unitsPage,"Status: idle","muted")
local unitList=Instance.new("ScrollingFrame");unitList.Size=UDim2.new(1,-3,0,320);unitList.BackgroundTransparency=1;unitList.BorderSizePixel=0;unitList.ScrollBarThickness=3;unitList.ScrollBarImageColor3=C.purple;unitList.CanvasSize=UDim2.new(0,0,0,0);unitList.AutomaticCanvasSize=Enum.AutomaticSize.Y;unitList.Parent=unitsPage
local ulLayout=Instance.new("UIListLayout");ulLayout.Padding=UDim.new(0,5);ulLayout.Parent=unitList
local function scanAllUnits() local towers=workspace:FindFirstChild("Towers");if not towers then return {},"Workspace.Towers not found" end;local out={};local function collect(model) local attrs={};for key,value in pairs(model:GetAttributes()) do attrs[key]=value end;table.insert(out,{model=model,name=model.Name,attrs=attrs}) end;for _,child in ipairs(towers:GetChildren()) do if child:IsA("Model") or child:IsA("BasePart") then collect(child) elseif child:IsA("Folder") or child:IsA("Configuration") then for _,sub in ipairs(child:GetChildren()) do if sub:IsA("Model") or sub:IsA("BasePart") then collect(sub) end end end end;return out,nil end
local function getUnitId(attrs) if type(attrs)~="table" then return "" end;local priority={"TowerID","TowerId","towerID","towerId","towerid","UnitID","UnitId","unitID","unitId","unitid","Id","ID","id","Tower_ID","Unit_ID","_id","ID_"};for _,key in ipairs(priority) do local v=attrs[key];if v~=nil and tostring(v)~="" and tostring(v)~="nil" then return tostring(v) end end;for k,v in pairs(attrs) do local lk=tostring(k):lower();if lk:find("id",1,true) and not lk:find("owned",1,true) and not lk:find("owner",1,true) and v~=nil and tostring(v)~="" and tostring(v)~="nil" then return tostring(v) end end;return "" end
local function renderUnitList() for _,c in ipairs(unitList:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end;local list,err=scanAllUnits();if err then unitStatus.Text=err;unitStatus.TextColor3=C.red;return end;local q=tostring(unitSearch.Text or ""):lower();local shown=0;for _,u in ipairs(list) do local sp={u.name};for k,v in pairs(u.attrs) do table.insert(sp,tostring(k));table.insert(sp,tostring(v)) end;if q=="" or table.concat(sp," "):lower():find(q,1,true) then shown+=1;local row=Instance.new("Frame");row.Size=UDim2.new(1,0,0,0);row.AutomaticSize=Enum.AutomaticSize.Y;row.BorderSizePixel=0;row.Parent=unitList;Corner(row,9);Register(row,"card");Stroke(row,C.line,1,0.35);local pad=Instance.new("UIPadding");pad.PaddingTop=UDim.new(0,8);pad.PaddingBottom=UDim.new(0,8);pad.PaddingLeft=UDim.new(0,10);pad.PaddingRight=UDim.new(0,10);pad.Parent=row;local content=Instance.new("Frame");content.Size=UDim2.new(1,0,0,0);content.AutomaticSize=Enum.AutomaticSize.Y;content.BackgroundTransparency=1;content.Parent=row;local l=Instance.new("UIListLayout");l.Padding=UDim.new(0,3);l.Parent=content;local realId=getUnitId(u.attrs);local nameLbl=Instance.new("TextLabel");nameLbl.Size=UDim2.new(1,0,0,18);nameLbl.BackgroundTransparency=1;nameLbl.Text="◆ "..u.name.."   |  Id: "..(realId~="" and realId or "—");nameLbl.Font=Enum.Font.GothamBold;nameLbl.TextSize=12;nameLbl.TextXAlignment=Enum.TextXAlignment.Left;nameLbl.Parent=content;Register(nameLbl,"white","TextColor3");local keys={};for k in pairs(u.attrs) do table.insert(keys,k) end;table.sort(keys);if #keys==0 then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,0,0,16);e.BackgroundTransparency=1;e.Text="(нет атрибутов)";e.Font=Enum.Font.Gotham;e.TextSize=10;e.TextXAlignment=Enum.TextXAlignment.Left;e.Parent=content;Register(e,"muted","TextColor3") else for _,k in ipairs(keys) do local line=Instance.new("TextLabel");line.Size=UDim2.new(1,0,0,16);line.BackgroundTransparency=1;line.Text="  "..tostring(k).." = "..tostring(u.attrs[k]);line.Font=Enum.Font.Code;line.TextSize=10;line.TextXAlignment=Enum.TextXAlignment.Left;line.Parent=content;Register(line,"muted","TextColor3") end end;local row2=Instance.new("Frame");row2.Size=UDim2.new(1,0,0,26);row2.BackgroundTransparency=1;row2.Parent=content;local cpNameBtn=Instance.new("TextButton");cpNameBtn.Size=UDim2.new(0.34,-2,1,0);cpNameBtn.Position=UDim2.new(0,0,0,0);cpNameBtn.BorderSizePixel=0;cpNameBtn.Text="Copy Name";cpNameBtn.TextColor3=C.white;cpNameBtn.Font=Enum.Font.GothamSemibold;cpNameBtn.TextSize=10;cpNameBtn.Parent=row2;Corner(cpNameBtn,6);Register(cpNameBtn,"orange");cpNameBtn.Activated:Connect(function() if setclipboard then pcall(setclipboard,u.name) end;SetStatus("Copied Name: "..u.name,C.green) end);local cpIdBtn=Instance.new("TextButton");cpIdBtn.Size=UDim2.new(0.33,-2,1,0);cpIdBtn.Position=UDim2.new(0.34,1,0,0);cpIdBtn.BorderSizePixel=0;cpIdBtn.Text="Copy TowerID";cpIdBtn.TextColor3=C.white;cpIdBtn.Font=Enum.Font.GothamSemibold;cpIdBtn.TextSize=10;cpIdBtn.Parent=row2;Corner(cpIdBtn,6);Register(cpIdBtn,"blue");cpIdBtn.Activated:Connect(function() local unitId=getUnitId(u.attrs);if unitId=="" then SetStatus("No TowerID",C.red);return end;if setclipboard then pcall(setclipboard,unitId) end;SetStatus("Copied TowerID: "..unitId,C.green) end);local toSlotBtn=Instance.new("TextButton");toSlotBtn.Size=UDim2.new(0.32,-2,1,0);toSlotBtn.Position=UDim2.new(0.68,2,0,0);toSlotBtn.BorderSizePixel=0;toSlotBtn.Text="→ AutoWin";toSlotBtn.TextColor3=C.white;toSlotBtn.Font=Enum.Font.GothamBold;toSlotBtn.TextSize=10;toSlotBtn.Parent=row2;Corner(toSlotBtn,6);Register(toSlotBtn,"purple");toSlotBtn.Activated:Connect(function() if not sendUnitToSlot then SetStatus("AutoWin not ready",C.red);return end;local unitId=getUnitId(u.attrs);if unitId=="" then SetStatus("No TowerID",C.red);return end;sendUnitToSlot(u.name,unitId);SetStatus("→ AutoWin: "..u.name,C.green) end) end end;if shown==0 then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,0,0,26);e.BackgroundTransparency=1;e.Text="Ничего не найдено";e.Font=Enum.Font.Gotham;e.TextSize=11;e.Parent=unitList;Register(e,"muted","TextColor3") end;unitStatus.Text="Status: "..shown.." / "..#list;unitStatus.TextColor3=shown>0 and C.green or C.muted end
Button(unitsPage,"Refresh Units","blue",function() renderUnitList();SetStatus("Units refreshed",C.green) end)
Button(unitsPage,"Dump to Console (F9)","orange",function() local list,err=scanAllUnits();if err then SetStatus(err,C.red);return end;for i,u in ipairs(list) do print("["..i.."] "..u.name.." TowerID="..getUnitId(u.attrs));for k,v in pairs(u.attrs) do print("    "..k.."="..tostring(v)) end end;SetStatus("Dumped",C.green) end)
unitSearch:GetPropertyChangedSignal("Text"):Connect(renderUnitList)
task.spawn(function() for i=1,15 do if workspace:FindFirstChild("Towers") then break end;task.wait(1) end;pcall(renderUnitList) end)
task.spawn(function() for i=1,15 do if workspace:FindFirstChild("Towers") then break end;task.wait(1) end;local towers=workspace:FindFirstChild("Towers");if towers then towers.ChildAdded:Connect(function() pcall(renderUnitList) end);towers.ChildRemoved:Connect(function() pcall(renderUnitList) end) end end)

-- ================= AUTO E =================
Section(autoE,"Auto E","")
local autoEStatus=Label(autoE,"Status: idle","muted")
SearchSelect(autoE,"Key",{"E","Q","R","F","G","T","Y","H","J","K","L","U","I","O","P"},"autoEKey")
Toggle(autoE,"Auto E","Repeat key press",function(on) state.running.autoE=on;autoEStatus.Text=on and "Status: running" or "Status: idle";autoEStatus.TextColor3=on and C.green or C.muted;if not on then return end;task.spawn(function() while state.running.autoE and not state.shuttingDown do local kc=Enum.KeyCode[cfgGet("autoEKey")] or Enum.KeyCode.E;pcall(function() VIM:SendKeyEvent(true,kc,false,game);task.wait(0.05);VIM:SendKeyEvent(false,kc,false,game) end);task.wait(cfgGet("autoEInterval")) end end) end)

-- ================= TRADE =================
do
for _,child in ipairs(trade:GetChildren()) do if child:IsA("UIListLayout") or child:IsA("UIPadding") then child:Destroy() end end
trade.AutomaticCanvasSize=Enum.AutomaticSize.None;trade.CanvasSize=UDim2.new(0,0,0,0);trade.ScrollingEnabled=false
local lp2=Instance.new("Frame");lp2.Size=UDim2.new(0,265,1,0);lp2.BorderSizePixel=0;lp2.ZIndex=3;lp2.Parent=trade;Corner(lp2,10);Register(lp2,"panel");Stroke(lp2,C.line,1,0.35)
local tS=Instance.new("TextBox");tS.Position=UDim2.fromOffset(10,39);tS.Size=UDim2.new(1,-20,0,32);tS.BorderSizePixel=0;tS.Text="";tS.PlaceholderText="Search username...";tS.PlaceholderColor3=C.muted;tS.TextColor3=C.white;tS.Font=Enum.Font.Gotham;tS.TextSize=11;tS.ClearTextOnFocus=false;tS.TextXAlignment=Enum.TextXAlignment.Left;tS.Parent=lp2;Corner(tS,8);Register(tS,"card");Stroke(tS,C.line,1,0.25)
local tL=Instance.new("ScrollingFrame");tL.Position=UDim2.fromOffset(10,78);tL.Size=UDim2.new(1,-20,1,-130);tL.BackgroundTransparency=1;tL.BorderSizePixel=0;tL.ScrollBarThickness=3;tL.ScrollBarImageColor3=C.purple;tL.CanvasSize=UDim2.new(0,0,0,0);tL.AutomaticCanvasSize=Enum.AutomaticSize.Y;tL.Parent=lp2
local tl2=Instance.new("UIListLayout");tl2.Padding=UDim.new(0,5);tl2.SortOrder=Enum.SortOrder.LayoutOrder;tl2.Parent=tL
local rp2=Instance.new("Frame");rp2.Position=UDim2.fromOffset(277,0);rp2.Size=UDim2.new(1,-277,1,0);rp2.BorderSizePixel=0;rp2.ZIndex=3;rp2.Parent=trade;Corner(rp2,10);Register(rp2,"panel");Stroke(rp2,C.line,1,0.35)
local tD=Instance.new("TextLabel");tD.Position=UDim2.fromOffset(13,12);tD.Size=UDim2.new(1,-26,0,22);tD.BackgroundTransparency=1;tD.Text="Select a player";tD.Font=Enum.Font.GothamBold;tD.TextSize=13;tD.TextXAlignment=Enum.TextXAlignment.Left;tD.Parent=rp2;Register(tD,"white","TextColor3")
local tI=Instance.new("TextLabel");tI.Position=UDim2.fromOffset(14,40);tI.Size=UDim2.new(1,-28,1,-170);tI.BackgroundTransparency=1;tI.Text="Choose a player";tI.Font=Enum.Font.Gotham;tI.TextSize=11;tI.TextXAlignment=Enum.TextXAlignment.Left;tI.TextYAlignment=Enum.TextYAlignment.Top;tI.TextWrapped=true;tI.Parent=rp2;Register(tI,"white","TextColor3")
local tStat=Instance.new("TextLabel");tStat.Position=UDim2.new(0,13,1,-120);tStat.Size=UDim2.new(1,-26,0,18);tStat.BackgroundTransparency=1;tStat.Text="Ready";tStat.Font=Enum.Font.GothamMedium;tStat.TextSize=10;tStat.TextXAlignment=Enum.TextXAlignment.Left;tStat.Parent=rp2;Register(tStat,"green","TextColor3")
local tBtn=Instance.new("TextButton");tBtn.Position=UDim2.new(0,13,1,-90);tBtn.Size=UDim2.new(1,-26,0,32);tBtn.BorderSizePixel=0;tBtn.Text="Send Trade Request";tBtn.TextColor3=C.white;tBtn.Font=Enum.Font.GothamBold;tBtn.TextSize=11;tBtn.Parent=rp2;Corner(tBtn,8);Register(tBtn,"green");Stroke(tBtn,C.line,1,0.5)
local msgF=Instance.new("TextBox");msgF.Position=UDim2.new(0,13,1,-52);msgF.Size=UDim2.new(1,-26,0,32);msgF.BorderSizePixel=0;msgF.Text="";msgF.PlaceholderText="Message to send...";msgF.PlaceholderColor3=C.muted;msgF.TextColor3=C.white;msgF.Font=Enum.Font.Gotham;msgF.TextSize=11;msgF.ClearTextOnFocus=false;msgF.Parent=rp2;Corner(msgF,8);Register(msgF,"card");Stroke(msgF,C.line,1,0.25)
local function renderTI() local p=state.selectedPlayer;if not p or not p.Parent then tD.Text="Select a player";tI.Text="Choose a player";return end;tD.Text=p.DisplayName.." (@"..p.Name..")";local L={"◆ UserId: "..p.UserId,"◆ Account age: "..p.AccountAge.." days","◆ Team: "..(p.Team and p.Team.Name or "None")};local hum=p.Character and p.Character:FindFirstChildOfClass("Humanoid");if hum then table.insert(L,string.format("◆ HP: %d/%d",math.floor(hum.Health+0.5),math.floor(hum.MaxHealth+0.5))) end;local bp=p:FindFirstChildOfClass("Backpack");table.insert(L,"◆ Tools: "..(bp and #bp:GetChildren() or 0));local ls=p:FindFirstChild("leaderstats");if ls then table.insert(L,"");table.insert(L,"LEADERSTATS");for _,v in ipairs(ls:GetChildren()) do if v:IsA("ValueBase") then table.insert(L,v.Name..": "..tostring(v.Value)) end end end;tI.Text=table.concat(L,"\n");tStat.Text="Info updated";tStat.TextColor3=C.green end
local function refreshTP() for _,c in ipairs(tL:GetChildren()) do if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end end;local q=tS.Text:lower();local found={};for _,p in ipairs(Players:GetPlayers()) do if p~=LP and (q=="" or p.Name:lower():find(q,1,true) or p.DisplayName:lower():find(q,1,true)) then table.insert(found,p) end end;table.sort(found,function(a,b) return a.Name:lower()<b.Name:lower() end);for i,p in ipairs(found) do local isSel=(state.selectedPlayer==p);local b=Instance.new("TextButton");b.Size=UDim2.new(1,0,0,42);b.BorderSizePixel=0;b.Text="";b.LayoutOrder=i;b.AutoButtonColor=false;b.Parent=tL;Corner(b,8);Register(b,isSel and "purple" or "card");Stroke(b,C.line,1,0.35);local dn=Instance.new("TextLabel");dn.Position=UDim2.fromOffset(9,4);dn.Size=UDim2.new(1,-18,0,18);dn.BackgroundTransparency=1;dn.Text=p.DisplayName;dn.Font=Enum.Font.GothamSemibold;dn.TextSize=11;dn.TextXAlignment=Enum.TextXAlignment.Left;dn.Parent=b;Register(dn,"white","TextColor3");local un=Instance.new("TextLabel");un.Position=UDim2.fromOffset(9,22);un.Size=UDim2.new(1,-18,0,16);un.BackgroundTransparency=1;un.Text="@"..p.Name.." | "..p.UserId;un.Font=Enum.Font.Gotham;un.TextSize=9;un.TextXAlignment=Enum.TextXAlignment.Left;un.Parent=b;Register(un,"muted","TextColor3");b.Activated:Connect(function() state.selectedPlayer=p;refreshTP();renderTI() end) end;if #found==0 then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,0,0,30);e.BackgroundTransparency=1;e.Text="No players";e.Font=Enum.Font.Gotham;e.TextSize=10;e.Parent=tL;Register(e,"muted","TextColor3") end end
tS:GetPropertyChangedSignal("Text"):Connect(refreshTP)
local refreshBtn2=Instance.new("TextButton");refreshBtn2.Position=UDim2.new(0,10,1,-42);refreshBtn2.Size=UDim2.new(1,-20,0,32);refreshBtn2.BorderSizePixel=0;refreshBtn2.Text="Refresh Players";refreshBtn2.TextColor3=C.white;refreshBtn2.Font=Enum.Font.GothamSemibold;refreshBtn2.TextSize=11;refreshBtn2.Parent=lp2;Corner(refreshBtn2,8);Register(refreshBtn2,"purple");Stroke(refreshBtn2,C.line,1,0.5)
refreshBtn2.Activated:Connect(function() refreshTP();tStat.Text="Refreshed";tStat.TextColor3=C.green end)
tBtn.Activated:Connect(function() if not state.selectedPlayer or not state.selectedPlayer.Parent then tStat.Text="Select a player";tStat.TextColor3=C.red;return end;local r=getRemote("TradeService","TradeRequestAccepted");if not r then tStat.Text="Remote missing";tStat.TextColor3=C.red;return end;local ok=pcall(r.InvokeServer,r,state.selectedPlayer.UserId);if ok then tStat.Text="Trade sent ✓";tStat.TextColor3=C.green;local txt=msgF.Text;if txt and txt~="" then local send=getRemote("TradeService","SendMessage");if send then pcall(send.InvokeServer,send,txt) end end else tStat.Text="Trade failed";tStat.TextColor3=C.red end end)
Players.PlayerAdded:Connect(refreshTP)
Players.PlayerRemoving:Connect(function(p) if state.selectedPlayer==p then state.selectedPlayer=nil;renderTI() end;refreshTP() end)
refreshTP()
end

-- ================= TOWER PLACER =================
Section(placer,"Tower Placer","Одиночная башня")
Field(placer,"Unit Name","God G-Man 5.0",nil,"tpTowerName")
Field(placer,"Unit ID","7119227935_1549868",nil,"tpTowerId")
SearchSelect(placer,"Direction",{"LEFT","RIGHT","UP","DOWN","FORWARD","BACKWARD"},"tpDirection",function() end)
Field(placer,"Distance","e.g. 10",nil,"tpDistance")
Field(placer,"Height (Y Offset)","e.g. 10",nil,"tpYOffset")
local tpStatus=Label(placer,"Status: ready","muted")
local function getOffsetVec(dir,dist) if dir=="LEFT" then return Vector3.new(-dist,0,0) elseif dir=="RIGHT" then return Vector3.new(dist,0,0) elseif dir=="UP" then return Vector3.new(0,dist,0) elseif dir=="DOWN" then return Vector3.new(0,-dist,0) elseif dir=="FORWARD" then return Vector3.new(0,0,-dist) elseif dir=="BACKWARD" then return Vector3.new(0,0,dist) end;return Vector3.zero end
Button(placer,"Place Tower Here","green",function() local name=tostring(cfgGet("tpTowerName") or "");local id=tostring(cfgGet("tpTowerId") or "");if name=="" or id=="" then tpStatus.Text="Enter name+id";tpStatus.TextColor3=C.red;return end;local char=LP.Character;local root=char and char:FindFirstChild("HumanoidRootPart");if not root then tpStatus.Text="Character not ready";tpStatus.TextColor3=C.red;return end;local offset=getOffsetVec(cfgGet("tpDirection"),tonumber(cfgGet("tpDistance")) or 10);local yOff=tonumber(cfgGet("tpYOffset")) or 0;local pos=root.Position+offset+Vector3.new(0,yOff,0);local r=getRemote("TowerService","PlaceTower");if not r then tpStatus.Text="PlaceTower missing";tpStatus.TextColor3=C.red;return end;local ok=pcall(r.InvokeServer,r,name,CFrame.new(pos),id);tpStatus.Text=ok and string.format("Placed ✓ (%.1f, %.1f, %.1f)",pos.X,pos.Y,pos.Z) or "Failed";tpStatus.TextColor3=ok and C.green or C.red end)

-- ================= MACRO UI =================
Section(macro,"Recorder","Start → действия → Stop")
local macroRecordStatus=Label(macro,"Status: idle","muted")
local macroInfo=Label(macro,"Frames: 0 | Events: 0 | Length: 0.00s","blue")
local function refreshMacroInfo() local t=0;if #Macro.data>=2 then t=Macro.data[#Macro.data].t-Macro.data[1].t end;macroInfo.Text=string.format("Frames: %d | Events: %d | Length: %.2fs",#Macro.data,#Macro.events,t) end
refreshMacroInfo()
Button(macro,"Start Recording","red",function() local ok,err=Macro.startRecording();if ok then macroRecordStatus.Text="RECORDING";macroRecordStatus.TextColor3=C.green else macroRecordStatus.Text="fail: "..tostring(err);macroRecordStatus.TextColor3=C.red end end)
Button(macro,"Stop Recording","orange",function() Macro.stopRecording();refreshMacroInfo();macroRecordStatus.Text="stopped";macroRecordStatus.TextColor3=C.muted end)
Button(macro,"Play Macro","green",function() local ok,err=Macro.play();if not ok then SetStatus("Play fail: "..tostring(err),C.red) end end)
Button(macro,"Stop Playback","red",function() Macro.stop() end)
local speedField=Field(macro,"Playback Speed","1.0",nil,"macroPlaySpeed")
speedField.FocusLost:Connect(function() local n=math.clamp(tonumber(speedField.Text) or 1,0.1,5);Macro.playSpeed=n;speedField.Text=tostring(n);Macro.save() end)
speedField.Text=tostring(Macro.playSpeed)
Field(macro,"Mouse Offset X (px)","+5",nil,"macroMouseOffsetX")
Field(macro,"Mouse Offset Y (px)","+36",nil,"macroMouseOffsetY")
Toggle(macro,"Auto-play on spawn","Автозапуск при заходе / респавне",function(on) Macro.autoPlayOnSpawn=on;Macro.save();if on then if #Macro.data<2 then SetStatus("Need macro first",C.orange) else macroAutoPlayTry() end end end,Macro.autoPlayOnSpawn)
Toggle(macro,"Play Mouse Events","Воспроизводить клики",function(on) Macro.playMouseEvents=on;Macro.save() end,Macro.playMouseEvents)
Button(macro,"Clear Macro","red",function() Macro.clear();refreshMacroInfo() end)
Button(macro,"Save Macro","green",function() Macro.save() end)
Button(macro,"Load Macro","blue",function() Macro.load();refreshMacroInfo();speedField.Text=tostring(Macro.playSpeed) end)

-- ================= COLLECT =================
Section(collect,"Collect (Magnet)","Притягивает объекты к игроку")
Field(collect,"Object Names (comma)","Coin,Heal",nil,"collectNames")
Field(collect,"Loop Interval (s)","0.1",nil,"collectLoopInterval")
local collectStatus=Label(collect,"Status: ready","muted")
local function parseCollectNames() local s=tostring(cfgGet("collectNames") or "Coin,Heal");local list={};for name in string.gmatch(s,"[^,%s]+") do table.insert(list,name) end;if #list==0 then list={"Coin","Heal"} end;return list end
local function matchCollectName(n,list) for _,x in ipairs(list) do if n==x then return true end end end
local function collectMoveParts() local ch=LP.Character;local root=ch and ch:FindFirstChild("HumanoidRootPart");if not root then return 0 end;local names=parseCollectNames();local moved=0;for _,obj in ipairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and matchCollectName(obj.Name,names) then pcall(function() obj.CFrame=root.CFrame end);moved+=1 end end;return moved end
Button(collect,"Collect Now","purple",function() local n=collectMoveParts();collectStatus.Text="Pulled "..n;collectStatus.TextColor3=n>0 and C.green or C.muted end)
startCollectLoop=function() if state.running.collectLoop then return end;state.running.collectLoop=true;collectStatus.Text="Looping...";collectStatus.TextColor3=C.green;task.spawn(function() while state.running.collectLoop and not state.shuttingDown do local ok,moved=pcall(collectMoveParts);if ok then collectStatus.Text="Loop (last "..tostring(moved)..")";collectStatus.TextColor3=C.green end;task.wait(tonumber(cfgGet("collectLoopInterval")) or 0.1) end end) end
Toggle(collect,"Auto Collect Loop","Притягивает по интервалу",function(on) if on then startCollectLoop() else state.running.collectLoop=false end end,state.running.collectLoop)
Toggle(collect,"Auto-start Collect on load/spawn","Автоматически включает при загрузке и респавне",function(on) cfgSet("collectAutoStart",on) end,cfgGet("collectAutoStart"))

-- ================= MINIGAMES =================
Section(minigames,"Clicker","")
local clickerClicks=0
local clickerLabel=Label(minigames,"Clicks: 0 | Best: "..tostring(cfgGet("clickerBest")),"white");clickerLabel.TextSize=16
Button(minigames,"CLICK ME","purple",function() clickerClicks+=1;local best=tonumber(cfgGet("clickerBest")) or 0;if clickerClicks>best then best=clickerClicks;cfgSet("clickerBest",best) end;clickerLabel.Text="Clicks: "..clickerClicks.." | Best: "..best end)
Button(minigames,"Reset Clicks","red",function() clickerClicks=0;clickerLabel.Text="Clicks: 0 | Best: "..tostring(cfgGet("clickerBest")) end)
Section(minigames,"Reaction Test","")
local reactionState="idle";local reactionStart=0
local reactionLabel=Label(minigames,"Reaction: — ms | Best: "..tostring(cfgGet("reactionBest")).." ms","blue");reactionLabel.TextSize=14
local reactionBtn=Button(minigames,"START","green",function() end)
reactionBtn.Activated:Connect(function() if reactionState=="idle" then reactionState="armed";reactionLabel.Text="Wait...";reactionLabel.TextColor3=C.orange;task.spawn(function() task.wait(math.random(800,3000)/1000);if reactionState~="armed" then return end;reactionState="ready";reactionStart=tick();reactionLabel.Text="GO!";reactionLabel.TextColor3=C.green end) elseif reactionState=="armed" then reactionState="idle";reactionLabel.Text="Too early!";reactionLabel.TextColor3=C.red elseif reactionState=="ready" then local ms=math.floor((tick()-reactionStart)*1000);local best=tonumber(cfgGet("reactionBest")) or 9999;if ms<best then best=ms;cfgSet("reactionBest",best) end;reactionState="idle";reactionLabel.Text="Reaction: "..ms.." ms | Best: "..best;reactionLabel.TextColor3=C.green end end)

-- ================= BLOCK BLAST =================
do
Section(tetrisPg,"Block Blast","Lines = очки. Не дай блокам достичь верха")
local TB={cols=8,rows=14,cell=20,grid={},running=false,score=0,speed=0.6,piece=nil,cells={}}
local SHAPES={I={{0,0,0,0},{1,1,1,1},{0,0,0,0},{0,0,0,0}},O={{1,1},{1,1}},T={{0,1,0},{1,1,1},{0,0,0}},S={{0,1,1},{1,1,0},{0,0,0}},Z={{1,1,0},{0,1,1},{0,0,0}},J={{1,0,0},{1,1,1},{0,0,0}},L={{0,0,1},{1,1,1},{0,0,0}}}
local COLORS={I=Color3.fromRGB(80,200,255),O=Color3.fromRGB(255,220,80),T=Color3.fromRGB(180,80,255),S=Color3.fromRGB(80,220,120),Z=Color3.fromRGB(255,80,80),J=Color3.fromRGB(80,120,255),L=Color3.fromRGB(255,160,80)}
local KEYS={"I","O","T","S","Z","J","L"}
local tScoreLbl=Label(tetrisPg,"Score: 0 | Best: "..tostring(cfgGet("tetrisBest")),"blue");tScoreLbl.TextSize=14
local boardFrame=Instance.new("Frame");boardFrame.Size=UDim2.fromOffset(TB.cols*TB.cell,TB.rows*TB.cell);boardFrame.BorderSizePixel=0;boardFrame.Parent=tetrisPg;Corner(boardFrame,8);Register(boardFrame,"card");Stroke(boardFrame,C.line,1,0.5)
local gridHolder=Instance.new("Frame");gridHolder.Size=UDim2.new(1,0,1,0);gridHolder.BackgroundTransparency=1;gridHolder.Parent=boardFrame
for r=1,TB.rows do TB.grid[r]={};TB.cells[r]={};for c=1,TB.cols do TB.grid[r][c]=nil;local cf=Instance.new("Frame");cf.Size=UDim2.fromOffset(TB.cell-1,TB.cell-1);cf.Position=UDim2.fromOffset((c-1)*TB.cell,(r-1)*TB.cell);cf.BackgroundColor3=C.panel;cf.BorderSizePixel=0;cf.Parent=gridHolder;Corner(cf,3);TB.cells[r][c]=cf end end
local function tRender() for r=1,TB.rows do for c=1,TB.cols do TB.cells[r][c].BackgroundColor3=TB.grid[r][c] or C.panel end end;if TB.piece then local shape=TB.piece.shape;local col=COLORS[TB.piece.name];for rr=1,#shape do for cc=1,#shape[rr] do if shape[rr][cc]==1 then local r=TB.piece.y+rr-1;local c=TB.piece.x+cc-1;if r>=1 and r<=TB.rows and c>=1 and c<=TB.cols then TB.cells[r][c].BackgroundColor3=col end end end end end end
local function tCanPlace(shape,px,py) for rr=1,#shape do for cc=1,#shape[rr] do if shape[rr][cc]==1 then local r,c=py+rr-1,px+cc-1;if c<1 or c>TB.cols or r>TB.rows then return false end;if r>=1 and TB.grid[r][c] then return false end end end end;return true end
local function tSpawn() local k=KEYS[math.random(1,#KEYS)];local shape=SHAPES[k];local px=math.floor((TB.cols-#shape[1])/2)+1;TB.piece={name=k,x=px,y=1,shape=shape};if not tCanPlace(shape,TB.piece.x,TB.piece.y) then TB.running=false;local best=tonumber(cfgGet("tetrisBest")) or 0;if TB.score>best then best=TB.score;cfgSet("tetrisBest",best) end;tScoreLbl.Text="GAME OVER — Score: "..TB.score.." | Best: "..best;tScoreLbl.TextColor3=C.red end;tRender() end
local function tLock() if not TB.piece then return end;local shape=TB.piece.shape;for rr=1,#shape do for cc=1,#shape[rr] do if shape[rr][cc]==1 then local r,c=TB.piece.y+rr-1,TB.piece.x+cc-1;if r>=1 and r<=TB.rows and c>=1 and c<=TB.cols then TB.grid[r][c]=COLORS[TB.piece.name] end end end end;local cleared=0;local r=TB.rows;while r>=1 do local full=true;for c=1,TB.cols do if not TB.grid[r][c] then full=false;break end end;if full then table.remove(TB.grid,r);table.insert(TB.grid,1,{});cleared+=1 else r-=1 end end;if cleared>0 then local add=0;if cleared==1 then add=100 elseif cleared==2 then add=300 elseif cleared==3 then add=500 elseif cleared==4 then add=800 else add=800+(cleared-4)*300 end;TB.score+=add;local best=tonumber(cfgGet("tetrisBest")) or 0;if TB.score>best then cfgSet("tetrisBest",TB.score) end;tScoreLbl.Text="Score: "..TB.score.." | Best: "..tostring(cfgGet("tetrisBest"));tScoreLbl.TextColor3=C.green end;TB.piece=nil;tSpawn() end
local function tMove(dx) if not TB.running or not TB.piece then return end;if tCanPlace(TB.piece.shape,TB.piece.x+dx,TB.piece.y) then TB.piece.x+=dx;tRender() end end
local function tRotate() if not TB.running or not TB.piece then return end;local s=TB.piece.shape;local rotated={};for c=1,#s[1] do rotated[c]={};for r=1,#s do rotated[c][r]=s[#s-r+1][c] end end;if tCanPlace(rotated,TB.piece.x,TB.piece.y) then TB.piece.shape=rotated;tRender() end end
startTetris=function() if TB.running then return end;for r=1,TB.rows do for c=1,TB.cols do TB.grid[r][c]=nil end end;TB.score=0;TB.running=true;TB.piece=nil;tScoreLbl.Text="Score: 0 | Best: "..tostring(cfgGet("tetrisBest"));tScoreLbl.TextColor3=C.green;tSpawn();task.spawn(function() while TB.running and not state.shuttingDown do task.wait(TB.speed);if not TB.running then break end;if TB.piece then if tCanPlace(TB.piece.shape,TB.piece.x,TB.piece.y+1) then TB.piece.y+=1;tRender() else tLock() end end end end) end
stopTetris=function() TB.running=false end
local btnRow=Instance.new("Frame");btnRow.Size=UDim2.new(1,-3,0,32);btnRow.BackgroundTransparency=1;btnRow.Parent=tetrisPg
local btnGrid=Instance.new("UIGridLayout");btnGrid.CellSize=UDim2.new(0.25,-3,1,0);btnGrid.CellPadding=UDim2.new(0,4,0,0);btnGrid.Parent=btnRow
for _,data in ipairs({{"←",function() tMove(-1) end,"blue"},{"↻",function() tRotate() end,"purple"},{"→",function() tMove(1) end,"blue"},{"↓",function() if TB.running and TB.piece and tCanPlace(TB.piece.shape,TB.piece.x,TB.piece.y+1) then TB.piece.y+=1;tRender() elseif TB.running then tLock() end end,"orange"}}) do local b=Instance.new("TextButton");b.BorderSizePixel=0;b.Text=data[1];b.TextColor3=C.white;b.Font=Enum.Font.GothamBold;b.TextSize=16;b.Parent=btnRow;Corner(b,8);Register(b,data[3]);b.Activated:Connect(data[2]) end
Button(tetrisPg,"Start Game","green",function() startTetris() end)
Button(tetrisPg,"Stop","red",function() stopTetris() end)
Label(tetrisPg,"Best: "..tostring(cfgGet("tetrisBest")),"orange")
end

-- ================= GLOBAL CHAT =================
do
Section(globalChatPg,"Global Chat","Real-time · любой ник · без цензуры")
local CHAT_TOPIC="uplalan1_global_chat"
local chttpGet=function(url) local fn=syn and syn.request or http_request or request or (http and http.request);if not fn then return end;local ok,res=pcall(fn,{Url=url,Method="GET"});if ok and res and res.Body then return res.Body end end
local chttpPost=function(url,body,headers) local fn=syn and syn.request or http_request or request or (http and http.request);if not fn then return end;local ok,res=pcall(fn,{Url=url,Method="POST",Body=body,Headers=headers or {}});if ok and res and res.Body then return res.Body end end
local chatStatus=Label(globalChatPg,hasHttp() and "🟢 Online · poll 0.6s" or "🔴 HTTP недоступен",hasHttp() and "green" or "red")
local nameInput=Field(globalChatPg,"Ваш ник (любой)","Пусто = Roblox DisplayName",nil,"globalChatName")
nameInput.FocusLost:Connect(function() local v=tostring(nameInput.Text or ""):gsub("^%s+",""):gsub("%s+$","");if #v>32 then v=v:sub(1,32);nameInput.Text=v end;cfgSet("globalChatName",v);if v=="" then SetStatus("Ник: "..LP.DisplayName.." (Roblox)",C.green) else SetStatus("Ник: "..v,C.green) end end)
local chatLog=Instance.new("ScrollingFrame");chatLog.Size=UDim2.new(1,-3,0,340);chatLog.BackgroundTransparency=1;chatLog.BorderSizePixel=0;chatLog.ScrollBarThickness=4;chatLog.ScrollBarImageColor3=C.purple;chatLog.CanvasSize=UDim2.new(0,0,0,0);chatLog.AutomaticCanvasSize=Enum.AutomaticSize.Y;chatLog.Parent=globalChatPg;Corner(chatLog,12);Register(chatLog,"panel");Stroke(chatLog,C.line,1,0.3)
local chatPad=Instance.new("UIPadding");chatPad.PaddingTop=UDim.new(0,10);chatPad.PaddingBottom=UDim.new(0,10);chatPad.PaddingLeft=UDim.new(0,10);chatPad.PaddingRight=UDim.new(0,10);chatPad.Parent=chatLog
local chatLayout=Instance.new("UIListLayout");chatLayout.Padding=UDim.new(0,10);chatLayout.SortOrder=Enum.SortOrder.LayoutOrder;chatLayout.Parent=chatLog
local function addBubble(ev) local isMe=(tostring(ev.from)==tostring(LP.UserId));local nick=ev.display or ev.name or "?";if nick=="" then nick=ev.name or "?" end;local wrapper=Instance.new("Frame");wrapper.Size=UDim2.new(1,0,0,0);wrapper.AutomaticSize=Enum.AutomaticSize.Y;wrapper.BackgroundTransparency=1;wrapper.BorderSizePixel=0;wrapper.Parent=chatLog;wrapper.LayoutOrder=#chatLog:GetChildren()+1;local holder=Instance.new("Frame");holder.Size=UDim2.new(0.85,0,0,0);holder.AutomaticSize=Enum.AutomaticSize.Y;holder.Position=isMe and UDim2.new(0.15,0,0,0) or UDim2.new(0,0,0,0);holder.BackgroundTransparency=1;holder.BorderSizePixel=0;holder.Parent=wrapper;local nameLbl=Instance.new("TextLabel");nameLbl.Size=UDim2.new(1,0,0,14);nameLbl.BackgroundTransparency=1;nameLbl.Text=nick..(isMe and " (ты)" or "");nameLbl.Font=Enum.Font.GothamBold;nameLbl.TextSize=10;nameLbl.TextXAlignment=isMe and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;nameLbl.TextColor3=isMe and C.green or C.purple;nameLbl.Parent=holder;local bubble=Instance.new("Frame");bubble.Size=UDim2.new(1,0,0,0);bubble.AutomaticSize=Enum.AutomaticSize.Y;bubble.Position=UDim2.new(0,0,0,16);bubble.BorderSizePixel=0;bubble.Parent=holder;Corner(bubble,12);bubble.BackgroundColor3=isMe and C.purple or C.card;local bPad=Instance.new("UIPadding");bPad.PaddingTop=UDim.new(0,6);bPad.PaddingBottom=UDim.new(0,16);bPad.PaddingLeft=UDim.new(0,10);bPad.PaddingRight=UDim.new(0,10);bPad.Parent=bubble;local textLbl=Instance.new("TextLabel");textLbl.Size=UDim2.new(1,0,0,0);textLbl.AutomaticSize=Enum.AutomaticSize.Y;textLbl.BackgroundTransparency=1;textLbl.Text=ev.text or "";textLbl.Font=Enum.Font.Gotham;textLbl.TextSize=12;textLbl.TextWrapped=true;textLbl.TextXAlignment=Enum.TextXAlignment.Left;textLbl.TextColor3=C.white;textLbl.Parent=bubble;local timeLbl=Instance.new("TextLabel");timeLbl.Size=UDim2.new(1,0,0,10);timeLbl.Position=UDim2.new(0,0,1,-14);timeLbl.BackgroundTransparency=1;timeLbl.Text=os.date("%H:%M",ev.ts or os.time());timeLbl.Font=Enum.Font.Gotham;timeLbl.TextSize=8;timeLbl.TextXAlignment=isMe and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;timeLbl.TextColor3=C.muted;timeLbl.Parent=bubble;task.defer(function() task.wait(0.05);pcall(function() chatLog.CanvasPosition=Vector2.new(0,chatLog.AbsoluteCanvasSize.Y) end) end) end
local chatInput=Field(globalChatPg,"Сообщение","Введи текст и нажми Enter...")
local seenIds={}
local function chatSend() local text=tostring(chatInput.Text or ""):gsub("^%s+",""):gsub("%s+$","");if text=="" then return end;if not hasHttp() then SetStatus("HTTP недоступен",C.red);return end;local n=cfgGet("globalChatName") or "";if n=="" then n=LP.DisplayName end;local data={from=tostring(LP.UserId),name=LP.Name,display=n,text=text,ts=os.time()};local ok=chttpPost("https://ntfy.sh/"..CHAT_TOPIC,HttpService:JSONEncode(data),{["Content-Type"]="application/json"});if ok then chatInput.Text="";SetStatus("Отправлено",C.green) else SetStatus("Send failed",C.red) end end
Button(globalChatPg,"📤 Отправить","green",function() chatSend() end)
chatInput.FocusLost:Connect(function(enter) if enter then chatSend() end end)
local chatPollToken=0
stopChatPoll=function() chatPollToken+=1 end
chatPollToken+=1;local myChatToken=chatPollToken
task.spawn(function() while myChatToken==chatPollToken and not state.shuttingDown do if hasHttp() then local body=chttpGet("https://ntfy.sh/"..CHAT_TOPIC.."/json?poll=1&since=3s");if body then local cnt=0;for line in body:gmatch("[^\r\n]+") do local ok,j=pcall(function() return HttpService:JSONDecode(line) end);if ok and j and j.id and not seenIds[j.id] and j.message then seenIds[j.id]=true;local ok2,ev=pcall(function() return HttpService:JSONDecode(j.message) end);if ok2 and ev and ev.text then pcall(addBubble,ev);cnt+=1 end end end;if cnt>0 then chatStatus.Text="🟢 Online · "..#seenIds.." msgs" end end end;task.wait(0.6) end end)
Button(globalChatPg,"🗑 Очистить экран","orange",function() for _,c in ipairs(chatLog:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end end)
Label(globalChatPg,"Канал: "..CHAT_TOPIC,"blue")
openGlobalChat=function() ShowPage("Global Chat") end
end

-- ================= LIVE VIEW =================
do
Section(liveViewPg,"Live View","Статус и скриншоты экрана других юзеров")
local LIVE_TOPIC="uplalan1_live"
local lhttpGet=function(url) local fn=syn and syn.request or http_request or request or (http and http.request);if not fn then return end;local ok,res=pcall(fn,{Url=url,Method="GET"});if ok and res and res.Body then return res.Body end end
local lhttpPost=function(url,body,headers) local fn=syn and syn.request or http_request or request or (http and http.request);if not fn then return end;local ok,res=pcall(fn,{Url=url,Method="POST",Body=body,Headers=headers or {}});if ok and res and res.Body then return res.Body end end
local liveStatus=Label(liveViewPg,hasHttp() and "🟢 Online" or "🔴 HTTP недоступен",hasHttp() and "green" or "red")
local usersCache={}
local screenshots={}
local selectedUser=nil
local listPane=Instance.new("Frame");listPane.Size=UDim2.new(0,220,0,420);listPane.BorderSizePixel=0;listPane.Parent=liveViewPg;Corner(listPane,12);Register(listPane,"card");Stroke(listPane,C.line,1,0.3)
local listTitle=Instance.new("TextLabel");listTitle.Position=UDim2.fromOffset(10,10);listTitle.Size=UDim2.new(1,-20,0,20);listTitle.BackgroundTransparency=1;listTitle.Text="👥 Активные";listTitle.Font=Enum.Font.GothamBold;listTitle.TextSize=12;listTitle.TextXAlignment=Enum.TextXAlignment.Left;listTitle.Parent=listPane;Register(listTitle,"white","TextColor3")
local userList=Instance.new("ScrollingFrame");userList.Position=UDim2.fromOffset(10,36);userList.Size=UDim2.new(1,-20,1,-46);userList.BackgroundTransparency=1;userList.BorderSizePixel=0;userList.ScrollBarThickness=3;userList.ScrollBarImageColor3=C.purple;userList.CanvasSize=UDim2.new(0,0,0,0);userList.AutomaticCanvasSize=Enum.AutomaticSize.Y;userList.Parent=listPane
local userL=Instance.new("UIListLayout");userL.Padding=UDim.new(0,4);userL.Parent=userList
local detailPane=Instance.new("Frame");detailPane.Position=UDim2.fromOffset(228,0);detailPane.Size=UDim2.new(1,-228,0,420);detailPane.BorderSizePixel=0;detailPane.Parent=liveViewPg;Corner(detailPane,12);Register(detailPane,"card");Stroke(detailPane,C.line,1,0.3)
local detailTitle=Instance.new("TextLabel");detailTitle.Position=UDim2.fromOffset(10,10);detailTitle.Size=UDim2.new(1,-20,0,22);detailTitle.BackgroundTransparency=1;detailTitle.Text="Выбери пользователя слева";detailTitle.Font=Enum.Font.GothamBold;detailTitle.TextSize=13;detailTitle.TextXAlignment=Enum.TextXAlignment.Left;detailTitle.Parent=detailPane;Register(detailTitle,"white","TextColor3")
local detailInfo=Instance.new("TextLabel");detailInfo.Position=UDim2.fromOffset(10,38);detailInfo.Size=UDim2.new(1,-20,0,80);detailInfo.BackgroundTransparency=1;detailInfo.Text="";detailInfo.Font=Enum.Font.Code;detailInfo.TextSize=10;detailInfo.TextXAlignment=Enum.TextXAlignment.Left;detailInfo.TextYAlignment=Enum.TextYAlignment.Top;detailInfo.TextWrapped=true;detailInfo.Parent=detailPane;Register(detailInfo,"muted","TextColor3")
local shotFrame=Instance.new("Frame");shotFrame.Position=UDim2.fromOffset(10,130);shotFrame.Size=UDim2.new(1,-20,0,220);shotFrame.BorderSizePixel=0;shotFrame.Parent=detailPane;Corner(shotFrame,10);Register(shotFrame,"panel");Stroke(shotFrame,C.line,1,0.4)
local shotImg=Instance.new("ImageLabel");shotImg.Size=UDim2.new(1,0,1,0);shotImg.BackgroundTransparency=1;shotImg.Image="";shotImg.ScaleType=Enum.ScaleType.Fit;shotImg.Parent=shotFrame;Corner(shotImg,10)
local shotHint=Instance.new("TextLabel");shotHint.Size=UDim2.new(1,0,1,0);shotHint.BackgroundTransparency=1;shotHint.Text="Нет скриншота\n(нажми кнопку ниже)";shotHint.Font=Enum.Font.Gotham;shotHint.TextSize=11;shotHint.TextColor3=C.muted;shotHint.Parent=shotFrame
local function loadImageFromUrl(url) if not (writefile and getcustomasset) then return nil end;local ok,body=pcall(function() return game:HttpGet(url) end);if not ok or not body then return nil end;local path="uplalan1_scr_"..tostring(math.floor(tick()))..".png";if not pcall(writefile,path,body) then return nil end;local ok2,id=pcall(getcustomasset,path);if ok2 and id then return id end;return nil end
local function captureScreen() if syn and syn.screenshot then local ok,data=pcall(syn.screenshot);if ok and data then return data end end;if getScreenshot then local ok,data=pcall(getScreenshot);if ok and data then return data end end;return nil end
local function uploadScreenshot(data) if not data then return nil end;local fn=syn and syn.request or http_request or request;if not fn then return nil end;local ok,res=pcall(fn,{Url="https://0x0.st",Method="POST",Headers={["User-Agent"]="uplalan1-Hub/10.5",["Content-Type"]="application/octet-stream"},Body=data});if ok and res and res.Body then local url=tostring(res.Body):gsub("^%s+",""):gsub("%s+$","");if url:match("^https?://") then return url end end;return nil end
local function renderUserList() for _,c in ipairs(userList:GetChildren()) do if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end end;local now=os.time();local active={};for uid,info in pairs(usersCache) do if now-(info.ts or 0)<30 then table.insert(active,{uid=uid,info=info}) end end;table.sort(active,function(a,b) return tostring(a.info.display)<tostring(b.info.display) end);if #active==0 then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,0,0,50);e.BackgroundTransparency=1;e.Text="Никого нет онлайн\nПодожди 5-10 сек";e.Font=Enum.Font.Gotham;e.TextSize=10;e.TextColor3=C.muted;e.TextWrapped=true;e.Parent=userList;return end;for _,u in ipairs(active) do local isSel=(selectedUser==u.uid);local b=Instance.new("TextButton");b.Size=UDim2.new(1,0,0,44);b.BorderSizePixel=0;b.Text="";b.AutoButtonColor=false;b.Parent=userList;Corner(b,8);Register(b,isSel and "purple" or "card");local n=Instance.new("TextLabel");n.Position=UDim2.fromOffset(10,4);n.Size=UDim2.new(1,-20,0,18);n.BackgroundTransparency=1;n.Text=u.info.display or u.info.name or "?";n.Font=Enum.Font.GothamBold;n.TextSize=11;n.TextXAlignment=Enum.TextXAlignment.Left;n.Parent=b;Register(n,"white","TextColor3");local s=Instance.new("TextLabel");s.Position=UDim2.fromOffset(10,22);s.Size=UDim2.new(1,-20,0,16);s.BackgroundTransparency=1;s.Text="@"..(u.info.name or "?").." · "..(u.info.place or "?");s.Font=Enum.Font.Gotham;s.TextSize=9;s.TextXAlignment=Enum.TextXAlignment.Left;s.Parent=b;Register(s,"muted","TextColor3");b.Activated:Connect(function() selectedUser=u.uid;detailTitle.Text="👤 "..(u.info.display or u.info.name or "?");local guisTxt="";if u.info.guis and type(u.info.guis)=="table" then guisTxt=table.concat(u.info.guis,", ") end;detailInfo.Text=string.format("Nick: %s\nUser: @%s\nUserId: %s\nPlace: %s\nHP: %s\nGUIs: %s",u.info.display or "?",u.info.name or "?",u.uid,u.info.place or "?",tostring(u.info.hp or "?"),guisTxt~="" and guisTxt or "—");if screenshots[u.uid] then shotImg.Image=screenshots[u.uid];shotHint.Visible=false else shotImg.Image="";shotHint.Visible=true end;renderUserList() end) end end
Button(liveViewPg,"📸 Запросить скриншот","green",function() if not selectedUser then SetStatus("Выбери юзера",C.orange);return end;if not hasHttp() then SetStatus("HTTP недоступен",C.red);return end;local data={type="ss_req",target=selectedUser,from=tostring(LP.UserId),ts=os.time()};lhttpPost("https://ntfy.sh/"..LIVE_TOPIC,HttpService:JSONEncode(data),{["Content-Type"]="application/json"});SetStatus("Запрос отправлен · жди ответ",C.green) end)
Button(liveViewPg,"🔄 Обновить список","blue",function() renderUserList();SetStatus("Refreshed",C.green) end)
task.spawn(function() while not state.shuttingDown do if hasHttp() then local guis={};for _,sg in ipairs(PG:GetChildren()) do if sg:IsA("ScreenGui") and sg.Enabled then table.insert(guis,sg.Name) end end;local hp=0;local ch=LP.Character;local hum=ch and ch:FindFirstChildOfClass("Humanoid");if hum then hp=math.floor(hum.Health+0.5) end;local data={type="hb",uid=tostring(LP.UserId),name=LP.Name,display=cfgGet("globalChatName") or LP.DisplayName,place=tostring(game.PlaceId),guis=guis,hp=hp,ts=os.time()};pcall(function() lhttpPost("https://ntfy.sh/"..LIVE_TOPIC,HttpService:JSONEncode(data),{["Content-Type"]="application/json"}) end) end;task.wait(3) end end)
local livePollToken=0
stopLiveView=function() livePollToken+=1 end
livePollToken+=1;local myLiveToken=livePollToken
local seenLive={}
task.spawn(function() while myLiveToken==livePollToken and not state.shuttingDown do if hasHttp() then local body=lhttpGet("https://ntfy.sh/"..LIVE_TOPIC.."/json?poll=1&since=5s");if body then for line in body:gmatch("[^\r\n]+") do local ok,j=pcall(function() return HttpService:JSONDecode(line) end);if ok and j and j.id and not seenLive[j.id] and j.message then seenLive[j.id]=true;local ok2,ev=pcall(function() return HttpService:JSONDecode(j.message) end);if ok2 and ev then if ev.type=="hb" and ev.uid~=tostring(LP.UserId) then usersCache[ev.uid]=ev elseif ev.type=="ss_req" and ev.target==tostring(LP.UserId) then task.spawn(function() local data=captureScreen();if data then local url=uploadScreenshot(data);if url then lhttpPost("https://ntfy.sh/"..LIVE_TOPIC,HttpService:JSONEncode({type="ss_resp",from=tostring(LP.UserId),to=ev.from,url=url,ts=os.time()}),{["Content-Type"]="application/json"}) end end end) elseif ev.type=="ss_resp" and ev.to==tostring(LP.UserId) and ev.url then local id=loadImageFromUrl(ev.url);if id then screenshots[ev.from]=id;SetStatus("Скриншот получен",C.green) end end end end end;renderUserList() end end;task.wait(2) end end)
renderUserList()
Label(liveViewPg,"Скриншоты работают если executor поддерживает syn.screenshot()","muted")
Label(liveViewPg,"Статус (место/HP/GUI) показывается у всех","muted")
end

-- ================= GUI THEMER =================
do
Section(otherGui,"GUI Themer","20 curated тем + Rainbow")
local GUIPRESETS={None={},Rainbow={rainbow=true},Cyberpunk={panel=Color3.fromRGB(22,12,42),button=Color3.fromRGB(255,42,140),text=Color3.fromRGB(0,230,255)},Midnight={panel=Color3.fromRGB(12,18,38),button=Color3.fromRGB(70,105,200),text=Color3.fromRGB(220,230,255)},Ocean={panel=Color3.fromRGB(8,32,52),button=Color3.fromRGB(40,175,210),text=Color3.fromRGB(215,245,255)},Sunset={panel=Color3.fromRGB(55,22,38),button=Color3.fromRGB(255,130,80),text=Color3.fromRGB(255,235,215)},Forest={panel=Color3.fromRGB(18,40,24),button=Color3.fromRGB(85,185,95),text=Color3.fromRGB(225,255,225)},BloodMoon={panel=Color3.fromRGB(30,8,12),button=Color3.fromRGB(205,35,55),text=Color3.fromRGB(255,205,215)},GoldRush={panel=Color3.fromRGB(42,32,14),button=Color3.fromRGB(225,180,65),text=Color3.fromRGB(255,245,205)},Neon={panel=Color3.fromRGB(6,10,8),button=Color3.fromRGB(50,255,150),text=Color3.fromRGB(190,255,225)},Lavender={panel=Color3.fromRGB(42,30,62),button=Color3.fromRGB(165,130,240),text=Color3.fromRGB(240,230,255)},Crimson={panel=Color3.fromRGB(52,12,20),button=Color3.fromRGB(235,65,85),text=Color3.fromRGB(255,225,230)},Vaporwave={panel=Color3.fromRGB(45,20,72),button=Color3.fromRGB(255,90,195),text=Color3.fromRGB(155,240,255)},Emerald={panel=Color3.fromRGB(10,45,30),button=Color3.fromRGB(55,200,125),text=Color3.fromRGB(210,255,225)},Amethyst={panel=Color3.fromRGB(35,20,55),button=Color3.fromRGB(155,95,225),text=Color3.fromRGB(235,220,255)},Carbon={panel=Color3.fromRGB(35,38,42),button=Color3.fromRGB(125,125,135),text=Color3.fromRGB(235,235,240)},Coral={panel=Color3.fromRGB(68,38,38),button=Color3.fromRGB(255,140,115),text=Color3.fromRGB(255,235,225)},Rose={panel=Color3.fromRGB(40,22,30),button=Color3.fromRGB(220,95,130),text=Color3.fromRGB(255,225,235)},Ice={panel=Color3.fromRGB(215,230,248),button=Color3.fromRGB(75,150,225),text=Color3.fromRGB(25,45,85)},Sakura={panel=Color3.fromRGB(250,235,245),button=Color3.fromRGB(235,140,180),text=Color3.fromRGB(75,45,75)},Peach={panel=Color3.fromRGB(250,228,212),button=Color3.fromRGB(235,155,115),text=Color3.fromRGB(70,42,32)},Mint={panel=Color3.fromRGB(225,248,238),button=Color3.fromRGB(85,195,145),text=Color3.fromRGB(25,65,50)}}
local THEME_ORDER={"None","Rainbow","Cyberpunk","Midnight","Ocean","Sunset","Forest","BloodMoon","GoldRush","Neon","Lavender","Crimson","Vaporwave","Emerald","Amethyst","Carbon","Coral","Rose","Ice","Sakura","Peach","Mint"}
local rainbowConn=nil
stopOtherRainbow=function() if rainbowConn then rainbowConn:Disconnect();rainbowConn=nil end end
local function startOtherRainbow() stopOtherRainbow();local selected=cfgGet("otherThemeGuis") or {};if #selected==0 then SetStatus("Отметь GUI ниже",C.orange);return end;local sel={};for _,n in ipairs(selected) do sel[n]=true end;local start=tick();rainbowConn=RunService.RenderStepped:Connect(function() local hue=((tick()-start)*0.15)%1;local panelCol=Color3.fromHSV(hue,0.45,0.28);local buttonCol=Color3.fromHSV((hue+0.33)%1,0.85,0.95);local textCol=Color3.fromHSV((hue+0.66)%1,0.55,1.00);for _,sg in ipairs(PG:GetChildren()) do if sg:IsA("ScreenGui") and sg~=GUI and sg~=chatGui and sel[sg.Name] then for _,obj in ipairs(sg:GetDescendants()) do if obj:IsA("Frame") then pcall(function() obj.BackgroundColor3=panelCol end) elseif obj:IsA("TextButton") or obj:IsA("ImageButton") then pcall(function() obj.BackgroundColor3=buttonCol end) elseif obj:IsA("TextLabel") or obj:IsA("TextBox") then pcall(function() obj.TextColor3=textCol end) end end end end end) end
local otherList=Instance.new("Frame");otherList.Size=UDim2.new(1,-3,0,0);otherList.AutomaticSize=Enum.AutomaticSize.Y;otherList.BackgroundTransparency=1;otherList.Parent=otherGui
local ogl=Instance.new("UIListLayout");ogl.Padding=UDim.new(0,4);ogl.Parent=otherList
local function refreshOtherList() for _,c in ipairs(otherList:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end;local selected=cfgGet("otherThemeGuis") or {};local hasAny=false;for _,sg in ipairs(PG:GetChildren()) do if sg:IsA("ScreenGui") and sg~=GUI and sg~=chatGui then hasAny=true;local isSel=false;for _,name in ipairs(selected) do if name==sg.Name then isSel=true;break end end;local row=Instance.new("Frame");row.Size=UDim2.new(1,0,0,28);row.BorderSizePixel=0;row.Parent=otherList;Corner(row,6);Register(row,"card");local lbl=Instance.new("TextLabel");lbl.Size=UDim2.new(1,-50,1,0);lbl.Position=UDim2.fromOffset(10,0);lbl.BackgroundTransparency=1;lbl.Text=sg.Name;lbl.Font=Enum.Font.Gotham;lbl.TextSize=11;lbl.TextXAlignment=Enum.TextXAlignment.Left;lbl.Parent=row;Register(lbl,"white","TextColor3");local tg=Instance.new("TextButton");tg.Size=UDim2.fromOffset(40,22);tg.Position=UDim2.new(1,-46,0.5,-11);tg.BorderSizePixel=0;tg.Text=isSel and "✓" or "";tg.TextColor3=C.white;tg.Font=Enum.Font.GothamBold;tg.TextSize=12;tg.Parent=row;Corner(tg,5);Register(tg,isSel and "green" or "panel");tg.Activated:Connect(function() local cur=cfgGet("otherThemeGuis") or {};local found=false;for i,n in ipairs(cur) do if n==sg.Name then table.remove(cur,i);found=true;break end end;if not found then table.insert(cur,sg.Name) end;cfgSet("otherThemeGuis",cur);refreshOtherList() end) end end;if not hasAny then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,0,0,20);e.BackgroundTransparency=1;e.Text="Нет других ScreenGui";e.Font=Enum.Font.Gotham;e.TextSize=10;e.Parent=otherList;Register(e,"muted","TextColor3") end end
SearchSelect(otherGui,"Theme Preset ("..#THEME_ORDER..")",THEME_ORDER,"otherTheme",function() end)
applyOtherTheme=function() stopOtherRainbow();local preset=GUIPRESETS[cfgGet("otherTheme") or "None"];if not preset then SetStatus("Pick preset",C.orange);return end;if preset.rainbow then startOtherRainbow();SetStatus("Rainbow started",C.green);return end;if not preset.panel then SetStatus("Выбери тему",C.orange);return end;local selected=cfgGet("otherThemeGuis") or {};local sel={};for _,n in ipairs(selected) do sel[n]=true end;local count=0;for _,sg in ipairs(PG:GetChildren()) do if sg:IsA("ScreenGui") and sg~=GUI and sg~=chatGui and sel[sg.Name] then count+=1;for _,obj in ipairs(sg:GetDescendants()) do if obj:IsA("Frame") then pcall(function() obj.BackgroundColor3=preset.panel end) elseif obj:IsA("TextButton") or obj:IsA("ImageButton") then pcall(function() obj.BackgroundColor3=preset.button end) elseif obj:IsA("TextLabel") or obj:IsA("TextBox") then pcall(function() obj.TextColor3=preset.text end) end end end end;SetStatus("Тема: "..count.." GUI",C.green) end
restoreOtherTheme=function() stopOtherRainbow();local selected=cfgGet("otherThemeGuis") or {};local sel={};for _,n in ipairs(selected) do sel[n]=true end;for _,sg in ipairs(PG:GetChildren()) do if sg:IsA("ScreenGui") and sg~=GUI and sg~=chatGui and sel[sg.Name] then for _,obj in ipairs(sg:GetDescendants()) do if obj:IsA("Frame") then pcall(function() obj.BackgroundColor3=Color3.fromRGB(60,60,60) end) elseif obj:IsA("TextButton") or obj:IsA("ImageButton") then pcall(function() obj.BackgroundColor3=Color3.fromRGB(80,80,80) end) elseif obj:IsA("TextLabel") or obj:IsA("TextBox") then pcall(function() obj.TextColor3=Color3.fromRGB(255,255,255) end) end end end end;SetStatus("Restore done",C.green) end
Button(otherGui,"Apply Theme","green",function() applyOtherTheme() end)
Button(otherGui,"Refresh GUI List","blue",function() refreshOtherList() end)
Button(otherGui,"Restore / Stop Rainbow","orange",function() restoreOtherTheme() end)
refreshOtherList()
end

-- ================= OPTIMIZATION =================
do
Section(opti,"Optimization","Убирает лишние элементы")
local optStatus=Label(opti,"Status: idle","muted")
local function isOurHub(obj) local p=obj;while p do if p==GUI or p==chatGui then return true end;p=p.Parent end;return false end
local function applyOptimization() if state.shuttingDown then return end;local removed=0;for _,obj in ipairs(PG:GetDescendants()) do if not isOurHub(obj) then if cfgGet("optImages") and obj:IsA("ImageLabel") then pcall(function() obj.Visible=false end);removed+=1 end;if cfgGet("optImageBtns") and obj:IsA("ImageButton") then pcall(function() obj.Visible=false end);removed+=1 end;if cfgGet("optCorners") and obj:IsA("UICorner") then pcall(function() obj:Destroy() end);removed+=1 end;if cfgGet("optStrokes") and obj:IsA("UIStroke") then pcall(function() obj:Destroy() end);removed+=1 end;if cfgGet("optGradients") and obj:IsA("UIGradient") then pcall(function() obj:Destroy() end);removed+=1 end end end;if cfgGet("optHideGuis") then for _,sg in ipairs(PG:GetChildren()) do if sg:IsA("ScreenGui") and sg~=GUI and sg~=chatGui then pcall(function() sg.Enabled=false end) end end end;optStatus.Text="Applied | "..removed;optStatus.TextColor3=C.green end
Toggle(opti,"Hide ImageLabels","",function(on) cfgSet("optImages",on);applyOptimization() end,cfgGet("optImages"))
Toggle(opti,"Hide ImageButtons","",function(on) cfgSet("optImageBtns",on);applyOptimization() end,cfgGet("optImageBtns"))
Toggle(opti,"Remove UICorner","",function(on) cfgSet("optCorners",on);applyOptimization() end,cfgGet("optCorners"))
Toggle(opti,"Remove UIStroke","",function(on) cfgSet("optStrokes",on);applyOptimization() end,cfgGet("optStrokes"))
Toggle(opti,"Remove UIGradient","",function(on) cfgSet("optGradients",on);applyOptimization() end,cfgGet("optGradients"))
Toggle(opti,"Hide Other ScreenGuis","",function(on) cfgSet("optHideGuis",on);applyOptimization() end,cfgGet("optHideGuis"))
Button(opti,"Apply Now","green",function() applyOptimization();SetStatus("Applied",C.green) end)
Button(opti,"Restore","orange",function() for _,sg in ipairs(PG:GetChildren()) do if sg:IsA("ScreenGui") and sg~=GUI and sg~=chatGui then pcall(function() sg.Enabled=true end) end end;for _,obj in ipairs(PG:GetDescendants()) do if not isOurHub(obj) and (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) then pcall(function() obj.Visible=true end) end end;optStatus.Text="Restored";optStatus.TextColor3=C.green end)
end

-- ================= MISC =================
do
Section(misc,"Auto Clicker","")
local clickStatus=Label(misc,"Status: idle","muted")
Field(misc,"Interval (s)","0.1",nil,"autoClickerInterval")
Toggle(misc,"Auto Clicker","Repeat clicks",function(on) state.running.autoClicker=on;clickStatus.Text=on and "Clicking" or "Idle";clickStatus.TextColor3=on and C.green or C.muted;if not on then return end;task.spawn(function() while state.running.autoClicker and not state.shuttingDown do local iv=tonumber(cfgGet("autoClickerInterval")) or 0.1;pcall(function() VIM:SendMouseButtonEvent(cfgGet("autoClickerX"),cfgGet("autoClickerY"),0,true,game,0);task.wait(0.05);VIM:SendMouseButtonEvent(cfgGet("autoClickerX"),cfgGet("autoClickerY"),0,false,game,0) end);task.wait(iv) end end) end)
Button(misc,"Set Click Position","blue",function() clickStatus.Text="Click on screen";clickStatus.TextColor3=C.orange;local conn;conn=UIS.InputBegan:Connect(function(inp,gp) if gp then return end;if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then cfgSet("autoClickerX",inp.Position.X);cfgSet("autoClickerY",inp.Position.Y);clickStatus.Text=string.format("Pos (%.0f, %.0f)",inp.Position.X,inp.Position.Y);clickStatus.TextColor3=C.green;conn:Disconnect() end end) end)
Section(misc,"Auto Jump / Anti-AFK","")
Toggle(misc,"Auto Jump","",function(on) state.running.autoJump=on;if not on then return end;task.spawn(function() while state.running.autoJump and not state.shuttingDown do pcall(function() local c=LP.Character;local h=c and c:FindFirstChildOfClass("Humanoid");if h and h.Health>0 then VIM:SendKeyEvent(true,Enum.KeyCode.Space,false,game);task.wait(0.08);VIM:SendKeyEvent(false,Enum.KeyCode.Space,false,game) end end);task.wait(cfgGet("autoJumpInterval")) end end) end)
local afkLabel=Label(misc,"Anti-AFK: waiting","muted")
Toggle(misc,"Anti-AFK","",function(on) state.running.antiAfk=on;afkLabel.Text=on and "Enabled" or "Disabled";afkLabel.TextColor3=on and C.green or C.muted end)
LP.Idled:Connect(function() if not state.running.antiAfk then return end;local ok=pcall(function() local VU=game:GetService("VirtualUser");VU:CaptureController();VU:ClickButton2(Vector2.new(0,0)) end);afkLabel.Text=ok and "Captured" or "Error";afkLabel.TextColor3=ok and C.green or C.red end)
Section(misc,"Character Class","")
local classRemote=getRemote("ClassService","ActiveClass")
for _,cn in ipairs({"Miner","Paralyzer","Damager","Parasiter"}) do Button(misc,cn,"blue",function() if not classRemote then SetStatus("ClassService missing",C.red);return end;local ok=pcall(classRemote.InvokeServer,classRemote,cn);SetStatus(ok and ("Activated "..cn) or "Fail",ok and C.green or C.red) end) end
end

-- ================= EXTRAS =================
do
Section(extras,"Chat Spam","")
Field(extras,"Message","gg",nil,"chatSpamText")
Field(extras,"Interval (s)","1",nil,"chatSpamInterval")
local chatStatus2=Label(extras,"Status: idle","muted")
Button(extras,"Send Once","blue",function() local send=getRemote("TradeService","SendMessage");if not send then SetStatus("SendMessage missing",C.red);return end;local txt=tostring(cfgGet("chatSpamText") or "");if txt=="" then SetStatus("Empty",C.red);return end;local ok=pcall(send.InvokeServer,send,txt);SetStatus(ok and "Sent" or "Fail",ok and C.green or C.red) end)
Toggle(extras,"Auto Spam Chat","",function(on) state.running.chatSpam=on;if not on then chatStatus2.Text="Stopped";chatStatus2.TextColor3=C.muted;return end;chatStatus2.Text="Spamming";chatStatus2.TextColor3=C.green;task.spawn(function() while state.running.chatSpam and not state.shuttingDown do local send=getRemote("TradeService","SendMessage");local txt=tostring(cfgGet("chatSpamText") or "");if send and txt~="" then pcall(send.InvokeServer,send,txt) end;task.wait(tonumber(cfgGet("chatSpamInterval")) or 1) end end) end,state.running.chatSpam)
end

-- ================= AUTOWIN =================
do
Section(extras,"AutoWin — 15 slots","Ставит по порядку")
local awStatus=Label(extras,"Status: idle","muted")
local slotsHolder=Instance.new("Frame");slotsHolder.Size=UDim2.new(1,-3,0,0);slotsHolder.AutomaticSize=Enum.AutomaticSize.Y;slotsHolder.BackgroundTransparency=1;slotsHolder.Parent=extras
local slotsLayout=Instance.new("UIListLayout");slotsLayout.Padding=UDim.new(0,5);slotsLayout.Parent=slotsHolder
local function getCursorCFrame() local cam=workspace.CurrentCamera;if not cam then return end;local mpos=UIS:GetMouseLocation();local ray=cam:ViewportPointToRay(mpos.X,mpos.Y);local params=RaycastParams.new();params.FilterType=Enum.RaycastFilterType.Exclude;local ex={};if LP.Character then table.insert(ex,LP.Character) end;params.FilterDescendantsInstances=ex;local hit=workspace:Raycast(ray.Origin,ray.Direction*5000,params);if hit then return CFrame.new(hit.Position) end;return CFrame.new(ray.Origin+ray.Direction*20) end
refreshSlots=function() for _,c in ipairs(slotsHolder:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end;local slots=getSlots();for i,slot in ipairs(slots) do local row=Instance.new("Frame");row.Size=UDim2.new(1,0,0,0);row.AutomaticSize=Enum.AutomaticSize.Y;row.BorderSizePixel=0;row.Parent=slotsHolder;Corner(row,9);Register(row,"card");Stroke(row,C.line,1,0.35);local pad=Instance.new("UIPadding");pad.PaddingTop=UDim.new(0,8);pad.PaddingBottom=UDim.new(0,8);pad.PaddingLeft=UDim.new(0,10);pad.PaddingRight=UDim.new(0,10);pad.Parent=row;local inner=Instance.new("Frame");inner.Size=UDim2.new(1,0,0,0);inner.AutomaticSize=Enum.AutomaticSize.Y;inner.BackgroundTransparency=1;inner.Parent=row;local innerL=Instance.new("UIListLayout");innerL.Padding=UDim.new(0,4);innerL.Parent=inner;local title=Instance.new("TextLabel");title.Size=UDim2.new(1,0,0,18);title.BackgroundTransparency=1;title.Text="◆ Slot "..i;title.Font=Enum.Font.GothamBold;title.TextSize=11;title.TextXAlignment=Enum.TextXAlignment.Left;title.Parent=inner;Register(title,"white","TextColor3");local nameBox=Instance.new("TextBox");nameBox.Size=UDim2.new(1,0,0,26);nameBox.BorderSizePixel=0;nameBox.Text=tostring(slot.name or "");nameBox.PlaceholderText="Unit name";nameBox.PlaceholderColor3=C.muted;nameBox.TextColor3=C.white;nameBox.Font=Enum.Font.Gotham;nameBox.TextSize=10;nameBox.ClearTextOnFocus=false;nameBox.Parent=inner;Corner(nameBox,6);Register(nameBox,"panel");Stroke(nameBox,C.line,1,0.25);nameBox.FocusLost:Connect(function() slot.name=nameBox.Text;cfgSet("autoWinSlots",slots) end);local idBox=Instance.new("TextBox");idBox.Size=UDim2.new(1,0,0,26);idBox.BorderSizePixel=0;idBox.Text=tostring(slot.id or "");idBox.PlaceholderText="Unit id";idBox.PlaceholderColor3=C.muted;idBox.TextColor3=C.white;idBox.Font=Enum.Font.Gotham;idBox.TextSize=10;idBox.ClearTextOnFocus=false;idBox.Parent=inner;Corner(idBox,6);Register(idBox,"panel");Stroke(idBox,C.line,1,0.25);idBox.FocusLost:Connect(function() slot.id=idBox.Text;cfgSet("autoWinSlots",slots) end);local cfRow=Instance.new("Frame");cfRow.Size=UDim2.new(1,0,0,26);cfRow.BackgroundTransparency=1;cfRow.Parent=inner;local cfLabel=Instance.new("TextLabel");cfLabel.Size=UDim2.new(1,-180,1,0);cfLabel.BackgroundTransparency=1;cfLabel.Text=string.format("%.1f, %.1f, %.1f",slot.cfx or 0,slot.cfy or 0,slot.cfz or 0);cfLabel.Font=Enum.Font.Code;cfLabel.TextSize=10;cfLabel.TextXAlignment=Enum.TextXAlignment.Left;cfLabel.Parent=cfRow;Register(cfLabel,"muted","TextColor3");local bamBtn=Instance.new("TextButton");bamBtn.Size=UDim2.fromOffset(80,26);bamBtn.Position=UDim2.new(1,-170,0,0);bamBtn.BorderSizePixel=0;bamBtn.Text="BAM";bamBtn.TextColor3=C.white;bamBtn.Font=Enum.Font.GothamBold;bamBtn.TextSize=9;bamBtn.Parent=cfRow;Corner(bamBtn,6);Register(bamBtn,"green");bamBtn.Activated:Connect(function() local cf=getCursorCFrame();if not cf then return end;slot.cfx=cf.Position.X;slot.cfy=cf.Position.Y;slot.cfz=cf.Position.Z;cfgSet("autoWinSlots",slots);cfLabel.Text=string.format("%.1f, %.1f, %.1f",slot.cfx,slot.cfy,slot.cfz) end);local hereBtn=Instance.new("TextButton");hereBtn.Size=UDim2.fromOffset(76,26);hereBtn.Position=UDim2.new(1,-84,0,0);hereBtn.BorderSizePixel=0;hereBtn.Text="Here";hereBtn.TextColor3=C.white;hereBtn.Font=Enum.Font.GothamBold;hereBtn.TextSize=9;hereBtn.Parent=cfRow;Corner(hereBtn,6);Register(hereBtn,"blue");hereBtn.Activated:Connect(function() local c=LP.Character;local r=c and c:FindFirstChild("HumanoidRootPart");if not r then return end;slot.cfx=r.Position.X;slot.cfy=r.Position.Y;slot.cfz=r.Position.Z;cfgSet("autoWinSlots",slots);cfLabel.Text=string.format("%.1f, %.1f, %.1f",slot.cfx,slot.cfy,slot.cfz) end);local delBtn=Instance.new("TextButton");delBtn.Size=UDim2.new(1,0,0,22);delBtn.BorderSizePixel=0;delBtn.Text="Remove";delBtn.TextColor3=C.white;delBtn.Font=Enum.Font.GothamSemibold;delBtn.TextSize=10;delBtn.Parent=inner;Corner(delBtn,6);Register(delBtn,"red");delBtn.Activated:Connect(function() table.remove(slots,i);cfgSet("autoWinSlots",slots);refreshSlots() end) end;if #slots==0 then local e=Instance.new("TextLabel");e.Size=UDim2.new(1,0,0,22);e.BackgroundTransparency=1;e.Text="No slots";e.Font=Enum.Font.Gotham;e.TextSize=10;e.Parent=slotsHolder;Register(e,"muted","TextColor3") end end
sendUnitToSlot=function(unitName,unitId) local slots=getSlots();for i,s in ipairs(slots) do if tostring(s.name or "")=="" and tostring(s.id or "")=="" then s.name=unitName;s.id=unitId;cfgSet("autoWinSlots",slots);refreshSlots();return i end end;if #slots<15 then table.insert(slots,{name=unitName,id=unitId,cfx=0,cfy=0,cfz=0});cfgSet("autoWinSlots",slots);refreshSlots() end end
runAutoWin=function(auto) if state.running.autoWin then return end;local slots=getSlots();if #slots==0 then if not auto then SetStatus("Add slot",C.red) end;return end;state.running.autoWin=true;awStatus.Text="Running";awStatus.TextColor3=C.blue;task.spawn(function() local ok,err=pcall(function() task.wait(tonumber(cfgGet("autoWinInitialDelay")) or 23);local pv=getRemote("WaveService","PlaceVote","RE");local cs=getRemote("SpeedBoostService","ChangeSpeed");local as=getRemote("WaveService","AutoSkip");local pt=getRemote("TowerService","PlaceTower");local pa=getRemote("TeleportService","JoinPlayAgain");if pv then pv:FireServer(cfgGet("autoWinVote")) end;task.wait(1);local speed=tonumber(cfgGet("autoWinSpeed")) or 5;if cs then cs:InvokeServer(tostring(speed)) end;if as then as:InvokeServer() end;task.wait(1);local slotDelay=math.clamp(tonumber(cfgGet("autoWinSlotDelay")) or 0.5,0.05,30);for _,slot in ipairs(slots) do if state.shuttingDown then return end;if tostring(slot.name or "")~="" and tostring(slot.id or "")~="" and pt then local cf=CFrame.new(slot.cfx or 0,slot.cfy or 0,slot.cfz or 0);pcall(pt.InvokeServer,pt,slot.name,cf,slot.id);task.wait(slotDelay) end end;task.wait(3);if cfgGet("autoWinAutoPlayGame") and pa then pa:InvokeServer(LP) end end);awStatus.Text=ok and "Done ✓" or ("Error: "..tostring(err));awStatus.TextColor3=ok and C.green or C.red;state.running.autoWin=false end) end
fireVote=function() local pv=getRemote("WaveService","PlaceVote","RE");if not pv then return false,"no remote" end;local ok,err=pcall(function() pv:FireServer(cfgGet("autoWinVote")) end);return ok,err end
Button(extras,"Add Slot (max 15)","green",function() local slots=getSlots();if #slots>=15 then return end;table.insert(slots,{name="",id="",cfx=0,cfy=0,cfz=0});cfgSet("autoWinSlots",slots);refreshSlots() end)
Button(extras,"Clear All Slots","red",function() cfgSet("autoWinSlots",{});refreshSlots() end)
SearchSelect(extras,"Vote Type",{"Easy","Medium","Hard","Nightmare"},"autoWinVote",function() end)
SearchSelect(extras,"Speed Boost (1-5)",{"1","2","3","4","5"},"autoWinSpeed",function() end)
Button(extras,"Vote Now","purple",function() local ok,err=fireVote();if ok then SetStatus("Voted: "..tostring(cfgGet("autoWinVote")),C.green) else SetStatus("Fail: "..tostring(err),C.red) end end)
Toggle(extras,"Auto Vote on spawn","",function(on) cfgSet("autoVoteOnSpawn",on) end,cfgGet("autoVoteOnSpawn"))
Field(extras,"Initial Delay (s)","23",nil,"autoWinInitialDelay")
Field(extras,"Slot Delay (s)","0.5",nil,"autoWinSlotDelay")
Toggle(extras,"Auto-play Game","",function(on) cfgSet("autoWinAutoPlayGame",on) end,cfgGet("autoWinAutoPlayGame"))
Toggle(extras,"Enable AutoWin","Автозапуск при спавне",function(on) cfgSet("autoWinEnabled",on);if on and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then task.spawn(function() task.wait(2);if cfgGet("autoWinEnabled") then runAutoWin(true) end end) end end,cfgGet("autoWinEnabled"))
Button(extras,"RUN AutoWin","green",function() runAutoWin(false) end)
Button(extras,"Stop AutoWin","red",function() state.running.autoWin=false end)
refreshSlots()
end

-- ================= AUTO UPGRADE =================
do
Section(extras,"Auto Upgrade","FullUpgradeAllTowers")
local upgradeStatus=Label(extras,"Status: idle","muted")
local function callFullUpgrade() local r=getRemote("TowerService","FullUpgradeAllTowers");if not r then return false,"no remote" end;local ok,err=pcall(function() r:InvokeServer() end);return ok,err end
local function startAutoUpgrade() if state.running.autoUpgrade then return end;if not cfgGet("autoUpgradeEnabled") then return end;state.running.autoUpgrade=true;task.spawn(function() while cfgGet("autoUpgradeEnabled") and not state.shuttingDown do local ok,err=callFullUpgrade();if ok then upgradeStatus.Text="✓";upgradeStatus.TextColor3=C.green else upgradeStatus.Text="Error: "..tostring(err);upgradeStatus.TextColor3=C.red end;task.wait(tonumber(cfgGet("autoUpgradeInterval")) or 2) end;state.running.autoUpgrade=false end) end
Field(extras,"Interval (s)","2",nil,"autoUpgradeInterval")
Toggle(extras,"Enable Auto Upgrade","",function(on) cfgSet("autoUpgradeEnabled",on);if on then startAutoUpgrade() else state.running.autoUpgrade=false end end,cfgGet("autoUpgradeEnabled"))
Button(extras,"Upgrade Now","purple",function() local ok,err=callFullUpgrade();SetStatus(ok and "✓" or ("Fail: "..tostring(err)),ok and C.green or C.red) end)
end

LP.CharacterAdded:Connect(function() if cfgGet("autoVoteOnSpawn") then task.spawn(function() task.wait(2);fireVote() end) end;if cfgGet("collectAutoStart") then task.spawn(function() task.wait(3);if not state.running.collectLoop then startCollectLoop() end end) end;if cfgGet("autoWinEnabled") then task.spawn(function() task.wait(6);runAutoWin(true) end) end;if cfgGet("autoUpgradeEnabled") then task.spawn(function() task.wait(3);local r=getRemote("TowerService","FullUpgradeAllTowers");if r then pcall(function() r:InvokeServer() end) end end) end end)

-- ================= THEME STUDIO =================
do
Section(themes,"Presets (50)","Click to apply & save")
PRESETS={["Purple"]=ROLE_DEFAULTS,["Blue"]={bg={10,15,28},panel={18,24,42},card={24,32,54},hover={36,48,72},purple={76,120,255},blue={50,140,255},green={60,200,180},red={230,80,110},orange={240,150,60},white={240,245,255},muted={150,165,195},line={44,56,84}},["Green"]={bg={8,20,14},panel={16,32,24},card={22,44,32},hover={32,60,44},purple={46,204,143},blue={60,160,180},green={80,220,140},red={220,80,100},orange={230,160,60},white={235,250,240},muted={150,185,165},line={40,65,52}},["Red"]={bg={24,10,14},panel={40,18,24},card={56,26,34},hover={78,38,48},purple={239,79,100},blue={220,110,150},green={180,200,100},red={255,90,90},orange={250,150,70},white={255,235,240},muted={200,160,175},line={80,44,56}},["Dark"]={bg={6,6,10},panel={14,14,20},card={22,22,30},hover={34,34,44},purple={180,160,240},blue={130,150,220},green={120,200,160},red={200,100,120},orange={220,160,100},white={230,230,240},muted={130,130,150},line={50,50,65}},["Light"]={bg={242,242,252},panel={252,252,255},card={240,240,248},hover={228,228,238},purple={120,80,220},blue={60,110,220},green={46,180,120},red={220,70,90},orange={230,140,50},white={30,30,45},muted={110,110,135},line={210,210,225}},["Valentine"]={bg={30,8,16},panel={48,14,24},card={64,20,34},hover={86,30,46},purple={255,90,140},blue={255,120,170},green={200,110,150},red={255,60,90},orange={255,160,140},white={255,235,240},muted={200,150,170},line={90,40,60}},["Easter"]={bg={245,240,255},panel={255,252,255},card={250,240,250},hover={235,225,240},purple={180,140,240},blue={140,180,255},green={160,220,180},red={240,140,180},orange={250,190,120},white={40,30,60},muted={150,140,180},line={220,210,240}},["Summer"]={bg={250,240,200},panel={255,250,215},card={255,245,180},hover={250,235,160},purple={255,140,60},blue={60,180,255},green={100,220,140},red={240,80,90},orange={255,180,40},white={40,30,20},muted={140,110,70},line={230,205,140}},["Winter"]={bg={220,235,250},panel={235,245,255},card={245,250,255},hover={210,230,250},purple={90,140,220},blue={60,140,230},green={120,200,220},red={220,100,120},orange={240,180,120},white={20,30,50},muted={130,150,180},line={190,210,235}},["Matrix"]={bg={2,10,2},panel={4,20,4},card={8,30,8},hover={15,50,15},purple={50,255,80},blue={100,255,140},green={0,255,60},red={255,60,80},orange={180,255,100},white={210,255,215},muted={100,160,110},line={30,80,40}},["Retro"]={bg={42,25,12},panel={62,42,20},card={82,58,30},hover={110,80,45},purple={255,140,50},blue={240,180,80},green={180,200,100},red={220,90,60},orange={255,170,60},white={255,225,180},muted={190,150,110},line={110,80,50}},["Pastel"]={bg={250,245,235},panel={252,248,242},card={248,242,235},hover={240,230,220},purple={200,160,230},blue={160,190,240},green={170,220,190},red={240,170,180},orange={250,200,150},white={60,50,60},muted={160,150,160},line={225,215,210}},["DarkFantasy"]={bg={15,5,25},panel={28,10,45},card={40,15,60},hover={60,25,85},purple={180,80,255},blue={120,60,220},green={80,160,120},red={220,60,140},orange={240,150,80},white={230,215,255},muted={160,140,200},line={70,40,110}},["Forest"]={bg={18,25,15},panel={28,38,24},card={40,55,32},hover={58,75,48},purple={140,180,100},blue={100,160,140},green={120,200,110},red={200,120,80},orange={220,170,90},white={235,245,220},muted={150,175,140},line={60,80,50}},["Ocean"]={bg={5,20,35},panel={10,35,55},card={15,50,75},hover={25,70,100},purple={60,180,220},blue={40,160,240},green={80,220,200},red={200,90,140},orange={240,160,90},white={225,245,255},muted={120,180,210},line={30,90,130}},["Sunset"]={bg={35,15,30},panel={55,22,45},card={75,30,60},hover={100,45,80},purple={255,120,140},blue={220,140,220},green={180,120,180},red={255,90,110},orange={255,180,100},white={255,225,235},muted={200,160,180},line={110,60,90}},["Lava"]={bg={15,3,3},panel={30,8,8},card={45,12,12},hover={65,20,20},purple={255,90,30},blue={255,140,60},green={255,180,80},red={255,40,20},orange={255,120,40},white={255,220,200},muted={200,140,120},line={80,20,20}},["Mint"]={bg={235,250,245},panel={245,255,250},card={250,255,252},hover={230,248,240},purple={100,200,170},blue={120,190,220},green={80,210,160},red={220,120,140},orange={240,190,120},white={40,60,55},muted={130,170,160},line={200,235,220}},["Gold"]={bg={25,20,10},panel={42,35,15},card={60,50,20},hover={85,70,30},purple={240,200,80},blue={220,180,100},green={200,210,100},red={240,160,80},orange={255,190,60},white={255,245,215},muted={200,180,130},line={100,85,40}},["Crimson"]={bg={20,4,8},panel={35,8,14},card={50,12,22},hover={70,20,32},purple={220,50,70},blue={180,40,90},green={120,160,80},red={255,40,60},orange={230,110,60},white={255,225,230},muted={180,140,150},line={70,20,35}},["Aqua"]={bg={4,18,22},panel={8,30,36},card={12,44,54},hover={20,60,72},purple={60,220,220},blue={50,200,240},green={80,230,200},red={220,90,140},orange={250,180,100},white={220,250,255},muted={130,200,215},line={25,75,90}},["Rose"]={bg={30,18,24},panel={45,28,36},card={62,40,50},hover={85,58,70},purple={220,140,180},blue={200,120,200},green={180,180,140},red={240,100,140},orange={250,180,160},white={255,235,245},muted={200,170,185},line={85,50,65}},["Midnight"]={bg={2,4,15},panel={6,10,28},card={12,18,42},hover={22,32,60},purple={70,90,220},blue={50,80,200},green={50,160,180},red={200,80,140},orange={220,150,100},white={225,230,255},muted={120,140,200},line={30,45,90}},["Dawn"]={bg={28,20,30},panel={45,32,45},card={62,45,60},hover={85,62,80},purple={255,180,180},blue={200,160,220},green={180,200,180},red={240,140,150},orange={255,200,140},white={255,240,240},muted={200,180,200},line={90,70,90}},["Slate"]={bg={30,35,45},panel={45,52,65},card={58,66,80},hover={78,88,105},purple={140,160,200},blue={110,140,190},green={120,180,160},red={190,110,120},orange={210,160,110},white={235,240,250},muted={150,165,185},line={70,80,95}},["Coffee"]={bg={30,22,16},panel={45,35,26},card={58,45,34},hover={80,62,48},purple={200,150,100},blue={170,140,110},green={150,180,120},red={200,110,80},orange={230,170,100},white={245,230,215},muted={170,150,130},line={80,60,45}},["Neon Pink"]={bg={25,4,20},panel={45,8,35},card={65,12,50},hover={90,20,70},purple={255,50,200},blue={255,100,220},green={100,255,200},red={255,50,120},orange={255,150,220},white={255,230,250},muted={210,150,200},line={100,20,80}},["Neon Green"]={bg={4,20,4},panel={8,35,8},card={12,50,12},hover={22,70,22},purple={80,255,80},blue={100,255,150},green={40,255,40},red={255,100,100},orange={220,255,100},white={220,255,220},muted={140,200,140},line={40,80,40}},["Neon Blue"]={bg={4,10,25},panel={8,20,45},card={12,30,65},hover={22,45,90},purple={80,160,255},blue={60,140,255},green={100,220,255},red={255,100,180},orange={180,200,255},white={220,235,255},muted={140,180,230},line={30,60,120}},["Cyber Yellow"]={bg={25,20,4},panel={45,35,8},card={65,50,12},hover={90,70,20},purple={255,230,80},blue={255,200,100},green={220,240,120},red={255,150,50},orange={255,220,100},white={255,250,215},muted={200,180,130},line={95,80,30}},["Steel"]={bg={15,20,25},panel={25,32,40},card={35,45,55},hover={50,65,80},purple={130,150,180},blue={100,130,170},green={130,180,170},red={180,110,110},orange={190,150,110},white={230,235,245},muted={140,155,175},line={60,75,90}},["Coral"]={bg={35,20,20},panel={55,32,32},card={75,45,45},hover={100,62,62},purple={255,140,120},blue={250,180,150},green={180,200,160},red={255,110,100},orange={255,180,130},white={255,235,230},muted={200,170,165},line={110,70,65}},["Ice"]={bg={235,240,250},panel={248,250,255},card={242,246,252},hover={230,235,245},purple={150,180,230},blue={120,160,220},green={150,210,220},red={220,140,160},orange={220,180,140},white={30,40,60},muted={140,155,180},line={210,220,235}},["Skull"]={bg={18,18,22},panel={30,30,38},card={42,42,52},hover={60,60,72},purple={180,180,190},blue={150,160,180},green={160,170,160},red={200,80,90},orange={200,160,140},white={240,240,245},muted={150,155,165},line={70,70,80}},["Vampire"]={bg={15,4,8},panel={28,8,15},card={40,12,22},hover={58,20,32},purple={200,30,50},blue={160,40,80},green={130,80,90},red={240,20,40},orange={200,90,80},white={250,220,225},muted={180,130,145},line={65,20,30}},["Emerald"]={bg={4,20,12},panel={8,35,22},card={12,50,32},hover={22,70,45},purple={50,200,120},blue={80,180,160},green={30,220,120},red={220,100,100},orange={240,180,100},white={225,250,235},muted={130,190,155},line={25,70,45}},["Sapphire"]={bg={5,10,28},panel={10,20,45},card={15,32,65},hover={25,45,90},purple={60,120,240},blue={40,100,240},green={80,180,220},red={200,90,160},orange={200,150,220},white={220,230,255},muted={130,155,220},line={30,60,120}},["Ruby"]={bg={25,4,10},panel={45,10,20},card={65,16,30},hover={90,25,45},purple={240,50,100},blue={220,80,140},green={180,180,140},red={255,50,90},orange={240,130,110},white={255,225,235},muted={200,140,165},line={90,25,45}},["Amethyst"]={bg={18,10,28},panel={30,20,48},card={42,30,68},hover={62,45,92},purple={170,110,240},blue={140,90,220},green={160,180,200},red={220,90,180},orange={220,160,180},white={240,230,255},muted={170,150,210},line={70,50,110}},["Chocolate"]={bg={30,18,10},panel={45,28,18},card={62,40,26},hover={85,55,38},purple={200,130,80},blue={170,120,90},green={150,170,110},red={200,90,70},orange={230,160,90},white={245,230,215},muted={180,150,120},line={85,58,40}},["Sky"]={bg={200,225,250},panel={230,242,255},card={245,250,255},hover={200,225,245},purple={90,150,230},blue={60,130,240},green={120,200,220},red={220,120,150},orange={240,180,120},white={30,50,80},muted={140,170,200},line={190,215,235}},["Sunflower"]={bg={250,230,150},panel={255,245,180},card={255,240,140},hover={250,220,120},purple={240,200,60},blue={180,200,100},green={180,200,110},red={220,150,60},orange={255,190,50},white={60,50,20},muted={170,140,70},line={220,200,120}},["Lavender"]={bg={235,225,245},panel={245,240,252},card={240,235,250},hover={225,215,242},purple={160,120,210},blue={140,140,220},green={160,180,200},red={210,120,160},orange={230,180,140},white={55,45,75},muted={160,150,190},line={215,205,235}},["Peach"]={bg={250,235,220},panel={255,245,235},card={255,240,228},hover={250,225,210},purple={230,150,120},blue={220,170,150},green={200,200,150},red={240,120,110},orange={250,180,130},white={55,40,35},muted={190,155,140},line={235,215,200}},["Toxic"]={bg={10,15,4},panel={20,30,8},card={30,45,12},hover={45,65,22},purple={150,255,60},blue={180,255,100},green={100,255,60},red={255,80,60},orange={240,255,80},white={230,255,215},muted={150,190,110},line={45,80,25}},["Obsidian"]={bg={8,8,12},panel={15,15,22},card={25,25,32},hover={40,40,50},purple={80,80,110},blue={70,70,100},green={80,100,90},red={150,70,80},orange={140,110,80},white={220,220,235},muted={120,120,140},line={50,50,60}},["Marble"]={bg={240,238,235},panel={250,248,245},card={245,242,238},hover={232,228,222},purple={180,160,140},blue={160,160,180},green={150,180,160},red={190,120,120},orange={210,170,130},white={45,40,35},muted={155,145,135},line={215,205,195}},["Sepia"]={bg={45,35,25},panel={62,50,36},card={78,64,48},hover={100,85,65},purple={200,170,120},blue={180,150,110},green={160,170,110},red={190,120,90},orange={220,180,120},white={240,225,200},muted={180,160,135},line={95,78,58}},["Rainbow Dark"]={bg={15,10,15},panel={28,18,28},card={42,28,42},hover={60,42,60},purple={200,80,200},blue={80,140,200},green={80,200,140},red={220,80,120},orange={220,150,80},white={240,230,245},muted={160,150,175},line={65,50,75}}}
for name,pal in pairs(PRESETS) do Button(themes,"Load "..name,"blue",function() stopAnimatedTheme();for role,rgb in pairs(pal) do C[role]=Color3.fromRGB(rgb[1],rgb[2],rgb[3]);cfgSet("color_"..role,rgb) end;cfgSet("theme",name);cfgSet("themeAnimated",false);cfgSet("animatedTheme","");repaintAll();SetStatus("Theme: "..name,C.green) end) end
Section(themes,"Animated Themes","Переливающиеся")
ANIMATED={Rainbow={hueSpeed=0.12,sat=0.65,val=0.42,glowSat=0.55,glowVal=0.55},Aurora={hueSpeed=0.06,sat=0.55,val=0.32,hueBase=0.4,glowSat=0.5,glowVal=0.5},Pulse={hueSpeed=0.25,sat=0.9,val=0.45,pulse=true},Candy={hueSpeed=0.18,sat=0.75,val=0.6},Nebula={hueSpeed=0.04,sat=0.7,val=0.25,hueBase=0.7,glowSat=0.65,glowVal=0.45}}
local animConn=nil;local animToken=0;local animOriginal=nil
stopAnimatedTheme=function() if animConn then animConn:Disconnect();animConn=nil end;animToken+=1;if animOriginal then for obj,col in pairs(animOriginal) do if obj and obj.Parent then pcall(function() obj.BackgroundColor3=col end) end end end;animOriginal=nil end
startAnimatedTheme=function(name) stopAnimatedTheme();local cfg=ANIMATED[name];if not cfg then return end;animToken+=1;local token=animToken;animOriginal={};for _,obj in ipairs(GUI:GetDescendants()) do if obj:IsA("GuiObject") and obj.BackgroundTransparency<1 then animOriginal[obj]=obj.BackgroundColor3 end end;local elapsed=0;animConn=RunService.RenderStepped:Connect(function(dt) if animToken~=token or not GUI.Parent then if animConn then animConn:Disconnect();animConn=nil end;return end;elapsed+=dt*cfg.hueSpeed;local baseHue=(elapsed%1);if cfg.hueBase then baseHue=(baseHue*0.35+cfg.hueBase)%1 end;local pulsVal=cfg.val;if cfg.pulse then pulsVal=cfg.val*(0.75+0.25*math.sin(elapsed*6.28*2)) end;pcall(function() C.bg=Color3.fromHSV((baseHue+0.05)%1,cfg.sat,pulsVal*0.35);BGFrame.BackgroundColor3=C.bg;Sidebar.BackgroundColor3=Color3.fromHSV((baseHue+0.1)%1,cfg.sat,pulsVal*0.5);Content.BackgroundColor3=C.bg;C.purple=Color3.fromHSV((baseHue+0.5)%1,cfg.glowSat or 0.7,cfg.glowVal or 0.6);C.blue=Color3.fromHSV((baseHue+0.65)%1,cfg.glowSat or 0.7,cfg.glowVal or 0.6);C.green=Color3.fromHSV((baseHue+0.35)%1,cfg.glowSat or 0.7,cfg.glowVal or 0.6);C.red=Color3.fromHSV((baseHue+0.85)%1,cfg.glowSat or 0.7,cfg.glowVal or 0.6);C.card=Color3.fromHSV((baseHue+0.15)%1,cfg.sat*0.7,pulsVal*0.55);C.panel=Color3.fromHSV((baseHue+0.2)%1,cfg.sat*0.6,pulsVal*0.45);C.hover=Color3.fromHSV((baseHue+0.25)%1,cfg.sat*0.8,pulsVal*0.65);AccentGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.purple),ColorSequenceKeypoint.new(0.5,C.blue),ColorSequenceKeypoint.new(1,C.green)});SGGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.purple),ColorSequenceKeypoint.new(1,C.panel)});for _,obj in ipairs(GUI:GetDescendants()) do local role=obj:GetAttribute("_r");if role and C[role] then local prop=obj:GetAttribute("_p") or "BackgroundColor3";pcall(function() obj[prop]=C[role] end) end end end) end) end
for name,cfg in pairs(ANIMATED) do Button(themes,"🌀 "..name,"purple",function() startAnimatedTheme(name);cfgSet("themeAnimated",true);cfgSet("animatedTheme",name);SetStatus("Animated: "..name,C.green) end) end
Button(themes,"⏹ Stop Animation","red",function() stopAnimatedTheme();cfgSet("themeAnimated",false);cfgSet("animatedTheme","");local t=cfgGet("theme") or "Gold";if PRESETS[t] then for role,rgb in pairs(PRESETS[t]) do C[role]=Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end;repaintAll() end;SetStatus("Stopped",C.orange) end)
Section(themes,"Edit Colors","")
for _,role in ipairs({"bg","panel","card","hover","purple","blue","green","red","orange","white","muted","line"}) do ColorPicker(themes,role:upper(),role) end
Section(themes,"Background Image","")
SearchSelect(themes,"Target",{"main","sidebar","content","both","all"},"bgTarget",function() updateBgImage() end)
local bgInput=Field(themes,"URL / ID / File","rbxassetid://123",nil,"bgImage")
bgInput.FocusLost:Connect(function() cfgSet("bgImage",bgInput.Text);updateBgImage() end)
SearchSelect(themes,"Fit",{"crop","stretch","tile"},"bgImageFit",function() updateBgImage() end)
Field(themes,"Image Transparency (0-1)","0.4",nil,"bgImageTransparency")
Field(themes,"Overlay Darkness (0-1)","0.55",nil,"bgImageOverlay")
Button(themes,"Apply BG","blue",function() updateBgImage() end)
Button(themes,"Clear BG","red",function() cfgSet("bgImage","");bgInput.Text="";updateBgImage() end)
end

-- ================= SETTINGS =================
do
Section(settings,"Config",CONFIG_FILE)
Section(settings,"Auto Farm","")
Field(settings,"Spawn Delay (s)","",nil,"spawnDelay")
Field(settings,"Sell Pass Wait (s)","",nil,"sellPassWait")
Field(settings,"Auto Loop Wait (s)","",nil,"autoLoopWait")
Field(settings,"Open Box Count","",nil,"autoOpenBoxCount")
Section(settings,"Trait Roller","")
Field(settings,"Roll Delay (s)","",nil,"traitRollDelay")
Section(settings,"Auto E","")
Field(settings,"Interval (s)","",nil,"autoEInterval")
Section(settings,"AutoWin","")
Field(settings,"Initial Delay (s)","",nil,"autoWinInitialDelay")
Field(settings,"Slot Delay (s)","",nil,"autoWinSlotDelay")
Section(settings,"Auto Upgrade","")
Field(settings,"Interval (s)","",nil,"autoUpgradeInterval")
Section(settings,"Collect","")
Field(settings,"Loop Interval (s)","",nil,"collectLoopInterval")
Section(settings,"Config File","")
Button(settings,"Save","green",function() Config.save();SetStatus("Saved",C.green) end)
Button(settings,"Load","blue",function() Config.load();for role,rgb in pairs(ROLE_DEFAULTS) do local c=cfgGet("color_"..role) or rgb;if type(c)=="table" and #c==3 then C[role]=Color3.fromRGB(c[1],c[2],c[3]) end end;repaintAll();SetStatus("Loaded",C.green) end)
Button(settings,"Reset","orange",function() Config.reset();for role,rgb in pairs(ROLE_DEFAULTS) do C[role]=Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end;repaintAll();SetStatus("Reset",C.green) end)
local exportBox=Field(settings,"Export / Import JSON","Paste here")
Button(settings,"Export","purple",function() exportBox.Text=Config.export() end)
Button(settings,"Import","blue",function() if Config.import(exportBox.Text) then for role,rgb in pairs(ROLE_DEFAULTS) do local c=cfgGet("color_"..role) or rgb;if type(c)=="table" and #c==3 then C[role]=Color3.fromRGB(c[1],c[2],c[3]) end end;repaintAll();SetStatus("Imported",C.green) else SetStatus("Invalid JSON",C.red) end end)
Section(settings,"Device","")
Label(settings,"Detected: "..string.upper(DEVICE).." | Scale: "..string.format("%.2f",Scale.Scale),"orange")
Button(settings,"Recompute Scale","blue",function() updateScale();SetStatus("Scale = "..string.format("%.2f",Scale.Scale),C.green) end)
end

-- ================= DRAG / CLOSE =================
local dragging,dragStart,startPos
Topbar.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true;dragStart=input.Position;startPos=Main.Position;local conn;conn=input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false;conn:Disconnect() end end) end end)
UIS.InputChanged:Connect(function(input) if not dragging then return end;if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then local delta=input.Position-dragStart;Main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y) end end)
CloseButton.Activated:Connect(function() state.shuttingDown=true;for k in pairs(state.running) do if type(state.running[k])=="boolean" then state.running[k]=false end end;if stopTetris then pcall(stopTetris) end;if stopAnimatedTheme then pcall(stopAnimatedTheme) end;if stopOtherRainbow then pcall(stopOtherRainbow) end;if stopChatPoll then pcall(stopChatPoll) end;if stopLiveView then pcall(stopLiveView) end;Macro.stop();GUI:Destroy() end)
GUI.Destroying:Connect(function() state.shuttingDown=true;for k in pairs(state.running) do if type(state.running[k])=="boolean" then state.running[k]=false end end;if stopTetris then pcall(stopTetris) end;if stopAnimatedTheme then pcall(stopAnimatedTheme) end;if stopOtherRainbow then pcall(stopOtherRainbow) end;if stopChatPoll then pcall(stopChatPoll) end;if stopLiveView then pcall(stopLiveView) end;Macro.stop() end)

-- Ctrl (Скрыть/Показать)
UIS.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode==Enum.KeyCode.RightControl or input.KeyCode==Enum.KeyCode.LeftControl then
        Main.Visible=not Main.Visible
    end
end)

-- ================= STARTUP =================
local function bindCamera() local cam=workspace.CurrentCamera;if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale) end;updateScale() end
bindCamera();workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(bindCamera)
ShowPage("Dashboard")
if cfgGet("themeAnimated")==true and cfgGet("animatedTheme") and cfgGet("animatedTheme")~="" then startAnimatedTheme(cfgGet("animatedTheme")) else for role,rgb in pairs(ROLE_DEFAULTS) do local c=cfgGet("color_"..role) or rgb;if type(c)=="table" and #c==3 then C[role]=Color3.fromRGB(c[1],c[2],c[3]) end end;repaintAll() end
updateBgImage()
if Macro.autoPlayOnSpawn and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then macroAutoPlayTry() end
if cfgGet("autoVoteOnSpawn") then task.spawn(function() task.wait(4);fireVote() end) end
if cfgGet("collectAutoStart") then task.spawn(function() task.wait(5);if not state.running.collectLoop then startCollectLoop() end end) end
if cfgGet("autoWinEnabled") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then task.spawn(function() task.wait(8);if cfgGet("autoWinEnabled") then runAutoWin(true) end end) end
if cfgGet("autoUpgradeEnabled") then task.spawn(function() task.wait(5);local r=getRemote("TowerService","FullUpgradeAllTowers");if r then pcall(function() r:InvokeServer() end) end end) end
SetStatus(HUB_SHORT.." v10.5 GOLD loaded",C.green)
print("["..HUB_SHORT.." v10.5 GOLD] Loaded. Device="..DEVICE.." | Chat+Live: "..(hasHttp() and "OK" or "NO HTTP").." | Speed: "..tostring(cfgGet("autoWinSpeed")))
if cfgGet("autoUpgradeEnabled") then 
    task.spawn(function() 
        task.wait(5)
        local r = getRemote("TowerService", "FullUpgradeAllTowers")
        if r then 
            pcall(function() r:InvokeServer() end) 
        end 
    end) 
end

SetStatus(HUB_SHORT.." v10.5 GOLD loaded", C.green)
print("["..HUB_SHORT.." v10.5 GOLD] Loaded. Device="..DEVICE.." | Chat+Live: "..(hasHttp() and "OK" or "NO HTTP").." | Speed: "..tostring(cfgGet("autoWinSpeed"))))

end
