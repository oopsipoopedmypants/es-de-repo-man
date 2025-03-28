# es-de-repo-man
# ES-DE Game Manager

A system for managing games between NAS storage and local drives for EmulationStation Desktop Edition (ES-DE).

## Project Overview

This project aims to create a robust game management system that allows games stored on a NAS to be seamlessly played on a local gaming PC while minimizing read/write operations on the NAS hardware. The system integrates with EmulationStation Desktop Edition (ES-DE) to provide a unified interface for all game types.

### Key Features

- Automatic copying of games from NAS to local storage when selected for play
- Intelligent storage management across multiple local drives (configurable based on speed and capacity)
- Support for multiple game formats and systems:
  - DOS games (DOSBox)
  - GOG installers
  - ISO-based installers
  - Steam-integrated games
  - RetroArch emulated games
  - RPCS3 (PS3) games
  - Ryujinx (Switch) games
- ES-DE integration with custom systems and launch commands
- Game installation tracking database
- Automated cleanup of infrequently played games

## Development Roadmap

### Phase 1: Foundation & Architecture
- Set up project repository structure and documentation
- Create database schema for tracking installed games
- Design core game manager architecture and API
- Implement configuration system for paths and preferences
- Create logging system for debugging and tracking

### Phase 2: Game Type Handlers
- Implement DOS games handler for direct launch via DOSBox
- Create GOG installer handler for .exe installers
- Develop ISO installer handler with mounting capabilities
- Build RetroArch games launcher
- Implement RPCS3 (PS3) game handler
- Create Ryujinx (Switch) game handler
- Build Steam integration for Steam-installed games

### Phase 3: Storage Management
- Implement NAS to local copying mechanism
- Create storage allocation logic (prioritizing games across different drive types based on performance needs)
- Develop cleanup routine for removing unused games
- Build storage monitoring to prevent drive overflow
- Create installation status tracking system

### Phase 4: ES-DE Integration
- Configure custom systems in ES-DE
- Set up alternative emulators in ES-DE configuration
- Create custom launch commands for each game type
- Implement ES-DE metadata generation
- Configure scrapers for game information and media

### Phase 5: User Experience
- Design unified game launching interface
- Implement installation progress tracking
- Create game categorization system
- Build simple statistics system (play time, frequency)
- Develop user preferences configuration

### Phase 6: Testing & Refinement
- Create test cases for each game type
- Build automated testing framework
- Implement error handling and recovery
- Optimize copying performance from NAS
- Refine launch scripts based on testing

### Phase 7: Documentation & Deployment
- Create user guide documentation
- Write technical implementation details
- Develop quick start guide
- Create backup and restore procedures
- Build deployment script for easy setup

## Project Structure

```
es-de-game-manager/
├── README.md                  # Project overview, setup instructions
├── docs/                      # Documentation
│   ├── architecture.md        # Overall system design
│   ├── es-de-integration.md   # How to integrate with ES-DE
│   └── game-types.md          # Definitions of game types and handling
├── scripts/                   # Main scripts
│   ├── game_manager.py        # Core script handling all game types
│   ├── dosbox_handler.py      # DOS games specific handling
│   ├── gog_handler.py         # GOG games handling
│   ├── iso_handler.py         # ISO installer handling
│   ├── steam_handler.py       # Steam games integration
│   └── emulator_handlers/     # Emulator-specific scripts
│       ├── retroarch.py
│       ├── rpcs3.py
│       └── ryujinx.py
├── db/                        # Database related code
│   ├── schema.sql             # Database schema if using SQL
│   └── db_manager.py          # Database operations
├── config/                    # Configuration files
│   ├── default_config.json    # Default configuration
│   └── paths.json             # Path configurations
├── tests/                     # Test scripts
│   ├── test_game_manager.py
│   └── test_handlers.py
└── es-de-configs/             # ES-DE configuration templates
    ├── custom_systems.xml     # Custom system definitions
    └── alternative_emulators.xml  # Alternative emulator configs
```

## Getting Started

*Coming soon*

## Contributing

This is a private project. Please contact the repository owner for contribution access.

## License

*License information coming soon*
