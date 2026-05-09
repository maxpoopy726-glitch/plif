local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🪽FunScripts🪽",
   Icon = 0, 
   LoadingTitle = "🪽FunScripts🪽",
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
local tpIndex = 1 -- Keep this OUTSIDE the callback to remember your place

local TPButton = MainTab:CreateButton({
   Name = "TP to Next Gold",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character
      local root = character and character:FindFirstChild("HumanoidRootPart")
      
      if not root then return end

      -- 1. Get a fresh list of all current gold parts
      local goldParts = {}
      for _, v in workspace:GetDescendants() do
         -- Checking for the part named "Part" inside a parent named "Gold"
         if v:IsA("BasePart") and v.Name == "Part" and v.Parent and v.Parent.Name == "Gold" then
            table.insert(goldParts, v)
         end
      end

      -- 2. Check if any gold even exists
      if #goldParts == 0 then
         Rayfield:Notify({Title = "Error", Content = "No Gold parts found in workspace!", Duration = 3})
         return
      end

      -- 3. Reset index if it's out of bounds (e.g., gold was collected)
      if tpIndex > #goldParts then
         tpIndex = 1
      end

      -- 4. Teleport to the specific index
      local target = goldParts[tpIndex]
      if target then
         -- Use CFrame + Vector3 to stand 3 studs above the part
         root.CFrame = target.CFrame + Vector3.new(0, 3, 0)
         
         Rayfield:Notify({
            Title = "Teleported",
            Content = "Target: " .. tpIndex .. " / " .. #goldParts,
            Duration = 1.5
         })

         -- 5. Prepare for the next click
         tpIndex = tpIndex + 1
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
