-- ES-DE Game Manager Database Schema
-- This schema defines the structure for tracking games, their installation status,
-- and related metadata to efficiently manage games between NAS and local storage.

-- =========================================================
-- GAMES TABLE
-- Stores basic information about each game
-- =========================================================
CREATE TABLE IF NOT EXISTS games (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,                     -- Game name
    game_type TEXT NOT NULL,                -- Type of game (dos, gog, iso, etc.)
    nas_path TEXT NOT NULL,                 -- Original path on NAS
    local_path TEXT,                        -- Path on local system (if installed)
    storage_tier TEXT,                      -- Which storage tier it's installed on
    size_bytes INTEGER,                     -- Size of the game in bytes
    is_installed BOOLEAN DEFAULT 0,         -- Whether game is installed locally
    install_date DATETIME,                  -- When the game was installed
    last_played DATETIME,                   -- When the game was last played
    play_count INTEGER DEFAULT 0,           -- Number of times played
    requires_installation BOOLEAN DEFAULT 0, -- Whether game requires installation process
    install_args TEXT,                      -- Special arguments for installation
    launch_args TEXT,                       -- Special arguments for launching
    metadata_id INTEGER,                    -- Link to metadata table
    UNIQUE(name, game_type)
);

-- =========================================================
-- METADATA TABLE
-- Stores additional information about games (for ES-DE integration)
-- =========================================================
CREATE TABLE IF NOT EXISTS metadata (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT,                       -- Game description
    developer TEXT,                         -- Game developer
    publisher TEXT,                         -- Game publisher
    genre TEXT,                             -- Game genre
    release_date TEXT,                      -- Release date (YYYY-MM-DD)
    players INTEGER,                        -- Number of players supported
    rating FLOAT,                           -- Game rating (0.0-1.0)
    favorite BOOLEAN DEFAULT 0,             -- Whether game is marked as favorite
    play_time_minutes INTEGER DEFAULT 0,    -- Total play time
    image_path TEXT,                        -- Path to game image/boxart
    video_path TEXT,                        -- Path to game video/preview
    marquee_path TEXT                       -- Path to game marquee/logo
);

-- =========================================================
-- INSTALLATION_QUEUE TABLE
-- Manages queue of games to be installed/copied
-- =========================================================
CREATE TABLE IF NOT EXISTS installation_queue (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,               -- Reference to games table
    queue_date DATETIME NOT NULL,           -- When it was added to queue
    priority INTEGER DEFAULT 5,             -- Priority (1-10, 1 highest)
    status TEXT DEFAULT 'pending',          -- Status (pending, in_progress, complete, failed)
    error_message TEXT,                     -- Error message if install failed
    FOREIGN KEY (game_id) REFERENCES games(id)
);

-- =========================================================
-- EXECUTION_HISTORY TABLE
-- Tracks game execution history
-- =========================================================
CREATE TABLE IF NOT EXISTS execution_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,               -- Reference to games table
    start_time DATETIME NOT NULL,           -- When game was launched
    end_time DATETIME,                      -- When game was closed
    exit_code INTEGER,                      -- Process exit code
    notes TEXT,                             -- Any notes about this session
    FOREIGN KEY (game_id) REFERENCES games(id)
);

-- =========================================================
-- CLEANUP_EXEMPTIONS TABLE
-- Tracks games that should not be removed during cleanup
-- =========================================================
CREATE TABLE IF NOT EXISTS cleanup_exemptions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,               -- Reference to games table
    reason TEXT,                            -- Reason for exemption
    expiry_date DATETIME,                   -- When exemption expires (NULL = never)
    FOREIGN KEY (game_id) REFERENCES games(id),
    UNIQUE(game_id)
);

-- =========================================================
-- ES_DE_INTEGRATION TABLE
-- Tracks ES-DE specific data
-- =========================================================
CREATE TABLE IF NOT EXISTS es_de_integration (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,               -- Reference to games table
    es_de_system TEXT NOT NULL,             -- ES-DE system name
    es_de_path TEXT,                        -- Path within ES-DE system
    custom_command TEXT,                    -- Custom launch command (if any)
    rom_extension TEXT,                     -- File extension for ROM
    FOREIGN KEY (game_id) REFERENCES games(id),
    UNIQUE(game_id)
);

-- =========================================================
-- INDEXES
-- Improves query performance
-- =========================================================
CREATE INDEX IF NOT EXISTS idx_game_type ON games(game_type);
CREATE INDEX IF NOT EXISTS idx_is_installed ON games(is_installed);
CREATE INDEX IF NOT EXISTS idx_last_played ON games(last_played);
CREATE INDEX IF NOT EXISTS idx_storage_tier ON games(storage_tier);
CREATE INDEX IF NOT EXISTS idx_execution_game_id ON execution_history(game_id);
CREATE INDEX IF NOT EXISTS idx_queue_status ON installation_queue(status);
