-- ===================================================================
-- NEXUSPLAY GAME STORE - DATABASE SEED DATA
-- Database: GameStore
-- ===================================================================

USE [GameStore];
GO

-- 1. Seed Master Games Catalog
IF NOT EXISTS (SELECT 1 FROM [dbo].[games] WHERE [game_code] = N'cyberstorm')
BEGIN
    INSERT INTO [dbo].[games] 
        ([game_code], [title], [subtitle], [category], [category_label], [score], [image_url], [buy_price], [original_price], [discount_badge], [rent_price], [rent_duration], [platforms], [is_active])
    VALUES 
        (N'cyberstorm', N'Cyberstorm: Neon War', N'Single & Co-op Campaign', N'action', N'CYBERPUNK', N'9.8', N'images/cover-cyberstorm.jpg', 44.99, 59.99, N'-25%', 4.99, N'7 Days', N'PC / Steam / PS5 / Xbox', 1);
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[games] WHERE [game_code] = N'elder-realms')
BEGIN
    INSERT INTO [dbo].[games] 
        ([game_code], [title], [subtitle], [category], [category_label], [score], [image_url], [buy_price], [original_price], [discount_badge], [rent_price], [rent_duration], [platforms], [is_active])
    VALUES 
        (N'elder-realms', N'Elder Realms: Legacy', N'Dark Fantasy Epic', N'fantasy', N'OPEN WORLD RPG', N'9.9', N'images/cover-elder-realms.jpg', 54.99, 69.99, N'-21%', 5.99, N'7 Days', N'PC / Steam / Xbox Series X', 1);
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[games] WHERE [game_code] = N'valkyrie')
BEGIN
    INSERT INTO [dbo].[games] 
        ([game_code], [title], [subtitle], [category], [category_label], [score], [image_url], [buy_price], [original_price], [discount_badge], [rent_price], [rent_duration], [platforms], [is_active])
    VALUES 
        (N'valkyrie', N'Valkyrie Protocol', N'Tactical Mech Warfare', N'mech', N'MECH WARFARE', N'9.5', N'images/cover-valkyrie.jpg', 39.99, 49.99, N'-20%', 3.99, N'7 Days', N'PC / Epic / PS5', 1);
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[games] WHERE [game_code] = N'apex')
BEGIN
    INSERT INTO [dbo].[games] 
        ([game_code], [title], [subtitle], [category], [category_label], [score], [image_url], [buy_price], [original_price], [discount_badge], [rent_price], [rent_duration], [platforms], [is_active])
    VALUES 
        (N'apex', N'Apex Horizon: Neon Drift', N'Cross-Play Arcade Racing', N'racing', N'SUPERSONIC RACING', N'9.7', N'images/cover-apex.jpg', 29.99, NULL, NULL, 2.99, N'7 Days', N'PC / Steam / Switch / PS5', 1);
END
GO

-- 2. Seed Default Test User (Optional)
IF NOT EXISTS (SELECT 1 FROM [dbo].[user] WHERE [username] = N'gautam')
BEGIN
    INSERT INTO [dbo].[user] ([username], [email], [password], [created_at])
    VALUES (N'gautam', N'gautamdoliya69@gmail.com', N'admin123', GETDATE());
END
GO
