-- Авто-спавн машин для Stop the Train
if _G.AutoCarSpawnerRunning then
    print("Скрипт уже работает!")
    return
end
_G.AutoCarSpawnerRunning = true

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("🚂 Авто-спавн машин успешно запущен!")

-- Основной цикл спавна
task.spawn(function()
    while _G.AutoCarSpawnerRunning do
        pcall(function()
            for _, gui in pairs(playerGui:GetChildren()) do
                if gui:IsA("ScreenGui") then
                    for _, element in pairs(gui:GetDescendants()) do
                        if element:IsA("TextButton") or element:IsA("ImageButton") then
                            local text = ""
                            if element:IsA("TextButton") and element.Text then
                                text = element.Text:lower()
                            end
                            
                            -- Ищем кнопки по ключевым словам
                            if text:find("spawn") or text:find("спавн") or text:find("car") or text:find("машин") or text:find("купить") then
                                for _, connection in pairs(getconnections(element.MouseButton1Click)) do
                                    connection:Fire()
                                end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.5) -- Интервал между кликами (в секундах)
    end
end)

-- Защита от AFK-кика
task.spawn(function()
    while _G.AutoCarSpawnerRunning do
        task.wait(50)
        pcall(function()
            local vim = game:GetService("VirtualInputManager")
            vim:SendKeyEvent(true, Enum.KeyCode.W, false, game)
            task.wait(0.1)
            vim:SendKeyEvent(false, Enum.KeyCode.W, false, game)
        end)
    end
end)
