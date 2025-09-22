# Changelog

All notable changes to this project will be documented in this file.

## [1.0.2] - 2025-01-15

### Added
- Professional website at https://content-flagging.netlify.app
- Interactive demo and comprehensive documentation
- Dark mode support for website
- Modern green/teal color scheme

### Updated
- Homepage URL to point to live website
- Documentation links to interactive site
- README with proper links to website and RubyGems

## [1.0.1] - 2025-09-20

### Fixed
- Updated repository URLs to correct GitHub location

## [1.0.0] - 2025-09-20

### Added
- Initial release of ContentFlagging gem
- `acts_as_flaggable` method for Rails models
- Configurable flag thresholds
- Automatic scope filtering
- Polymorphic flagging system
- Thread-safe counter management
- Support for PostgreSQL, MySQL, SQLite
- Rails generator for easy installation
- Comprehensive test suite
- Admin-friendly scopes and methods

### Features
- Flag content with `flag!(flagged_by: user)`
- Unflag content with `unflag!(flagged_by: user)`
- Check flagging status with `flagged?` and `flag_count`
- Track when content was first flagged with `flagged_at`
- Scopes: `flagged`, `not_flagged`, `with_flagged`
- Configurable thresholds per model or globally