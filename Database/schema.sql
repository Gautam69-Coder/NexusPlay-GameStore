-- ===================================================================
-- NEXUSPLAY GAME STORE - DATABASE SCHEMA DDL
-- Database: GameStore
-- SQL Server 2016+ / 2019 / 2022 / Azure SQL
-- ===================================================================

-- Create database if it does not already exist
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = N'GameStore')
BEGIN
    CREATE DATABASE [GameStore];
END
GO

USE [GameStore];
GO

-- ===================================================================
-- 1. Table: [dbo].[user]
-- Stores registered gamer accounts and authentication credentials
-- ===================================================================
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
END
GO

-- ===================================================================
-- 2. Table: [dbo].[games]
-- Stores the master digital games catalog, buy & rental pricing
-- ===================================================================
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
END
GO

-- ===================================================================
-- 3. Table: [dbo].[cart]
-- Stores user active shopping cart items with license type & platform
-- ===================================================================
IF OBJECT_ID(N'[dbo].[cart]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[cart] (
        [id]           INT IDENTITY(1,1) NOT NULL,
        [user_id]      INT               NOT NULL,
        [game_id]      INT               NULL,
        [game_code]    NVARCHAR(50)      NOT NULL,
        [title]        NVARCHAR(150)     NOT NULL,
        [license_type] NVARCHAR(50)      NOT NULL, -- 'buy' or 'rent'
        [price]        DECIMAL(10,2)     NOT NULL,
        [platform]     NVARCHAR(100)     NULL,
        [image_url]    NVARCHAR(255)     NULL,
        [quantity]     INT               NOT NULL DEFAULT (1),
        [created_at]   DATETIME          NULL DEFAULT (GETDATE()),
        CONSTRAINT [PK_cart] PRIMARY KEY CLUSTERED ([id] ASC),
        CONSTRAINT [FK_cart_user] FOREIGN KEY ([user_id]) 
            REFERENCES [dbo].[user] ([id]) ON DELETE CASCADE
    );
END
GO

-- ===================================================================
-- 4. Table: [dbo].[orders]
-- Stores customer checkout purchase orders
-- ===================================================================
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
END
GO

-- ===================================================================
-- 5. Table: [dbo].[order_items]
-- Stores order line items and unique generated digital DRM keys
-- ===================================================================
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
END
GO

-- ===================================================================
-- 6. Table: [dbo].[transaction_history]
-- Stores financial transaction audit records and digital receipts
-- ===================================================================
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
END
GO
