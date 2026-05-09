local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🪽FunScripts🪽",
   Icon = 0, 
   LoadingTitle = "🪽FunScriptss🪽",
   LoadingSubtitle = "by Benjamin",
   Theme = "Default",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "FunScriptsData", 
      FileName = "FunscriptsGuiFF1"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Key: mosanzcd",
      Note = "Key is required!",
      FileName = "Keyforent1r11",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"mosanzcd"}
   }
})

local MainTab = Window:CreateTab("🏡 Home 🏡", nil) 
local MainSection = MainTab:CreateSection("Fun Stuff")

-- Variables
local replicated = game:GetService("ReplicatedStorage")
local scriptfolder = replicated:FindFirstChild("HiddenScripts") or Instance.new("Folder", replicated)
scriptfolder.Name = "HiddenScripts"

local goldPartsList = {} -- Stores parts for the TP button
local tpIndex = 1 -- Keeps track of which gold part to TP to next

-- ESP & Cleanup Button
local Button = MainTab:CreateButton({
   Name = "ESP & Clean Chests",
   Callback = function()
      goldPartsList = {} -- Reset list
      tpIndex = 1
      
      for _, v in workspace:GetDescendants() do 
          if v.Name == "Gold" then 
              table.insert(goldPartsList, v)
              
              -- 1. Highlight Logic
              if v:FindFirstChild("GoldHighlight") then v.GoldHighlight:Destroy() end
              local highlight = Instance.new("Highlight")
              highlight.Name = "GoldHighlight"
              highlight.FillColor = Color3.fromRGB(255, 215, 0)
              highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
              highlight.Parent = v

              -- 2. Cleanup Logic: Delete siblings in the parent folder
              local parentFolder = v.Parent
              if parentFolder then
                  for _, sibling in parentFolder:GetChildren() do
                      -- Deletes everything that isn't the Gold part or the Highlight
                      if sibling ~= v and not sibling:IsA("Highlight") then
                          sibling:Destroy()
                      end
                  end
              end
          end 
      end
      
      Rayfield:Notify({
          Title = "Success",
          Content = "Chests cleaned and highlights added!",
          Duration = 3
      })
   end,
})

-- Teleport Button
local TPButton = MainTab:CreateButton({
   Name = "TP to Next Gold",
   Callback = function()
      if #goldPartsList == 0 then
          Rayfield:Notify({Title = "Error", Content = "Run ESP & Clean first!", Duration = 3})
          return
      end

      local target = goldPartsList[tpIndex]
      if target and target:IsA("BasePart") then
          game.Players.LocalPlayer.Character:MoveTo(target.Position + Vector3.new(0, 3, 0))
          
          -- Cycle to next index
          tpIndex = tpIndex + 1
          if tpIndex > #goldPartsList then tpIndex = 1 end -- Loop back to first one
      end
   end,
})

-- WalkSpeed Slider & Toggle
local targetWalkSpeed = 16
MainTab:CreateSlider({
   Name = "Set Target Speed",
   Range = {0, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "TargetSpeedValue", 
   Callback = function(Value)
       targetWalkSpeed = Value
       if _G.SpeedEnabled and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = targetWalkSpeed
       end
   end,
})

MainTab:CreateToggle({
   Name = "Enable Custom Walkspeed",
   CurrentValue = false,
   Flag = "SpeedTick",
   Callback = function(Value)
       _G.SpeedEnabled = Value
       local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
       if hum then hum.WalkSpeed = Value and targetWalkSpeed or 16 end
   end,
})

-- Exit Button
local Exit = MainTab:CreateButton({
   Name = "Exit",
   Callback = function()
       Rayfield:Destroy()
   end,
})
