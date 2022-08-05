# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2022-08-06

### Added

- Add `Multi` item with a probability of 10%. [#12](https://github.com/EmilienLeroy/FallingSquare/issues/12)
- Add `Multiply` item with a probability of 5%. [#11](https://github.com/EmilienLeroy/FallingSquare/issues/11)
- Add `Reset` item with a probability of 2% and when you have under two lifes. [#10](https://github.com/EmilienLeroy/FallingSquare/issues/10)
- Add combo system. [#6](https://github.com/EmilienLeroy/FallingSquare/issues/6)

### Changed

- Update probability of `Square` item to 68%.
- Update probability of `Bomb` item to 10%.
- Update probability of `Restore` item to 5%.

### Fixed

- Randomize seed of the game on each application start. 

## [0.1.1] - 2022-07-30

### Fixed

- Prevent user to spam a square to increase the score faster. [#5](https://github.com/EmilienLeroy/FallingSquare/issues/5)
- Prevent heart and bomb to increase score. [#4](https://github.com/EmilienLeroy/FallingSquare/issues/4)

## [0.1.0] - 2022-07-29

### Added

- Add android build.
- Add `home`, `game`, `result` and `about` view
- Add three items: 
    - `square`
    - `heart` 
    - `bomb`

[0.2.0]: https://github.com/EmilienLeroy/FallingSquare/compare/v0.1.0...v0.2.0
[0.1.1]: https://github.com/EmilienLeroy/FallingSquare/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/EmilienLeroy/FallingSquare/releases/tag/v0.1.0