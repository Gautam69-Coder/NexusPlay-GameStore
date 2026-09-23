-- ===================================================================
-- NEXUSPLAY GAME STORE - ALL-IN-ONE DATABASE SETUP SCRIPT
-- Database: GameStore
-- Includes: Database Creation, Tables (DDL), Constraints & Seed Data
-- ===================================================================

-- 1. Create Database if not exists
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = N'GameStore')
BEGIN
    CREATE DATABASE [GameStore];
    PRINT 'Created database [GameStore].';
END
GO

USE [GameStore];
GO

-- 2. Create [dbo].[user]
IF OBJECT_ID(N'[dbo].[user]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[user] (
        [id]         INT IDENTITY(1,1) NOT NULL,
        [username]   NVARCHAR(50)      NOT NULL,
        [email]      NVARCHAR(100)     NOT NULL,
        [password]   NVARCHAR(100)     NOT NULL,
        [created_at] DATETIME          NULL DEFAULT (GETDATE()),
        CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED ([id] ASC),
        CONSTRAINT [UQ_user_username] UNIQUE NONCLUSTERED ([username] ASC),
        CONSTRAINT [UQ_user_email] UNIQUE NONCLUSTERED ([email] ASC)
    );
    PRINT 'Created table [dbo].[user].';
END
GO

-- 3. Create [dbo].[games]
IF OBJECT_ID(N'[dbo].[games]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[games] (
        [id]             INT IDENTITY(1,1) NOT NULL,
        [game_code]      NVARCHAR(50)      NOT NULL,
        [title]          NVARCHAR(150)     NOT NULL,
        [subtitle]       NVARCHAR(200)     NULL,
        [category]       NVARCHAR(50)      NOT NULL,
        [category_label] NVARCHAR(100)     NULL,
        [score]          NVARCHAR(10)      NULL DEFAULT ('9.0'),
        [image_url]      NVARCHAR(255)     NOT NULL,
        [buy_price]      DECIMAL(10,2)     NOT NULL,
        [original_price] DECIMAL(10,2)     NULL,
        [discount_badge] NVARCHAR(50)      NULL,
        [rent_price]     DECIMAL(10,2)     NOT NULL,
        [rent_duration]  NVARCHAR(50)      NULL DEFAULT ('7 Days'),
        [platforms]      NVARCHAR(200)     NULL DEFAULT ('PC / Steam / PS5 / Xbox'),
        [is_active]      BIT               NULL DEFAULT (1),
        [created_at]     DATETIME          NULL DEFAULT (GETDATE()),
        CONSTRAINT [PK_games] PRIMARY KEY CLUSTERED ([id] ASC),
        CONSTRAINT [UQ_games_game_code] UNIQUE NONCLUSTERED ([game_code] ASC)
    );
    PRINT 'Created table [dbo].[games].';
END
GO

-- 4. Create [dbo].[cart]
IF OBJECT_ID(N'[dbo].[cart]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[cart] (
        [id]           INT IDENTITY(1,1) NOT NULL,
        [user_id]      INT               NOT NULL,
        [game_id]      INT               NULL,
        [game_code]    NVARCHAR(50)      NOT NULL,
        [title]        NVARCHAR(150)     NOT NULL,
        [license_type] NVARCHAR(50)      NOT NULL,
        [price]        DECIMAL(10,2)     NOT NULL,
        [platform]     NVARCHAR(100)     NULL,
        [image_url]    NVARCHAR(255)     NULL,
        [quantity]     INT               NOT NULL DEFAULT (1),
        [created_at]   DATETIME          NULL DEFAULT (GETDATE()),
        CONSTRAINT [PK_cart] PRIMARY KEY CLUSTERED ([id] ASC),
        CONSTRAINT [FK_cart_user] FOREIGN KEY ([user_id]) 
            REFERENCES [dbo].[user] ([id]) ON DELETE CASCADE
    );
    PRINT 'Created table [dbo].[cart].';
END
GO

