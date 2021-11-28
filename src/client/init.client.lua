local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
--local player

local graphClass = ReplicatedStorage:WaitForChild("Common").graphClass
local SkillTree = ReplicatedStorage:WaitForChild("SkillTree")

local SkillTreeGUI = SkillTree.SkillTreeGUI:Clone()

local function renderGUI(Viewport) --- given a viewport, get GUI objects that overlap  

end

local function onCharacterAdded()
    SkillTreeGUI.Parent = player:WaitForChild("PlayerGui")
    ---SkillTreeGUI.AbsolutePosition = Vector2.new(100,0)
end

player.CharacterAdded:Connect(onCharacterAdded)

