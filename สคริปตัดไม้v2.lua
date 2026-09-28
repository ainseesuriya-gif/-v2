-- Roblox Lumber Tycoon 2 - All Trees & Axes Mega Hub 🌲🪓
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LT2 - Ultimate All-in-One Mega Hub 🌲🪓",
   LoadingTitle = "กำลังโหลดระบบ LT2 Complete Edition...",
   LoadingSubtitle = "by Assistant AI",
   ConfigurationSaving = { Enabled = false }
})

-- ==================== TAB 1: ไม้ทุกชนิด (ALL TREES) ====================
local WoodTab = Window:CreateTab("ไม้ทุกชนิด (All Trees)", 4483362458)

local AllTrees = {
    -- ไม้ระดับตำนาน / หายากมาก (High Tier)
    ["🌋 Volcano Wood (ไม้ลาวา)"] = Vector3.new(-1600, 622, 1100),
    ["💎 Cave Wood (ไม้ถ้ำฟ้า)"] = Vector3.new(3500, -200, 500),
    ["✨ Gold Swirly Wood (ไม้ทอง)"] = Vector3.new(-1200, -5, -1200),
    ["🌌 End Times Wood (ไม้ Phantom/หลุมดำ)"] = Vector3.new(115, -6, -3500),
    ["❄️ Frost Wood (ไม้หิมะ)"] = Vector3.new(1450, 410, 3200),
    ["🎃 Sinister Wood (ไม้ฟักทอง)"] = Vector3.new(-1185, -5, -875),
    ["💀 Spooky Wood (ไม้หัวกะโหลก)"] = Vector3.new(-1150, -5, -1075),
    
    -- ไม้ตามสภาพแวดล้อม (Biomes)
    ["🐊 Swamp Wood (ไม้หนองน้ำ/ซอมบี้)"] = Vector3.new(-2500, -5, -1750),
    ["🌴 Palm Wood (ไม้มะพร้าวเกาะ)"] = Vector3.new(2500, 5, -2500),
    ["🍂 Koa Wood (ไม้ส้มชายหาด)"] = Vector3.new(4800, 5, -1200),
    ["🌳 Walnut Wood (ไม้วอลนัท)"] = Vector3.new(-500, 10, -1100),
    ["🟢 Cave Crawler Wood (ไม้ถ้ำเขียว)"] = Vector3.new(3500, -200, 700),
    
    -- ไม้พื้นฐาน (Standard Trees)
    ["🌲 Pine Wood (ไม้สน)"] = Vector3.new(200, 10, 100),
    ["🌸 Cherry Wood (ไม้ซากุระ/เชอร์รี่)"] = Vector3.new(300, 10, -400),
    ["⚪ Birch Wood (ไม้เบิร์ช)"] = Vector3.new(-200, 10, -300),
    ["🌳 Oak Wood (ไม้อก/ปกติ)"] = Vector3.new(100, 10, -100)
}

WoodTab:CreateSection("เลือกจุดวาร์ปไปยังต้นไม้ที่ต้องการ")

for treeName, coords in pairs(AllTrees) do
    WoodTab:CreateButton({
        Name = "วาร์ปไป: " .. treeName,
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(coords)
                Rayfield:Notify({Title = "วาร์ปสำเร็จ!", Content = "เดินทางไปจุด " .. treeName, Duration = 2.5})
            end
        end,
    })
end

-- ==================== TAB 2: ร้านค้า & ซื้อขวาน (ALL STORES) ====================
local StoreTab = Window:CreateTab("ร้านค้าทั้งหมด (Stores)", 4483362458)

local Stores = {
    ["🪓 Woodman's Store (ขวานเริ่มต้น / Steel Axe)"] = Vector3.new(265, 3, -630),
    ["🛋️ Fancy Furnishings (ขวาน Silver Axe / เฟอร์นิเจอร์)"] = Vector3.new(490, 3, -1720),
    ["🚗 Boxed Cars / Land Store (ซื้อโฉนดที่ดิน / รถ)"] = Vector3.new(510, 3, -600),
    ["🔨 Fine Supply Store (ร้านเครื่องมือ / อุปกรณ์พิเศษ)"] = Vector3.new(1475, 3, 625),
    ["🎨 Logic Store (ร้านอุปกรณ์สายไฟ / Logic)"] = Vector3.new(460, 3, -1350)
}

StoreTab:CreateSection("วาร์ปไปร้านค้าขายขวานและอุปกรณ์")

for storeName, coords in pairs(Stores) do
    StoreTab:CreateButton({
        Name = storeName,
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(coords)
                Rayfield:Notify({Title = "Teleported", Content = "วาร์ปไปที่ " .. storeName, Duration = 2.5})
            end
        end,
    })
end

-- ==================== TAB 3: ระบบช่วยตัด & ขายไม้ (FARM UTILITIES) ====================
local FarmTab = Window:CreateTab("ระบบฟาร์มไม้ (Auto Tools)", 4483362458)

-- ฟังก์ชันดึงพิกัดจุดขายไม้ (Dropoff Counter)
local function getDropoffTarget()
    if workspace:FindFirstChild("Stores") then
        for _, store in ipairs(workspace.Stores:GetChildren()) do
            if store:FindFirstChild("WoodDropoff") then
                return store.WoodDropoff
            end
        end
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "WoodDropoff" and obj:IsA("BasePart") then
            return obj
        end
    end
    return nil
end

FarmTab:CreateSection("ระบบวาร์ปท่อนไม้ไปจุดขายเงิน")

FarmTab:CreateButton({
   Name = "💰 ดึงไม้ทั้งหมดรอบตัว (ระยะ 300) เข้าแท่นขายเงิน",
   Callback = function()
        local dropoff = getDropoffTarget()
        if not dropoff then
            Rayfield:Notify({Title = "แจ้งเตือน", Content = "ไม่พบจุดขาย! ให้วาร์ปไปยืนใกล้ร้าน Woodman's Store ก่อน", Duration = 4})
            return
        end

        local count = 0
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _, item in ipairs(workspace:GetChildren()) do
                if item.Name == "TreeRegion" or item.Name == "Log" or item.Name == "Plank" or item:FindFirstChild("WoodSection") then
                    for _, part in ipairs(item:GetDescendants()) do
                        if part:IsA("BasePart") and (part.Name == "Wood" or part.Name == "Main") then
                            if (char.HumanoidRootPart.Position - part.Position).Magnitude < 300 then
                                pcall(function()
                                    part.CFrame = dropoff.CFrame + Vector3.new(0, 4, 0)
                                    count = count + 1
                                end)
                            end
                        end
                    end
                end
            end
        end
        Rayfield:Notify({Title = "ขายไม้สำเร็จ!", Content = "ส่งไม้จำนวน " .. tostring(count) .. " ชิ้น เข้าจุดขายเรียบร้อย", Duration = 3})
   end,
})

FarmTab:CreateButton({
   Name = "📍 วาร์ปตัวเราไปหน้าร้านขายไม้ (Wood Dropoff)",
   Callback = function()
       local char = game.Players.LocalPlayer.Character
       if char and char:FindFirstChild("HumanoidRootPart") then
           char.HumanoidRootPart.CFrame = CFrame.new(315, 3, -1300)
       end
   end,
})
