--[[
        Animations
--]]

--
-- Curves
--

hl.curve(
        "almostLinear",
        { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } }
)

hl.curve(
        "quick",
        { type = "bezier", points = { {0.15, 0.0}, {0.1, 1.0} } }
)

hl.curve(
        "wait",
        { type = "bezier", points = { {0.87, 0.57}, {0.55, 0.26} } }
)

hl.curve(
        "slow",
        { type = "bezier", points = { {0.97, 0.74}, {0.63, 1.0} } }
)

hl.curve(
        "ease",
        { type = "bezier", points = { {0.3, 0.28}, {0.32, 1.03} } }
)


--
-- Applying
--

hl.animation({
        leaf    = "global",
        enabled = true,
        speed   = 10,
        bezier  = "default"
})

hl.animation({
        leaf    = "workspaces",
        enabled = true,
        speed   = 4,
        bezier  = "slow",
        style   = "slidefadevert 50"
})

hl.animation({
        leaf    = "windows",
        enabled = true,
        speed   = 4,
        bezier  = "slow"
})

hl.animation({
        leaf    = "windowsIn",
        enabled = true,
        speed   = 4,
        bezier  = "ease",
        style   = "slide"
})

hl.animation({
        leaf    = "windowsOut",
        enabled = true,
        speed   = 4,
        bezier  = "ease",
        style   = "slide"
})


hl.animation({
        leaf    = "border",
        enabled = true,
        speed   = 3,
        bezier  = "default"
})


hl.animation({
        leaf    = "fade",
        enabled = true,
        speed   = 6,
        bezier  = "almostLinear"
})


hl.animation({
        leaf    = "layers",
        enabled = true,
        speed   = 4,
        bezier  = "slow",
        style   = "slide bottom"
})
