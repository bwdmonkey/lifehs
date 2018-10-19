module Constants (width, height, presetSeeds) where

-- Default width and height
width, height :: Integer
(width, height) = (25, 25)

-- Preset seeds
presetSeeds :: [String]
presetSeeds = ["BeaconSeed", "BlinkerSeed", "DieHardSeed", "GliderSeed", "LWSSSeed", "RandomSeed", "ToadSeed"]