-- 5. Create [dbo].[orders]
IF OBJECT_ID(N'[dbo].[orders]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[orders] (
        [id]              INT IDENTITY(1,1) NOT NULL,
        [order_number]    NVARCHAR(50)      NOT NULL,
        [user_id]         INT               NULL,
        [customer_email]  NVARCHAR(100)     NOT NULL,
        [target_platform] NVARCHAR(100)     NOT NULL,
        [payment_method]  NVARCHAR(50)      NOT NULL,
        [subtotal]        DECIMAL(10,2)     NOT NULL,
        [discount]        DECIMAL(10,2)     NOT NULL DEFAULT (0),
        [total_amount]    DECIMAL(10,2)     NOT NULL,
        [order_status]    NVARCHAR(50)      NOT NULL DEFAULT ('Completed'),
        [created_at]      DATETIME          NULL DEFAULT (GETDATE()),
        CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED ([id] ASC),
        CONSTRAINT [UQ_orders_order_number] UNIQUE NONCLUSTERED ([order_number] ASC),
        CONSTRAINT [FK_orders_user] FOREIGN KEY ([user_id]) 
            REFERENCES [dbo].[user] ([id]) ON DELETE SET NULL
    );
    PRINT 'Created table [dbo].[orders].';
END
GO

-- 6. Create [dbo].[order_items]
IF OBJECT_ID(N'[dbo].[order_items]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[order_items] (
        [id]             INT IDENTITY(1,1) NOT NULL,
        [order_id]       INT               NOT NULL,
        [game_id]        INT               NULL,
        [game_title]     NVARCHAR(150)     NOT NULL,
        [license_type]   NVARCHAR(50)      NOT NULL,
        [price]          DECIMAL(10,2)     NOT NULL,
        [platform]       NVARCHAR(100)     NULL,
        [activation_key] NVARCHAR(100)     NOT NULL,
        [created_at]     DATETIME          NULL DEFAULT (GETDATE()),
        CONSTRAINT [PK_order_items] PRIMARY KEY CLUSTERED ([id] ASC),
        CONSTRAINT [FK_order_items_orders] FOREIGN KEY ([order_id]) 
            REFERENCES [dbo].[orders] ([id]) ON DELETE CASCADE
    );
    PRINT 'Created table [dbo].[order_items].';
END
GO

-- 7. Create [dbo].[transaction_history]
IF OBJECT_ID(N'[dbo].[transaction_history]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[transaction_history] (
        [id]             INT IDENTITY(1,1) NOT NULL,
        [transaction_id] NVARCHAR(50)      NOT NULL,
        [order_id]       INT               NOT NULL,
        [order_number]   NVARCHAR(50)      NOT NULL,
        [user_id]        INT               NOT NULL,
        [amount]         DECIMAL(10,2)     NOT NULL,
        [payment_method] NVARCHAR(50)      NOT NULL,
        [payment_status] NVARCHAR(50)      NOT NULL DEFAULT ('Success'),
        [card_last4]     NVARCHAR(10)      NULL,
        [created_at]     DATETIME          NULL DEFAULT (GETDATE()),
        CONSTRAINT [PK_transaction_history] PRIMARY KEY CLUSTERED ([id] ASC),
        CONSTRAINT [UQ_transaction_history_transaction_id] UNIQUE NONCLUSTERED ([transaction_id] ASC),
        CONSTRAINT [FK_transaction_history_orders] FOREIGN KEY ([order_id]) 
            REFERENCES [dbo].[orders] ([id]) ON DELETE CASCADE,
        CONSTRAINT [FK_transaction_history_user] FOREIGN KEY ([user_id]) 
            REFERENCES [dbo].[user] ([id])
    );
    PRINT 'Created table [dbo].[transaction_history].';
END
GO

-- 8. Seed Games Catalog
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

-- 9. Seed Default Test User
IF NOT EXISTS (SELECT 1 FROM [dbo].[user] WHERE [username] = N'gautam')
BEGIN
    INSERT INTO [dbo].[user] ([username], [email], [password], [created_at])
    VALUES (N'gautam', N'gautamdoliya69@gmail.com', N'admin123', GETDATE());
END
GO

PRINT 'Database setup and seeding completed successfully.';
