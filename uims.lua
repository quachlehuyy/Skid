local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local httpService = game:GetService("HttpService")

local RenderStepped = RunService.RenderStepped

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

local Themes = {
	Names = {
		"Midnight Blue",
		"Obsidian White",
		"Crimson Dark",
		"Ember",
		"Neon Crimson",		
		"Neon Orange",
		"Dark Typewriter",
		"VSC Dark High Contrast",
		"Dark",
		"Darker",
		"Light",
		"Aqua",
		"Amethyst",
		"Amethyst Dark",
		"BloodRed",
		"AmberGlow",
		"NeonCyber",
		"DeepOcean",
		"Orange",
		"CottonCandy",
		"BlackGlass",
		"RoyalGold",
		"Emerald"
	},
	["VSC Dark High Contrast"] = {
		Accent = Color3.fromHex("#569cd6"), -- Based on keyword color

		AcrylicMain = Color3.fromHex("#000000"), -- editor.background
		AcrylicBorder = Color3.fromHex("#FFFFFF"), -- Based on editor.foreground
		AcrylicGradient = ColorSequence.new(Color3.fromHex("#000000"), Color3.fromHex("#000000")),
		AcrylicNoise = 1,

		TitleBarLine = Color3.fromHex("#FFFFFF"),
		Tab = Color3.fromHex("#FFFFFF"),

		Element = Color3.fromHex("#000000"),
		ElementBorder = Color3.fromHex("#FFFFFF"),
		InElementBorder = Color3.fromHex("#569cd6"),
		ElementTransparency = 0,

		ToggleSlider = Color3.fromHex("#569cd6"),
		ToggleToggled = Color3.fromHex("#000000"),

		SliderRail = Color3.fromHex("#569cd6"),

		DropdownFrame = Color3.fromHex("#000000"),
		DropdownHolder = Color3.fromHex("#000000"),
		DropdownBorder = Color3.fromHex("#FFFFFF"),
		DropdownOption = Color3.fromHex("#FFFFFF"),

		Keybind = Color3.fromHex("#000000"),

		Input = Color3.fromHex("#000000"),
		InputFocused = Color3.fromHex("#000000"),
		InputIndicator = Color3.fromHex("#7c7c7c"), -- Based on editorWhitespace.foreground

		Dialog = Color3.fromHex("#000000"),
		DialogHolder = Color3.fromHex("#000000"),
		DialogHolderLine = Color3.fromHex("#FFFFFF"),
		DialogButton = Color3.fromHex("#000000"),
		DialogButtonBorder = Color3.fromHex("#FFFFFF"),
		DialogBorder = Color3.fromHex("#FFFFFF"),
		DialogInput = Color3.fromHex("#000000"),
		DialogInputLine = Color3.fromHex("#569cd6"),

		Text = Color3.fromHex("#FFFFFF"), -- editor.foreground
		SubText = Color3.fromHex("#9D9D9D"), -- descriptionForeground
		Hover = Color3.fromHex("#383a49"), -- Based on actionBar.toggledBackground
		HoverChange = 0.1
	},
	["Dark Typewriter"] = {
		Accent = Color3.fromRGB(109, 180, 120),

		AcrylicMain = Color3.fromRGB(38, 38, 38),
		AcrylicBorder = Color3.fromRGB(85, 85, 85),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(38, 38, 38), Color3.fromRGB(38, 38, 38)),
		AcrylicNoise = 1,

		TitleBarLine = Color3.fromRGB(189, 189, 189),
		Tab = Color3.fromRGB(109, 180, 120),

		Element = Color3.fromRGB(42, 42, 42),
		ElementBorder = Color3.fromRGB(51, 51, 51),
		InElementBorder = Color3.fromRGB(51, 51, 51),
		ElementTransparency = 0,

		ToggleSlider = Color3.fromRGB(103, 169, 113),
		ToggleToggled = Color3.fromRGB(255, 255, 255),

		SliderRail = Color3.fromRGB(51, 51, 51),

		DropdownFrame = Color3.fromRGB(38, 38, 46),
		DropdownHolder = Color3.fromRGB(32, 32, 40),
		DropdownBorder = Color3.fromRGB(70, 70, 85),
		DropdownOption = Color3.fromRGB(153, 200, 255),

		Keybind = Color3.fromRGB(54, 54, 54),

		Input = Color3.fromRGB(27, 27, 27),
		InputFocused = Color3.fromRGB(51, 51, 51),
		InputIndicator = Color3.fromRGB(197, 184, 161),

		Dialog = Color3.fromRGB(38, 38, 38),
		DialogHolder = Color3.fromRGB(58, 52, 46),
		DialogHolderLine = Color3.fromRGB(40, 40, 40),
		DialogButton = Color3.fromRGB(42, 42, 42),
		DialogButtonBorder = Color3.fromRGB(51, 51, 51),
		DialogBorder = Color3.fromRGB(189, 189, 189),
		DialogInput = Color3.fromRGB(27, 27, 27),
		DialogInputLine = Color3.fromRGB(197, 184, 161),

		Text = Color3.fromRGB(197, 184, 161),
		SubText = Color3.fromRGB(158, 158, 158),
		Hover = Color3.fromRGB(149, 149, 149),
		HoverChange = 0.04
	},
	["Midnight Blue"] = {
	    Name = "Midnight Blue",
	    Accent = Color3.fromRGB(100, 180, 220),
	
		AcrylicMain = Color3.fromRGB(18, 18, 22),
	    AcrylicBorder = Color3.fromRGB(45, 45, 52),
	    AcrylicGradient = ColorSequence.new(Color3.fromRGB(22, 22, 26), Color3.fromRGB(22, 22, 26)),
	    AcrylicNoise = 0.94,
	
	    TitleBarLine = Color3.fromRGB(45, 45, 52),
	    Tab = Color3.fromRGB(130, 130, 140),
	
		Element = Color3.fromRGB(38, 38, 46),
		ElementBorder = Color3.fromRGB(55, 55, 65),
		InElementBorder = Color3.fromRGB(75, 75, 88),
		ElementTransparency = 0.1,
	
	    ToggleSlider = Color3.fromRGB(100, 180, 220),
	    ToggleToggled = Color3.fromRGB(22, 22, 26),
	
	    SliderRail = Color3.fromRGB(55, 55, 65),
	
	    DropdownFrame = Color3.fromRGB(32, 32, 38),
	    DropdownHolder = Color3.fromRGB(28, 28, 34),
	    DropdownBorder = Color3.fromRGB(45, 45, 52),
	    DropdownOption = Color3.fromRGB(150, 150, 160),
	
	    Keybind = Color3.fromRGB(32, 32, 38),
	
	    Input = Color3.fromRGB(26, 26, 32),
	    InputFocused = Color3.fromRGB(32, 32, 40),
	    InputIndicator = Color3.fromRGB(100, 180, 220),
	    InputIndicatorFocus = Color3.fromRGB(100, 180, 220),
	
	    Dialog = Color3.fromRGB(32, 32, 38),
	    DialogHolder = Color3.fromRGB(26, 26, 32),
	    DialogHolderLine = Color3.fromRGB(45, 45, 52),
	    DialogButton = Color3.fromRGB(32, 32, 38),
	    DialogButtonBorder = Color3.fromRGB(45, 45, 52),
	    DialogBorder = Color3.fromRGB(45, 45, 52),
	    DialogInput = Color3.fromRGB(26, 26, 32),
	    DialogInputLine = Color3.fromRGB(100, 180, 220),
	
	    Text = Color3.fromRGB(195, 195, 205),
	    SubText = Color3.fromRGB(125, 125, 135),
	    Hover = Color3.fromRGB(45, 45, 55),
	    HoverChange = 0.04,
	},
	["Obsidian White"] = {
		Name = "Obsidian White",
		Accent = Color3.fromHex("#ffffff"),
	
		AcrylicMain = Color3.fromHex("#000000"),
		AcrylicBorder = Color3.fromHex("#ffffff"),
		AcrylicGradient = ColorSequence.new(Color3.fromHex("#000000"), Color3.fromHex("#000000")),
		AcrylicNoise = 0.92,
	
		TitleBarLine = Color3.fromHex("#ffffff"),
		Tab = Color3.fromHex("#ffffff"),
	
		Element = Color3.fromHex("#0d0d0d"),
		ElementBorder = Color3.fromHex("#ffffff"),
		InElementBorder = Color3.fromHex("#ffffff"),
		ElementTransparency = 0.85,
	
		ToggleSlider = Color3.fromHex("#ffffff"),
		ToggleToggled = Color3.fromHex("#000000"),
	
		SliderRail = Color3.fromHex("#ffffff"),
	
		DropdownFrame = Color3.fromHex("#0d0d0d"),
		DropdownHolder = Color3.fromHex("#0d0d0d"),
		DropdownBorder = Color3.fromHex("#ffffff"),
		DropdownOption = Color3.fromHex("#ffffff"),
	
		Keybind = Color3.fromHex("#0d0d0d"),
	
		Input = Color3.fromHex("#050505"),
		InputFocused = Color3.fromHex("#050505"),
		InputIndicator = Color3.fromHex("#ffffff"),
	
		Dialog = Color3.fromHex("#0d0d0d"),
		DialogHolder = Color3.fromHex("#000000"),
		DialogHolderLine = Color3.fromHex("#ffffff"),
		DialogButton = Color3.fromHex("#0d0d0d"),
		DialogButtonBorder = Color3.fromHex("#ffffff"),
		DialogBorder = Color3.fromHex("#ffffff"),
		DialogInput = Color3.fromHex("#050505"),
		DialogInputLine = Color3.fromHex("#ffffff"),
	
		Text = Color3.fromHex("#ffffff"),
		SubText = Color3.fromHex("#bfbfbf"),
		Hover = Color3.fromHex("#1a1a1a"),
		HoverChange = 0.1
	},
	["Amethyst Dark"] = {
		Name = "Amethyst Dark",
		Accent = Color3.fromHex("#b133ff"),

		AcrylicMain = Color3.fromHex("#120024"),
		AcrylicBorder = Color3.fromHex("#4d057b"),
		AcrylicGradient = ColorSequence.new(Color3.fromHex("#120024"), Color3.fromHex("#120024")),
		AcrylicNoise = 0.92,

		TitleBarLine = Color3.fromHex("#4d057b"),
		Tab = Color3.fromHex("#e9d9f2"),

		Element = Color3.fromHex("#25013c"),
		ElementBorder = Color3.fromHex("#4d057b"),
		InElementBorder = Color3.fromHex("#b133ff"),
		ElementTransparency = 0.85,

		ToggleSlider = Color3.fromHex("#7d16bf"),
		ToggleToggled = Color3.fromHex("#120024"),

		SliderRail = Color3.fromHex("#7d16bf"),

		DropdownFrame = Color3.fromHex("#25013c"),
		DropdownHolder = Color3.fromHex("#25013c"),
		DropdownBorder = Color3.fromHex("#4d057b"),
		DropdownOption = Color3.fromHex("#e9d9f2"),

		Keybind = Color3.fromHex("#25013c"),

		Input = Color3.fromHex("#180030"),
		InputFocused = Color3.fromHex("#180030"),
		InputIndicator = Color3.fromHex("#9e85ad"),

		Dialog = Color3.fromHex("#25013c"),
		DialogHolder = Color3.fromHex("#120024"),
		DialogHolderLine = Color3.fromHex("#4d057b"),
		DialogButton = Color3.fromHex("#25013c"),
		DialogButtonBorder = Color3.fromHex("#4d057b"),
		DialogBorder = Color3.fromHex("#4d057b"),
		DialogInput = Color3.fromHex("#180030"),
		DialogInputLine = Color3.fromHex("#b133ff"),

		Text = Color3.fromHex("#e9d9f2"),
		SubText = Color3.fromHex("#9e85ad"),
		Hover = Color3.fromHex("#4d057b"),
		HoverChange = 0.1
	},
	["Crimson Dark"] = {
		Name = "Crimson Dark",
		Accent = Color3.fromHex("#ff3333"), -- Bright Crimson Red

		AcrylicMain = Color3.fromHex("#240000"), -- Deep Maroon
		AcrylicBorder = Color3.fromHex("#7b0505"), -- Dark Red
		AcrylicGradient = ColorSequence.new(Color3.fromHex("#240000"), Color3.fromHex("#240000")),
		AcrylicNoise = 0.92,

		TitleBarLine = Color3.fromHex("#7b0505"), -- Dark Red
		Tab = Color3.fromHex("#f2d9d9"), -- Soft Pinkish White

		Element = Color3.fromHex("#3c0101"), -- Deep Red
		ElementBorder = Color3.fromHex("#7b0505"), -- Dark Red
		InElementBorder = Color3.fromHex("#ff3333"), -- Bright Crimson
		ElementTransparency = 0.85,

		ToggleSlider = Color3.fromHex("#bf1616"), -- Rich Red
		ToggleToggled = Color3.fromHex("#240000"), -- Deep Maroon

		SliderRail = Color3.fromHex("#bf1616"), -- Rich Red

		DropdownFrame = Color3.fromHex("#3c0101"), -- Deep Red
		DropdownHolder = Color3.fromHex("#3c0101"), -- Deep Red
		DropdownBorder = Color3.fromHex("#7b0505"), -- Dark Red
		DropdownOption = Color3.fromHex("#f2d9d9"), -- Soft Pinkish White

		Keybind = Color3.fromHex("#3c0101"), -- Deep Red

		Input = Color3.fromHex("#300000"), -- Dark Maroon
		InputFocused = Color3.fromHex("#300000"), -- Dark Maroon
		InputIndicator = Color3.fromHex("#ad8585"), -- Muted Red

		Dialog = Color3.fromHex("#3c0101"), -- Deep Red
		DialogHolder = Color3.fromHex("#240000"), -- Deep Maroon
		DialogHolderLine = Color3.fromHex("#7b0505"), -- Dark Red
		DialogButton = Color3.fromHex("#3c0101"), -- Deep Red
		DialogButtonBorder = Color3.fromHex("#7b0505"), -- Dark Red
		DialogBorder = Color3.fromHex("#7b0505"), -- Dark Red
		DialogInput = Color3.fromHex("#300000"), -- Dark Maroon
		DialogInputLine = Color3.fromHex("#ff3333"), -- Bright Crimson

		Text = Color3.fromHex("#f2d9d9"), -- Soft Pinkish White
		SubText = Color3.fromHex("#ad8585"), -- Muted Red
		Hover = Color3.fromHex("#7b0505"), -- Dark Red
		HoverChange = 0.1
	},
	["Neon Crimson"] = {
		Name = "Neon Crimson",
		Accent = Color3.fromHex("#ff0055"), -- Neon Red-Pink

		AcrylicMain = Color3.fromHex("#0a0005"), -- Deep Black-Red
		AcrylicBorder = Color3.fromHex("#910027"), -- Intense Deep Red
		AcrylicGradient = ColorSequence.new(Color3.fromHex("#0a0005"), Color3.fromHex("#0a0005")),
		AcrylicNoise = 0.92,

		TitleBarLine = Color3.fromHex("#910027"), -- Deep Red Border
		Tab = Color3.fromHex("#ffccd9"), -- Soft Neon Pink

		Element = Color3.fromHex("#220007"), -- Dark Red-Black
		ElementBorder = Color3.fromHex("#910027"), -- Intense Deep Red
		InElementBorder = Color3.fromHex("#ff0055"), -- Neon Red-Pink
		ElementTransparency = 0.85,

		ToggleSlider = Color3.fromHex("#d40040"), -- Bright Crimson
		ToggleToggled = Color3.fromHex("#0a0005"), -- Deep Black-Red

		SliderRail = Color3.fromHex("#d40040"), -- Bright Crimson

		DropdownFrame = Color3.fromHex("#220007"), -- Dark Red-Black
		DropdownHolder = Color3.fromHex("#220007"), -- Dark Red-Black
		DropdownBorder = Color3.fromHex("#910027"), -- Intense Deep Red
		DropdownOption = Color3.fromHex("#ffccd9"), -- Soft Neon Pink

		Keybind = Color3.fromHex("#220007"), -- Dark Red-Black

		Input = Color3.fromHex("#140005"), -- Deep Black-Red
		InputFocused = Color3.fromHex("#140005"), -- Deep Black-Red
		InputIndicator = Color3.fromHex("#ff8099"), -- Soft Neon Red

		Dialog = Color3.fromHex("#220007"), -- Dark Red-Black
		DialogHolder = Color3.fromHex("#0a0005"), -- Deep Black-Red
		DialogHolderLine = Color3.fromHex("#910027"), -- Intense Deep Red
		DialogButton = Color3.fromHex("#220007"), -- Dark Red-Black
		DialogButtonBorder = Color3.fromHex("#910027"), -- Intense Deep Red
		DialogBorder = Color3.fromHex("#910027"), -- Intense Deep Red
		DialogInput = Color3.fromHex("#140005"), -- Deep Black-Red
		DialogInputLine = Color3.fromHex("#ff0055"), -- Neon Red-Pink

		Text = Color3.fromHex("#ffccd9"), -- Soft Neon Pink
		SubText = Color3.fromHex("#ff8099"), -- Soft Neon Red
		Hover = Color3.fromHex("#910027"), -- Intense Deep Red
		HoverChange = 0.1
	},
	["Neon Orange"] = {
		Name = "Neon Orange",
		Accent = Color3.fromHex("#ff6a00"), -- Bright Orange

		AcrylicMain = Color3.fromHex("#0a0500"), -- Deep Black-Orange
		AcrylicBorder = Color3.fromHex("#913200"), -- Deep Orange
		AcrylicGradient = ColorSequence.new(Color3.fromHex("#0a0500"), Color3.fromHex("#0a0500")),
		AcrylicNoise = 0.92,

		TitleBarLine = Color3.fromHex("#913200"), -- Deep Orange Border
		Tab = Color3.fromHex("#ffd9cc"), -- Soft Orange-White

		Element = Color3.fromHex("#220e00"), -- Dark Orange-Black
		ElementBorder = Color3.fromHex("#913200"), -- Deep Orange
		InElementBorder = Color3.fromHex("#ff6a00"), -- Bright Orange
		ElementTransparency = 0.85,

		ToggleSlider = Color3.fromHex("#d45500"), -- Medium Orange
		ToggleToggled = Color3.fromHex("#0a0500"), -- Deep Black-Orange

		SliderRail = Color3.fromHex("#d45500"), -- Medium Orange

		DropdownFrame = Color3.fromHex("#220e00"), -- Dark Orange-Black
		DropdownHolder = Color3.fromHex("#220e00"), -- Dark Orange-Black
		DropdownBorder = Color3.fromHex("#913200"), -- Deep Orange
		DropdownOption = Color3.fromHex("#ffd9cc"), -- Soft Orange-White

		Keybind = Color3.fromHex("#220e00"), -- Dark Orange-Black

		Input = Color3.fromHex("#140800"), -- Deep Black-Orange
		InputFocused = Color3.fromHex("#140800"), -- Deep Black-Orange
		InputIndicator = Color3.fromHex("#ffa280"), -- Soft Orange

		Dialog = Color3.fromHex("#220e00"), -- Dark Orange-Black
		DialogHolder = Color3.fromHex("#0a0500"), -- Deep Black-Orange
		DialogHolderLine = Color3.fromHex("#913200"), -- Deep Orange
		DialogButton = Color3.fromHex("#220e00"), -- Dark Orange-Black
		DialogButtonBorder = Color3.fromHex("#913200"), -- Deep Orange
		DialogBorder = Color3.fromHex("#913200"), -- Deep Orange
		DialogInput = Color3.fromHex("#140800"), -- Deep Black-Orange
		DialogInputLine = Color3.fromHex("#ff6a00"), -- Bright Orange

		Text = Color3.fromHex("#ffd9cc"), -- Soft Orange-White
		SubText = Color3.fromHex("#ffa280"), -- Soft Orange
		Hover = Color3.fromHex("#913200"), -- Deep Orange
		HoverChange = 0.1
	},
	Ember = {
		Name = "Ember",
		Accent = Color3.fromRGB(217, 87, 0), -- Dark orange accent

		AcrylicMain = Color3.fromRGB(20, 20, 20),
		AcrylicBorder = Color3.fromRGB(130, 100, 70), -- Adjusted for orange theme
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(180, 100, 40), Color3.fromRGB(90, 40, 15)), -- Orange gradient
		AcrylicNoise = 0.92,

		TitleBarLine = Color3.fromRGB(120, 90, 60),
		Tab = Color3.fromRGB(180, 150, 120),

		Element = Color3.fromRGB(160, 130, 100), -- Changed to dark orange
		ElementBorder = Color3.fromRGB(80, 60, 40),
		InElementBorder = Color3.fromRGB(120, 100, 80),
		ElementTransparency = 0.87,

		ToggleSlider = Color3.fromRGB(160, 130, 100),
		ToggleToggled = Color3.fromRGB(0, 0, 0),

		SliderRail = Color3.fromRGB(160, 130, 100),

		DropdownFrame = Color3.fromRGB(200, 170, 140),
		DropdownHolder = Color3.fromRGB(90, 60, 30),
		DropdownBorder = Color3.fromRGB(75, 50, 25),
		DropdownOption = Color3.fromRGB(160, 130, 100),

		Keybind = Color3.fromRGB(160, 130, 100),

		Input = Color3.fromRGB(160, 130, 100),
		InputFocused = Color3.fromRGB(35, 20, 10),
		InputIndicator = Color3.fromRGB(190, 160, 130),
		InputIndicatorFocus = Color3.fromRGB(217, 87, 0), -- Dark orange focus

		Dialog = Color3.fromRGB(90, 60, 30),
		DialogHolder = Color3.fromRGB(75, 45, 20),
		DialogHolderLine = Color3.fromRGB(65, 40, 15),
		DialogButton = Color3.fromRGB(90, 60, 30),
		DialogButtonBorder = Color3.fromRGB(120, 90, 60),
		DialogBorder = Color3.fromRGB(110, 80, 50),
		DialogInput = Color3.fromRGB(100, 70, 40),
		DialogInputLine = Color3.fromRGB(200, 170, 140),

		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(160, 130, 100),
		HoverChange = 0.04,
	},
	Dark = {
		Name = "Dark",
		Accent = Color3.fromRGB(96, 205, 255),

		AcrylicMain = Color3.fromRGB(60, 60, 60),
		AcrylicBorder = Color3.fromRGB(90, 90, 90),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(40, 40, 40), Color3.fromRGB(40, 40, 40)),
		AcrylicNoise = 0.9,

		TitleBarLine = Color3.fromRGB(75, 75, 75),
		Tab = Color3.fromRGB(120, 120, 120),

		Element = Color3.fromRGB(120, 120, 120),
		ElementBorder = Color3.fromRGB(35, 35, 35),
		InElementBorder = Color3.fromRGB(90, 90, 90),
		ElementTransparency = 0.87,

		ToggleSlider = Color3.fromRGB(120, 120, 120),
		ToggleToggled = Color3.fromRGB(0, 0, 0),

		SliderRail = Color3.fromRGB(120, 120, 120),

		DropdownFrame = Color3.fromRGB(160, 160, 160),
		DropdownHolder = Color3.fromRGB(45, 45, 45),
		DropdownBorder = Color3.fromRGB(35, 35, 35),
		DropdownOption = Color3.fromRGB(120, 120, 120),

		Keybind = Color3.fromRGB(120, 120, 120),

		Input = Color3.fromRGB(160, 160, 160),
		InputFocused = Color3.fromRGB(10, 10, 10),
		InputIndicator = Color3.fromRGB(150, 150, 150),

		Dialog = Color3.fromRGB(45, 45, 45),
		DialogHolder = Color3.fromRGB(35, 35, 35),
		DialogHolderLine = Color3.fromRGB(30, 30, 30),
		DialogButton = Color3.fromRGB(45, 45, 45),
		DialogButtonBorder = Color3.fromRGB(80, 80, 80),
		DialogBorder = Color3.fromRGB(70, 70, 70),
		DialogInput = Color3.fromRGB(55, 55, 55),
		DialogInputLine = Color3.fromRGB(160, 160, 160),

		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(120, 120, 120),
		HoverChange = 0.07,
	},
	Darker = {
		Name = "Darker",
		Accent = Color3.fromRGB(72, 138, 182),

		AcrylicMain = Color3.fromRGB(30, 30, 30),
		AcrylicBorder = Color3.fromRGB(60, 60, 60),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15)),
		AcrylicNoise = 0.94,

		TitleBarLine = Color3.fromRGB(65, 65, 65),
		Tab = Color3.fromRGB(100, 100, 100),

		Element = Color3.fromRGB(70, 70, 70),
		ElementBorder = Color3.fromRGB(25, 25, 25),
		InElementBorder = Color3.fromRGB(55, 55, 55),
		ElementTransparency = 0.82,

		DropdownFrame = Color3.fromRGB(120, 120, 120),
		DropdownHolder = Color3.fromRGB(35, 35, 35),
		DropdownBorder = Color3.fromRGB(25, 25, 25),

		Dialog = Color3.fromRGB(35, 35, 35),
		DialogHolder = Color3.fromRGB(25, 25, 25),
		DialogHolderLine = Color3.fromRGB(20, 20, 20),
		DialogButton = Color3.fromRGB(35, 35, 35),
		DialogButtonBorder = Color3.fromRGB(55, 55, 55),
		DialogBorder = Color3.fromRGB(50, 50, 50),
		DialogInput = Color3.fromRGB(45, 45, 45),
		DialogInputLine = Color3.fromRGB(120, 120, 120),
	},
	Light = {
		Name = "Light",
		Accent = Color3.fromRGB(0, 103, 192),

		AcrylicMain = Color3.fromRGB(200, 200, 200),
		AcrylicBorder = Color3.fromRGB(120, 120, 120),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)),
		AcrylicNoise = 0.96,

		TitleBarLine = Color3.fromRGB(160, 160, 160),
		Tab = Color3.fromRGB(90, 90, 90),

		Element = Color3.fromRGB(255, 255, 255),
		ElementBorder = Color3.fromRGB(180, 180, 180),
		InElementBorder = Color3.fromRGB(150, 150, 150),
		ElementTransparency = 0.65,

		ToggleSlider = Color3.fromRGB(40, 40, 40),
		ToggleToggled = Color3.fromRGB(255, 255, 255),

		SliderRail = Color3.fromRGB(40, 40, 40),

		DropdownFrame = Color3.fromRGB(200, 200, 200),
		DropdownHolder = Color3.fromRGB(240, 240, 240),
		DropdownBorder = Color3.fromRGB(200, 200, 200),
		DropdownOption = Color3.fromRGB(150, 150, 150),

		Keybind = Color3.fromRGB(120, 120, 120),

		Input = Color3.fromRGB(200, 200, 200),
		InputFocused = Color3.fromRGB(100, 100, 100),
		InputIndicator = Color3.fromRGB(80, 80, 80),
		InputIndicatorFocus = Color3.fromRGB(0, 103, 192),

		Dialog = Color3.fromRGB(255, 255, 255),
		DialogHolder = Color3.fromRGB(240, 240, 240),
		DialogHolderLine = Color3.fromRGB(228, 228, 228),
		DialogButton = Color3.fromRGB(255, 255, 255),
		DialogButtonBorder = Color3.fromRGB(190, 190, 190),
		DialogBorder = Color3.fromRGB(140, 140, 140),
		DialogInput = Color3.fromRGB(250, 250, 250),
		DialogInputLine = Color3.fromRGB(160, 160, 160),

		Text = Color3.fromRGB(0, 0, 0),
		SubText = Color3.fromRGB(40, 40, 40),
		Hover = Color3.fromRGB(50, 50, 50),
		HoverChange = 0.16,
	},
	DeepOcean = {
		Name = "DeepOcean",
	
		Accent = Color3.fromRGB(0,170,255),
	
		AcrylicMain = Color3.fromRGB(10,18,34),
		AcrylicBorder = Color3.fromRGB(18,36,60),
		AcrylicGradient = ColorSequence.new(
			Color3.fromRGB(10,18,34),
			Color3.fromRGB(8,12,20)
		),
		AcrylicNoise = 0.8,
	
		TitleBarLine = Color3.fromRGB(20,40,68),
		Tab = Color3.fromRGB(12,22,40),
	
		Element = Color3.fromRGB(12,20,38),
		ElementBorder = Color3.fromRGB(20,40,68),
		InElementBorder = Color3.fromRGB(70,85,110),
		ElementTransparency = 0.82,
	
		ToggleSlider = Color3.fromRGB(20,40,68),
		ToggleToggled = Color3.fromRGB(0,170,255),
	
		SliderRail = Color3.fromRGB(20,40,68),
	
		DropdownFrame = Color3.fromRGB(10,18,34),
		DropdownHolder = Color3.fromRGB(10,18,34),
		DropdownBorder = Color3.fromRGB(20,40,68),
		DropdownOption = Color3.fromRGB(12,20,38),
	
		Keybind = Color3.fromRGB(10,18,34),
	
		Input = Color3.fromRGB(10,18,34),
		InputFocused = Color3.fromRGB(16,28,46),
		InputIndicator = Color3.fromRGB(20,40,68),
		InputIndicatorFocus = Color3.fromRGB(0,170,255),
	
		Dialog = Color3.fromRGB(10,18,34),
		DialogHolder = Color3.fromRGB(10,18,34),
		DialogHolderLine = Color3.fromRGB(20,40,68),
		DialogButton = Color3.fromRGB(12,20,38),
		DialogButtonBorder = Color3.fromRGB(20,40,68),
		DialogBorder = Color3.fromRGB(20,40,68),
		DialogInput = Color3.fromRGB(10,18,34),
		DialogInputLine = Color3.fromRGB(0,170,255),
	
		Text = Color3.fromRGB(245,250,255),
		SubText = Color3.fromRGB(175,205,235),
	
		Hover = Color3.fromRGB(20,34,56),
		HoverChange = 0.1,
	},
	Aqua = {
		Name = "Aqua",
		Accent = Color3.fromRGB(70, 200, 200),
 
		AcrylicMain = Color3.fromRGB(16, 22, 22),
		AcrylicBorder = Color3.fromRGB(60, 120, 120),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(45, 110, 110), Color3.fromRGB(20, 40, 40)),
		AcrylicNoise = 0.9,
 
		TitleBarLine = Color3.fromRGB(70, 145, 145),
		Tab = Color3.fromRGB(170, 220, 220),
 
		Element = Color3.fromRGB(40, 70, 70),
		ElementBorder = Color3.fromRGB(60, 120, 120),
		InElementBorder = Color3.fromRGB(90, 150, 150),
		ElementTransparency = 0.82,
 
		ToggleSlider = Color3.fromRGB(60, 120, 120),
		ToggleToggled = Color3.fromRGB(70, 200, 200),
 
		SliderRail = Color3.fromRGB(60, 120, 120),
 
		DropdownFrame = Color3.fromRGB(18, 26, 26),
		DropdownHolder = Color3.fromRGB(20, 40, 40),
		DropdownBorder = Color3.fromRGB(60, 120, 120),
		DropdownOption = Color3.fromRGB(40, 70, 70),
 
		Keybind = Color3.fromRGB(18, 26, 26),
 
		Input = Color3.fromRGB(18, 26, 26),
		InputFocused = Color3.fromRGB(24, 34, 34),
		InputIndicator = Color3.fromRGB(150, 210, 210),
		InputIndicatorFocus = Color3.fromRGB(70, 200, 200),
 
		Dialog = Color3.fromRGB(20, 40, 40),
		DialogHolder = Color3.fromRGB(16, 32, 32),
		DialogHolderLine = Color3.fromRGB(60, 120, 120),
		DialogButton = Color3.fromRGB(30, 55, 55),
		DialogButtonBorder = Color3.fromRGB(90, 150, 150),
		DialogBorder = Color3.fromRGB(60, 120, 120),
		DialogInput = Color3.fromRGB(24, 45, 45),
		DialogInputLine = Color3.fromRGB(150, 210, 210),
 
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(190, 215, 215),
		Hover = Color3.fromRGB(50, 90, 90),
		HoverChange = 0.06,
	},
	Amethyst = {
		Name = "Amethyst",
		Accent = Color3.fromRGB(150, 110, 220),
 
		AcrylicMain = Color3.fromRGB(18, 16, 24),
		AcrylicBorder = Color3.fromRGB(110, 90, 150),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(80, 60, 130), Color3.fromRGB(30, 22, 50)),
		AcrylicNoise = 0.9,
 
		TitleBarLine = Color3.fromRGB(110, 90, 150),
		Tab = Color3.fromRGB(190, 175, 220),
 
		Element = Color3.fromRGB(45, 38, 65),
		ElementBorder = Color3.fromRGB(110, 90, 150),
		InElementBorder = Color3.fromRGB(130, 110, 165),
		ElementTransparency = 0.85,
 
		ToggleSlider = Color3.fromRGB(110, 90, 150),
		ToggleToggled = Color3.fromRGB(150, 110, 220),
 
		SliderRail = Color3.fromRGB(110, 90, 150),
 
		DropdownFrame = Color3.fromRGB(20, 18, 28),
		DropdownHolder = Color3.fromRGB(30, 22, 50),
		DropdownBorder = Color3.fromRGB(110, 90, 150),
		DropdownOption = Color3.fromRGB(45, 38, 65),
 
		Keybind = Color3.fromRGB(20, 18, 28),
 
		Input = Color3.fromRGB(20, 18, 28),
		InputFocused = Color3.fromRGB(28, 24, 38),
		InputIndicator = Color3.fromRGB(180, 165, 210),
		InputIndicatorFocus = Color3.fromRGB(150, 110, 220),
 
		Dialog = Color3.fromRGB(30, 22, 50),
		DialogHolder = Color3.fromRGB(24, 18, 40),
		DialogHolderLine = Color3.fromRGB(110, 90, 150),
		DialogButton = Color3.fromRGB(40, 32, 60),
		DialogButtonBorder = Color3.fromRGB(130, 110, 165),
		DialogBorder = Color3.fromRGB(110, 90, 150),
		DialogInput = Color3.fromRGB(34, 27, 52),
		DialogInputLine = Color3.fromRGB(180, 165, 210),
 
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(205, 195, 225),
		Hover = Color3.fromRGB(60, 50, 90),
		HoverChange = 0.06,
	},
	BloodRed = {
		Name = "BloodRed",
		Accent = Color3.fromRGB(255, 65, 65),
 
		AcrylicMain = Color3.fromRGB(20, 4, 4),
		AcrylicBorder = Color3.fromRGB(90, 20, 20),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(60, 8, 8), Color3.fromRGB(10, 5, 5)),
		AcrylicNoise = 0.85,
 
		TitleBarLine = Color3.fromRGB(90, 20, 20),
		Tab = Color3.fromRGB(220, 160, 160),
 
		Element = Color3.fromRGB(40, 8, 8),
		ElementBorder = Color3.fromRGB(90, 20, 20),
		InElementBorder = Color3.fromRGB(120, 45, 45),
		ElementTransparency = 0.83,
 
		ToggleSlider = Color3.fromRGB(90, 20, 20),
		ToggleToggled = Color3.fromRGB(255, 65, 65),
 
		SliderRail = Color3.fromRGB(90, 20, 20),
 
		DropdownFrame = Color3.fromRGB(22, 5, 5),
		DropdownHolder = Color3.fromRGB(28, 6, 6),
		DropdownBorder = Color3.fromRGB(90, 20, 20),
		DropdownOption = Color3.fromRGB(40, 8, 8),
 
		Keybind = Color3.fromRGB(22, 5, 5),
 
		Input = Color3.fromRGB(22, 5, 5),
		InputFocused = Color3.fromRGB(32, 8, 8),
		InputIndicator = Color3.fromRGB(200, 120, 120),
		InputIndicatorFocus = Color3.fromRGB(255, 65, 65),
 
		Dialog = Color3.fromRGB(28, 6, 6),
		DialogHolder = Color3.fromRGB(22, 5, 5),
		DialogHolderLine = Color3.fromRGB(90, 20, 20),
		DialogButton = Color3.fromRGB(38, 9, 9),
		DialogButtonBorder = Color3.fromRGB(120, 45, 45),
		DialogBorder = Color3.fromRGB(90, 20, 20),
		DialogInput = Color3.fromRGB(30, 7, 7),
		DialogInputLine = Color3.fromRGB(255, 65, 65),
 
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(225, 165, 165),
		Hover = Color3.fromRGB(55, 12, 12),
		HoverChange = 0.08,
	},
	AmberGlow = {
		Name = "AmberGlow",
		Accent = Color3.fromRGB(255, 175, 80),
 
		AcrylicMain = Color3.fromRGB(20, 14, 4),
		AcrylicBorder = Color3.fromRGB(90, 62, 20),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(65, 44, 10), Color3.fromRGB(12, 9, 5)),
		AcrylicNoise = 0.85,
 
		TitleBarLine = Color3.fromRGB(90, 62, 20),
		Tab = Color3.fromRGB(230, 195, 150),
 
		Element = Color3.fromRGB(42, 28, 6),
		ElementBorder = Color3.fromRGB(90, 62, 20),
		InElementBorder = Color3.fromRGB(125, 90, 40),
		ElementTransparency = 0.83,
 
		ToggleSlider = Color3.fromRGB(90, 62, 20),
		ToggleToggled = Color3.fromRGB(255, 175, 80),
 
		SliderRail = Color3.fromRGB(90, 62, 20),
 
		DropdownFrame = Color3.fromRGB(22, 16, 5),
		DropdownHolder = Color3.fromRGB(28, 19, 6),
		DropdownBorder = Color3.fromRGB(90, 62, 20),
		DropdownOption = Color3.fromRGB(42, 28, 6),
 
		Keybind = Color3.fromRGB(22, 16, 5),
 
		Input = Color3.fromRGB(22, 16, 5),
		InputFocused = Color3.fromRGB(32, 22, 7),
		InputIndicator = Color3.fromRGB(220, 175, 120),
		InputIndicatorFocus = Color3.fromRGB(255, 175, 80),
 
		Dialog = Color3.fromRGB(28, 19, 6),
		DialogHolder = Color3.fromRGB(22, 15, 5),
		DialogHolderLine = Color3.fromRGB(90, 62, 20),
		DialogButton = Color3.fromRGB(38, 26, 8),
		DialogButtonBorder = Color3.fromRGB(125, 90, 40),
		DialogBorder = Color3.fromRGB(90, 62, 20),
		DialogInput = Color3.fromRGB(30, 20, 7),
		DialogInputLine = Color3.fromRGB(255, 175, 80),
 
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(230, 200, 165),
		Hover = Color3.fromRGB(55, 38, 10),
		HoverChange = 0.08,
	},
	NeonCyber = {
		Name = "NeonCyber",
		Accent = Color3.fromRGB(60, 255, 195),
 
		AcrylicMain = Color3.fromRGB(8, 9, 14),
		AcrylicBorder = Color3.fromRGB(35, 45, 65),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(15, 30, 45), Color3.fromRGB(6, 6, 10)),
		AcrylicNoise = 0.85,
 
		TitleBarLine = Color3.fromRGB(35, 45, 65),
		Tab = Color3.fromRGB(170, 235, 220),
 
		Element = Color3.fromRGB(14, 20, 30),
		ElementBorder = Color3.fromRGB(35, 45, 65),
		InElementBorder = Color3.fromRGB(55, 80, 100),
		ElementTransparency = 0.83,
 
		ToggleSlider = Color3.fromRGB(35, 45, 65),
		ToggleToggled = Color3.fromRGB(60, 255, 195),
 
		SliderRail = Color3.fromRGB(35, 45, 65),
 
		DropdownFrame = Color3.fromRGB(10, 11, 17),
		DropdownHolder = Color3.fromRGB(12, 13, 20),
		DropdownBorder = Color3.fromRGB(35, 45, 65),
		DropdownOption = Color3.fromRGB(14, 20, 30),
 
		Keybind = Color3.fromRGB(10, 11, 17),
 
		Input = Color3.fromRGB(10, 11, 17),
		InputFocused = Color3.fromRGB(15, 17, 25),
		InputIndicator = Color3.fromRGB(120, 220, 200),
		InputIndicatorFocus = Color3.fromRGB(60, 255, 195),
 
		Dialog = Color3.fromRGB(12, 13, 20),
		DialogHolder = Color3.fromRGB(10, 11, 17),
		DialogHolderLine = Color3.fromRGB(35, 45, 65),
		DialogButton = Color3.fromRGB(16, 20, 30),
		DialogButtonBorder = Color3.fromRGB(55, 80, 100),
		DialogBorder = Color3.fromRGB(35, 45, 65),
		DialogInput = Color3.fromRGB(13, 15, 22),
		DialogInputLine = Color3.fromRGB(60, 255, 195),
 
		Text = Color3.fromRGB(240, 255, 250),
		SubText = Color3.fromRGB(130, 200, 185),
		Hover = Color3.fromRGB(20, 30, 42),
		HoverChange = 0.08,
	},
	Orange = {
		Name = "Orange",
		Accent = Color3.fromRGB(255, 140, 60),
 
		AcrylicMain = Color3.fromRGB(20, 10, 2),
		AcrylicBorder = Color3.fromRGB(85, 45, 12),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(60, 30, 8), Color3.fromRGB(12, 8, 5)),
		AcrylicNoise = 0.85,
 
		TitleBarLine = Color3.fromRGB(85, 45, 12),
		Tab = Color3.fromRGB(230, 175, 130),
 
		Element = Color3.fromRGB(40, 20, 5),
		ElementBorder = Color3.fromRGB(85, 45, 12),
		InElementBorder = Color3.fromRGB(115, 70, 30),
		ElementTransparency = 0.83,
 
		ToggleSlider = Color3.fromRGB(85, 45, 12),
		ToggleToggled = Color3.fromRGB(255, 140, 60),
 
		SliderRail = Color3.fromRGB(85, 45, 12),
 
		DropdownFrame = Color3.fromRGB(22, 11, 3),
		DropdownHolder = Color3.fromRGB(26, 13, 4),
		DropdownBorder = Color3.fromRGB(85, 45, 12),
		DropdownOption = Color3.fromRGB(40, 20, 5),
 
		Keybind = Color3.fromRGB(22, 11, 3),
 
		Input = Color3.fromRGB(22, 11, 3),
		InputFocused = Color3.fromRGB(30, 16, 5),
		InputIndicator = Color3.fromRGB(220, 155, 110),
		InputIndicatorFocus = Color3.fromRGB(255, 140, 60),
 
		Dialog = Color3.fromRGB(26, 13, 4),
		DialogHolder = Color3.fromRGB(22, 11, 3),
		DialogHolderLine = Color3.fromRGB(85, 45, 12),
		DialogButton = Color3.fromRGB(36, 18, 5),
		DialogButtonBorder = Color3.fromRGB(115, 70, 30),
		DialogBorder = Color3.fromRGB(85, 45, 12),
		DialogInput = Color3.fromRGB(28, 14, 4),
		DialogInputLine = Color3.fromRGB(255, 140, 60),
 
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(225, 185, 150),
		Hover = Color3.fromRGB(52, 27, 8),
		HoverChange = 0.08,
	},
	CottonCandy = {
		Name = "Cotton Candy",
		Accent = Color3.fromRGB(255, 155, 210),
 
		AcrylicMain = Color3.fromRGB(30, 20, 28),
		AcrylicBorder = Color3.fromRGB(95, 60, 85),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(70, 45, 62), Color3.fromRGB(24, 18, 24)),
		AcrylicNoise = 0.85,
 
		TitleBarLine = Color3.fromRGB(95, 60, 85),
		Tab = Color3.fromRGB(240, 195, 220),
 
		Element = Color3.fromRGB(48, 32, 42),
		ElementBorder = Color3.fromRGB(95, 60, 85),
		InElementBorder = Color3.fromRGB(125, 95, 115),
		ElementTransparency = 0.83,
 
		ToggleSlider = Color3.fromRGB(95, 60, 85),
		ToggleToggled = Color3.fromRGB(255, 155, 210),
 
		SliderRail = Color3.fromRGB(95, 60, 85),
 
		DropdownFrame = Color3.fromRGB(32, 22, 30),
		DropdownHolder = Color3.fromRGB(36, 24, 33),
		DropdownBorder = Color3.fromRGB(95, 60, 85),
		DropdownOption = Color3.fromRGB(48, 32, 42),
 
		Keybind = Color3.fromRGB(32, 22, 30),
 
		Input = Color3.fromRGB(32, 22, 30),
		InputFocused = Color3.fromRGB(42, 28, 38),
		InputIndicator = Color3.fromRGB(230, 180, 205),
		InputIndicatorFocus = Color3.fromRGB(255, 155, 210),
 
		Dialog = Color3.fromRGB(36, 24, 33),
		DialogHolder = Color3.fromRGB(32, 22, 30),
		DialogHolderLine = Color3.fromRGB(95, 60, 85),
		DialogButton = Color3.fromRGB(50, 34, 45),
		DialogButtonBorder = Color3.fromRGB(125, 95, 115),
		DialogBorder = Color3.fromRGB(95, 60, 85),
		DialogInput = Color3.fromRGB(40, 27, 36),
		DialogInputLine = Color3.fromRGB(255, 155, 210),
 
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(230, 200, 215),
		Hover = Color3.fromRGB(65, 42, 58),
		HoverChange = 0.08,
	},
	BlackGlass = {
		Name = "BlackGlass",
		Accent = Color3.fromRGB(110, 185, 255),
 
		AcrylicMain = Color3.fromRGB(14, 14, 14),
		AcrylicBorder = Color3.fromRGB(255, 255, 255),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 38, 38)),
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 20, 20)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(9, 9, 9)),
		}),
		AcrylicNoise = 0.95,
 
		TitleBarLine = Color3.fromRGB(255, 255, 255),
		Tab = Color3.fromRGB(255, 255, 255),
 
		Element = Color3.fromRGB(24, 24, 24),
		ElementBorder = Color3.fromRGB(255, 255, 255),
		InElementBorder = Color3.fromRGB(100, 100, 100),
		ElementTransparency = 0.4,
 
		ToggleSlider = Color3.fromRGB(250, 250, 250),
		ToggleToggled = Color3.fromRGB(110, 185, 255),
		TransparenToggle = 0.15,
 
		SliderRail = Color3.fromRGB(190, 190, 190),
 
		DropdownFrame = Color3.fromRGB(14, 14, 14),
		DropdownHolder = Color3.fromRGB(14, 14, 14),
		DropdownBorder = Color3.fromRGB(255, 255, 255),
		DropdownOption = Color3.fromRGB(24, 24, 24),
 
		Keybind = Color3.fromRGB(14, 14, 14),
 
		Input = Color3.fromRGB(14, 14, 14),
		InputFocused = Color3.fromRGB(24, 24, 24),
		InputIndicator = Color3.fromRGB(255, 255, 255),
		InputIndicatorFocus = Color3.fromRGB(110, 185, 255),
 
		Dialog = Color3.fromRGB(14, 14, 14),
		DialogHolder = Color3.fromRGB(14, 14, 14),
		DialogHolderLine = Color3.fromRGB(255, 255, 255),
		DialogButton = Color3.fromRGB(24, 24, 24),
		DialogButtonBorder = Color3.fromRGB(255, 255, 255),
		DialogBorder = Color3.fromRGB(255, 255, 255),
		DialogInput = Color3.fromRGB(14, 14, 14),
		DialogInputLine = Color3.fromRGB(110, 185, 255),
 
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(195, 195, 195),
		Hover = Color3.fromRGB(48, 48, 48),
		HoverChange = 0.06,
	},
	RoyalGold = {
		Name = "Royal Gold",
		Accent = Color3.fromRGB(230, 185, 90),
 
		AcrylicMain = Color3.fromRGB(16, 14, 8),
		AcrylicBorder = Color3.fromRGB(95, 78, 40),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(55, 44, 20), Color3.fromRGB(14, 12, 8)),
		AcrylicNoise = 0.9,
 
		TitleBarLine = Color3.fromRGB(95, 78, 40),
		Tab = Color3.fromRGB(225, 200, 150),
 
		Element = Color3.fromRGB(34, 28, 16),
		ElementBorder = Color3.fromRGB(95, 78, 40),
		InElementBorder = Color3.fromRGB(120, 100, 60),
		ElementTransparency = 0.84,
 
		ToggleSlider = Color3.fromRGB(95, 78, 40),
		ToggleToggled = Color3.fromRGB(230, 185, 90),
 
		SliderRail = Color3.fromRGB(95, 78, 40),
 
		DropdownFrame = Color3.fromRGB(18, 16, 10),
		DropdownHolder = Color3.fromRGB(22, 19, 11),
		DropdownBorder = Color3.fromRGB(95, 78, 40),
		DropdownOption = Color3.fromRGB(34, 28, 16),
 
		Keybind = Color3.fromRGB(18, 16, 10),
 
		Input = Color3.fromRGB(18, 16, 10),
		InputFocused = Color3.fromRGB(26, 22, 13),
		InputIndicator = Color3.fromRGB(210, 180, 130),
		InputIndicatorFocus = Color3.fromRGB(230, 185, 90),
 
		Dialog = Color3.fromRGB(22, 19, 11),
		DialogHolder = Color3.fromRGB(18, 16, 10),
		DialogHolderLine = Color3.fromRGB(95, 78, 40),
		DialogButton = Color3.fromRGB(30, 25, 14),
		DialogButtonBorder = Color3.fromRGB(120, 100, 60),
		DialogBorder = Color3.fromRGB(95, 78, 40),
		DialogInput = Color3.fromRGB(24, 20, 12),
		DialogInputLine = Color3.fromRGB(230, 185, 90),
 
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(220, 200, 165),
		Hover = Color3.fromRGB(48, 40, 22),
		HoverChange = 0.06,
	},
	Emerald = {
		Name = "Emerald",
	
		Accent = Color3.fromRGB(80, 235, 160),
	
		AcrylicMain = Color3.fromRGB(14, 24, 18),
		AcrylicBorder = Color3.fromRGB(45, 120, 85),
		AcrylicGradient = ColorSequence.new(
			Color3.fromRGB(28, 70, 50),
			Color3.fromRGB(12, 18, 14)
		),
		AcrylicNoise = 0.9,
	
		TitleBarLine = Color3.fromRGB(45, 120, 85),
		Tab = Color3.fromRGB(32, 52, 40),
	
		Element = Color3.fromRGB(22, 38, 30),
		ElementBorder = Color3.fromRGB(45, 120, 85),
		InElementBorder = Color3.fromRGB(75, 150, 120),
		ElementTransparency = 0.82,
	
		ToggleSlider = Color3.fromRGB(45, 120, 85),
		ToggleToggled = Color3.fromRGB(80, 235, 160),
	
		SliderRail = Color3.fromRGB(45, 120, 85),
	
		DropdownFrame = Color3.fromRGB(18, 30, 24),
		DropdownHolder = Color3.fromRGB(18, 30, 24),
		DropdownBorder = Color3.fromRGB(45, 120, 85),
		DropdownOption = Color3.fromRGB(22, 38, 30),
	
		Keybind = Color3.fromRGB(18, 30, 24),
	
		Input = Color3.fromRGB(18, 30, 24),
		InputFocused = Color3.fromRGB(24, 40, 32),
		InputIndicator = Color3.fromRGB(170, 235, 205),
		InputIndicatorFocus = Color3.fromRGB(80, 235, 160),
	
		Dialog = Color3.fromRGB(18, 30, 24),
		DialogHolder = Color3.fromRGB(18, 30, 24),
		DialogHolderLine = Color3.fromRGB(45, 120, 85),
		DialogButton = Color3.fromRGB(22, 38, 30),
		DialogButtonBorder = Color3.fromRGB(75, 150, 120),
		DialogBorder = Color3.fromRGB(45, 120, 85),
		DialogInput = Color3.fromRGB(20, 34, 28),
		DialogInputLine = Color3.fromRGB(80, 235, 160),
	
		Text = Color3.fromRGB(250, 255, 252),
		SubText = Color3.fromRGB(195, 230, 210),
	
		Hover = Color3.fromRGB(34, 58, 46),
		HoverChange = 0.09,
	}
}

local Library = {
	Version = "1.1.0",

	OpenFrames = {},
	Options = {},
	Themes = Themes.Names,

	Window = nil,
	WindowFrame = nil,
	Unloaded = false,

	Creator = nil,

	DialogOpen = false,
	UseAcrylic = false,
	Acrylic = false,
	Transparency = true,
	MinimizeKeybind = nil,
	MinimizerIcon = nil,
	MinimizeKey = Enum.KeyCode.LeftControl,
}

local function isMotor(value)
	local motorType = tostring(value):match("^Motor%((.+)%)$")

	if motorType then
		return true, motorType
	else
		return false
	end
end

local Connection = {}

Connection.__index = Connection

function Connection.new(signal, handler)
	return setmetatable({
		signal = signal,
		connected = true,
		_handler = handler,
	}, Connection)
end

function Connection:disconnect()
	if self.connected then
		self.connected = false

		for index, connection in pairs(self.signal._connections) do
			if connection == self then
				table.remove(self.signal._connections, index)
				return
			end
		end
	end
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_connections = {},
		_threads = {},
	}, Signal)
end

function Signal:fire(...)
	for _, connection in pairs(self._connections) do
		connection._handler(...)
	end

	for _, thread in pairs(self._threads) do
		coroutine.resume(thread, ...)
	end

	self._threads = {}
end

function Signal:connect(handler)
	local connection = Connection.new(self, handler)
	table.insert(self._connections, connection)
	return connection
end

function Signal:wait()
	table.insert(self._threads, coroutine.running())
	return coroutine.yield()
end

local Linear = {}
Linear.__index = Linear

function Linear.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")

	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_velocity = options.velocity or 1,
	}, Linear)
end

function Linear:step(state, dt)
	local position = state.value
	local velocity = self._velocity -- Linear motion ignores the state's velocity
	local goal = self._targetValue

	local dPos = dt * velocity

	local complete = dPos >= math.abs(goal - position)
	position = position + dPos * (goal > position and 1 or -1)
	if complete then
		position = self._targetValue
		velocity = 0
	end

	return {
		complete = complete,
		value = position,
		velocity = velocity,
	}
end

local Instant = {}
Instant.__index = Instant

function Instant.new(targetValue)
	return setmetatable({
		_targetValue = targetValue,
	}, Instant)
end

function Instant:step()
	return {
		complete = true,
		value = self._targetValue,
	}
end

local VELOCITY_THRESHOLD = 0.001
local POSITION_THRESHOLD = 0.001

local EPS = 0.0001

local Spring = {}
Spring.__index = Spring

function Spring.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")
	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_frequency = options.frequency or 4,
		_dampingRatio = options.dampingRatio or 1,
	}, Spring)
end

function Spring:step(state, dt)
	-- Cache frequently used values and operations
	local d = self._dampingRatio
	local f = self._frequency * 2 * math.pi
	local g = self._targetValue
	local p0 = state.value
	local v0 = state.velocity or 0
	local offset = p0 - g
	local decay = math.exp(-d * f * dt)
	local p1, v1

	-- Pre-calculate common products
	local f_dt = f * dt
	local f_squared = f * f

	-- Move conditional branches outside for better prediction
	if d == 1 then -- Critically damped
		p1 = (offset * (1 + f_dt) + v0 * dt) * decay + g
		v1 = (v0 * (1 - f_dt) - offset * (f_squared * dt)) * decay
	elseif d < 1 then -- Underdamped
		local c = math.sqrt(1 - d * d)
		local c_squared = c * c
		local f_c = f * c
		local f_c_dt = f_c * dt

		local i = math.cos(f_c_dt)
		local j = math.sin(f_c_dt)

		-- Optimize z calculation
		local z
		if c > EPS then
			z = j / c
		else
			local a = dt * f
			local a_squared = a * a
			local a_cubed = a_squared * a
			local c_squared_squared = c_squared * c_squared
			z = a + ((a_squared * c_squared_squared / 20 - c_squared) * a_cubed) / 6
		end

		-- Optimize y calculation
		local y
		if f_c > EPS then
			y = j / f_c
		else
			local b = f_c
			local b_squared = b * b
			local dt_squared = dt * dt
			local dt_cubed = dt_squared * dt
			y = dt + ((dt_squared * b_squared * b_squared / 20 - b_squared) * dt_cubed) / 6
		end

		p1 = (offset * (i + d * z) + v0 * y) * decay + g
		v1 = (v0 * (i - z * d) - offset * (z * f)) * decay
	else -- Overdamped
		local c = math.sqrt(d * d - 1)
		local r1 = -f * (d - c)
		local r2 = -f * (d + c)
		local co2 = (v0 - offset * r1) / (2 * f * c)
		local co1 = offset - co2
		local e1 = co1 * math.exp(r1 * dt)
		local e2 = co2 * math.exp(r2 * dt)
		p1 = e1 + e2 + g
		v1 = e1 * r1 + e2 * r2
	end

	-- Combine the threshold check for early returns
	if math.abs(v1) < VELOCITY_THRESHOLD and math.abs(p1 - g) < POSITION_THRESHOLD then
		return {
			complete = true,
			value = g,
			velocity = v1,
		}
	end

	return {
		complete = false,
		value = p1,
		velocity = v1,
	}
end

local noop = function() end

local BaseMotor = {}
BaseMotor.__index = BaseMotor

function BaseMotor.new()
	return setmetatable({
		_onStep = Signal.new(),
		_onStart = Signal.new(),
		_onComplete = Signal.new(),
	}, BaseMotor)
end

function BaseMotor:onStep(handler)
	return self._onStep:connect(handler)
end

function BaseMotor:onStart(handler)
	return self._onStart:connect(handler)
end

function BaseMotor:onComplete(handler)
	return self._onComplete:connect(handler)
end

function BaseMotor:start()
	if not self._connection then
		self._connection = RunService.RenderStepped:Connect(function(deltaTime)
			self:step(deltaTime)
		end)
	end
end

function BaseMotor:stop()
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end
end

BaseMotor.destroy = BaseMotor.stop

BaseMotor.step = noop
BaseMotor.getValue = noop
BaseMotor.setGoal = noop

function BaseMotor:__tostring()
	return "Motor"
end

local SingleMotor = setmetatable({}, BaseMotor)
SingleMotor.__index = SingleMotor

function SingleMotor.new(initialValue, useImplicitConnections)
	assert(initialValue, "Missing argument #1: initialValue")
	assert(typeof(initialValue) == "number", "initialValue must be a number!")

	local self = setmetatable(BaseMotor.new(), SingleMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._goal = nil
	self._state = {
		complete = true,
		value = initialValue,
	}

	return self
end

function SingleMotor:step(deltaTime)
	if self._state.complete then
		return true
	end

	local newState = self._goal:step(self._state, deltaTime)

	self._state = newState
	self._onStep:fire(newState.value)

	if newState.complete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._onComplete:fire()
	end

	return newState.complete
end

function SingleMotor:getValue()
	return self._state.value
end

function SingleMotor:setGoal(goal)
	self._state.complete = false
	self._goal = goal

	self._onStart:fire()

	if self._useImplicitConnections then
		self:start()
	end
end

function SingleMotor:__tostring()
	return "Motor(Single)"
end

local GroupMotor = setmetatable({}, BaseMotor)
GroupMotor.__index = GroupMotor

local function toMotor(value)
	if isMotor(value) then
		return value
	end

	local valueType = typeof(value)

	if valueType == "number" then
		return SingleMotor.new(value, false)
	elseif valueType == "table" then
		return GroupMotor.new(value, false)
	end

	error(("Unable to convert %q to motor; type %s is unsupported"):format(value, valueType), 2)
end

function GroupMotor.new(initialValues, useImplicitConnections)
	assert(initialValues, "Missing argument #1: initialValues")
	assert(typeof(initialValues) == "table", "initialValues must be a table!")
	assert(
		not initialValues.step,
		'initialValues contains disallowed property "step". Did you mean to put a table of values here?'
	)

	local self = setmetatable(BaseMotor.new(), GroupMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._complete = true
	self._motors = {}

	for key, value in pairs(initialValues) do
		self._motors[key] = toMotor(value)
	end

	return self
end

function GroupMotor:step(deltaTime)
	if self._complete then
		return true
	end

	local allMotorsComplete = true

	for _, motor in pairs(self._motors) do
		local complete = motor:step(deltaTime)
		if not complete then
			-- If any of the sub-motors are incomplete, the group motor will not be complete either
			allMotorsComplete = false
		end
	end

	self._onStep:fire(self:getValue())

	if allMotorsComplete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._complete = true
		self._onComplete:fire()
	end

	return allMotorsComplete
end

function GroupMotor:setGoal(goals)
	assert(not goals.step, 'goals contains disallowed property "step". Did you mean to put a table of goals here?')

	self._complete = false
	self._onStart:fire()

	for key, goal in pairs(goals) do
		local motor = assert(self._motors[key], ("Unknown motor for key %s"):format(key))
		motor:setGoal(goal)
	end

	if self._useImplicitConnections then
		self:start()
	end
end

function GroupMotor:getValue()
	local values = {}

	for key, motor in pairs(self._motors) do
		values[key] = motor:getValue()
	end

	return values
end

function GroupMotor:__tostring()
	return "Motor(Group)"
end

local Flipper = {
	SingleMotor = SingleMotor,
	GroupMotor = GroupMotor,

	Instant = Instant,
	Linear = Linear,
	Spring = Spring,

	isMotor = isMotor,
}

local Creator = {
	Registry = {},
	Signals = {},
	TransparencyMotors = {},
	DefaultProperties = {
		ScreenGui = {
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		},
		Frame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ScrollingFrame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ScrollBarImageColor3 = Color3.new(0, 0, 0),
		},
		TextLabel = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 1,
			TextSize = 14,
			AutoLocalize = false,
		},
		TextButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		TextBox = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ClearTextOnFocus = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		ImageLabel = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ImageButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
		},
		CanvasGroup = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
	},
}

local function ApplyCustomProps(Object, Props)
	if Props.ThemeTag then
		Creator.AddThemeObject(Object, Props.ThemeTag)
	end
end

function Creator.AddSignal(Signal, Function)
	local Connected = Signal:Connect(Function)
	table.insert(Creator.Signals, Connected)
	return Connected
end

function Creator.Disconnect()
	for Idx = #Creator.Signals, 1, -1 do
		local Connection = table.remove(Creator.Signals, Idx)
		if Connection.Disconnect then
			Connection:Disconnect()
		end
	end
end

function Creator.UpdateTheme()
	for Instance, Object in next, Creator.Registry do
		for Property, ColorIdx in next, Object.Properties do
			local Theme_Property = Creator.GetThemeProperty(ColorIdx)
			if Theme_Property then
				Instance[Property] = Theme_Property
			end
		end
	end

	for _, Motor in next, Creator.TransparencyMotors do
		Motor:setGoal(Flipper.Instant.new(Creator.GetThemeProperty("ElementTransparency")))
	end
end

function Creator.AddThemeObject(Object, Properties)
	local Idx = #Creator.Registry + 1
	local Data = {
		Object = Object,
		Properties = Properties,
		Idx = Idx,
	}

	Creator.Registry[Object] = Data
	Creator.UpdateTheme()
	return Object
end

function Creator.OverrideTag(Object, Properties)
	Creator.Registry[Object].Properties = Properties
	Creator.UpdateTheme()
end

function Creator.GetThemeProperty(Property)
	if Themes[Library.Theme][Property] then
		return Themes[Library.Theme][Property]
	end
	return Themes["Dark"][Property]
end

function Creator.New(Name, Properties, Children)
	local Object = Instance.new(Name)

	-- Default properties
	for Name, Value in next, Creator.DefaultProperties[Name] or {} do
		Object[Name] = Value
	end

	-- Properties
	for Name, Value in next, Properties or {} do
		if Name ~= "ThemeTag" then
			Object[Name] = Value
		end
	end

	-- Children
	for _, Child in next, Children or {} do
		Child.Parent = Object
	end

	ApplyCustomProps(Object, Properties)
	return Object
end

function Creator.SpringMotor(Initial, Instance, Prop, IgnoreDialogCheck, ResetOnThemeChange)
	IgnoreDialogCheck = IgnoreDialogCheck or false
	ResetOnThemeChange = ResetOnThemeChange or false
	local Motor = Flipper.SingleMotor.new(Initial)
	Motor:onStep(function(value)
		Instance[Prop] = value
	end)

	if ResetOnThemeChange then
		table.insert(Creator.TransparencyMotors, Motor)
	end

	local function SetValue(Value, Ignore)
		Ignore = Ignore or false
		if not IgnoreDialogCheck then
			if not Ignore then
				if Prop == "BackgroundTransparency" and Library.DialogOpen then
					return
				end
			end
		end
		Motor:setGoal(Flipper.Spring.new(Value, { frequency = 8 }))
	end

	return Motor, SetValue
end

Library.Creator = Creator

local New = Creator.New


local LibraryID = "Roblox/Ui"

local PanelParent = game:GetService("CoreGui")
local Panel = PanelParent:FindFirstChild(LibraryID)
if Panel then
	Panel:Destroy()
end

local GUI = New("ScreenGui", {
	Parent = PanelParent,
	Name = LibraryID,
})

Library.GUI = GUI
ProtectGui(GUI)

function Library:SafeCallbackToggles(Title, Function, ...)
	if not Function then
		return
	end

	local Success, Event = pcall(Function, ...)
	if not Success then
		local _, i = Event:find(":%d+: ")

		if not i then
			return Library:Notify({
				Title = "Interface",
				Content = "Callback error",
				SubContent = Title,
				Duration = 5,
			})
		end

		return Library:Notify({
			Title = "Interface",
			Content = "Callback error",
			SubContent = Title,
			Duration = 5,
		})
	end
end
function Library:SafeCallback(Function, ...)
	if not Function then
		return
	end

	local Success, Event = pcall(Function, ...)
	if not Success then
		local _, i = Event:find(":%d+: ")

		if not i then
			return Library:Notify({
				Title = "Interface",
				Content = "Callback error",
				SubContent = Event,
				Duration = 5,
			})
		end

		return Library:Notify({
			Title = "Interface",
			Content = "Callback error",
			SubContent = Event:sub(i + 1),
			Duration = 5,
		})
	end
end

function Library:Round(Number, Factor)
	if Factor == 0 then
		return math.floor(Number)
	end
	Number = tostring(Number)
	return Number:find("%.") and tonumber(Number:sub(1, Number:find("%.") + Factor)) or Number
end

local function map(value, inMin, inMax, outMin, outMax)
	return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin
end

local function viewportPointToWorld(location, distance)
	local unitRay = game:GetService("Workspace").CurrentCamera:ScreenPointToRay(location.X, location.Y)
	return unitRay.Origin + unitRay.Direction * distance
end

local function getOffset()
	local viewportSizeY = game:GetService("Workspace").CurrentCamera.ViewportSize.Y
	return map(viewportSizeY, 0, 2560, 8, 56)
end

local viewportPointToWorld, getOffset = unpack({ viewportPointToWorld, getOffset })

local BlurFolder = Instance.new("Folder", game:GetService("Workspace").CurrentCamera)

local function createAcrylic()
	local Part = Creator.New("Part", {
		Name = "Body",
		Color = Color3.new(0, 0, 0),
		Material = Enum.Material.Glass,
		Size = Vector3.new(1, 1, 0),
		Anchored = true,
		CanCollide = false,
		Locked = true,
		CastShadow = false,
		Transparency = 0.98,
	}, {
		Creator.New("SpecialMesh", {
			MeshType = Enum.MeshType.Brick,
			Offset = Vector3.new(0, 0, -0.000001),
		}),
	})

	return Part
end

function AcrylicBlur()
	local function createAcrylicBlur(distance)
		local cleanups = {}

		distance = distance or 0.001
		local positions = {
			topLeft = Vector2.new(),
			topRight = Vector2.new(),
			bottomRight = Vector2.new(),
		}
		local model = createAcrylic()
		model.Parent = BlurFolder

		local function updatePositions(size, position)
			positions.topLeft = position
			positions.topRight = position + Vector2.new(size.X, 0)
			positions.bottomRight = position + size
		end

		local function render()
			local res = game:GetService("Workspace").CurrentCamera
			if res then
				res = res.CFrame
			end
			local cond = res
			if not cond then
				cond = CFrame.new()
			end

			local camera = cond
			local topLeft = positions.topLeft
			local topRight = positions.topRight
			local bottomRight = positions.bottomRight

			local topLeft3D = viewportPointToWorld(topLeft, distance)
			local topRight3D = viewportPointToWorld(topRight, distance)
			local bottomRight3D = viewportPointToWorld(bottomRight, distance)

			local width = (topRight3D - topLeft3D).Magnitude
			local height = (topRight3D - bottomRight3D).Magnitude

			model.CFrame =
				CFrame.fromMatrix((topLeft3D + bottomRight3D) / 2, camera.XVector, camera.YVector, camera.ZVector)
			model.Mesh.Scale = Vector3.new(width, height, 0)
		end

		local function onChange(rbx)
			local offset = getOffset()
			local size = rbx.AbsoluteSize - Vector2.new(offset, offset)
			local position = rbx.AbsolutePosition + Vector2.new(offset / 2, offset / 2)

			updatePositions(size, position)
			task.spawn(render)
		end

		local function renderOnChange()
			local camera = game:GetService("Workspace").CurrentCamera
			if not camera then
				return
			end

			table.insert(cleanups, camera:GetPropertyChangedSignal("CFrame"):Connect(render))
			table.insert(cleanups, camera:GetPropertyChangedSignal("ViewportSize"):Connect(render))
			table.insert(cleanups, camera:GetPropertyChangedSignal("FieldOfView"):Connect(render))
			task.spawn(render)
		end

		model.Destroying:Connect(function()
			for _, item in cleanups do
				pcall(function()
					item:Disconnect()
				end)
			end
		end)

		renderOnChange()

		return onChange, model
	end

	return function(distance)
		local Blur = {}
		local onChange, model = createAcrylicBlur(distance)

		local comp = Creator.New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
		})

		Creator.AddSignal(comp:GetPropertyChangedSignal("AbsolutePosition"), function()
			onChange(comp)
		end)

		Creator.AddSignal(comp:GetPropertyChangedSignal("AbsoluteSize"), function()
			onChange(comp)
		end)

		Blur.AddParent = function(Parent)
			Creator.AddSignal(Parent:GetPropertyChangedSignal("Visible"), function()
				Blur.SetVisibility(Parent.Visible)
			end)
		end

		Blur.SetVisibility = function(Value)
			model.Transparency = Value and 0.98 or 1
		end

		Blur.Frame = comp
		Blur.Model = model

		return Blur
	end
end

function AcrylicPaint()
	local New = Creator.New
	local AcrylicBlur = AcrylicBlur()

	return function(props)
		local AcrylicPaint = {}

		AcrylicPaint.Frame = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 0.9,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
		}, {
			New("ImageLabel", {
				Image = "rbxassetid://8992230677",
				ScaleType = "Slice",
				SliceCenter = Rect.new(Vector2.new(99, 99), Vector2.new(99, 99)),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(1, 120, 1, 116),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1,
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.7,
			}),

			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),

			New("Frame", {
				BackgroundTransparency = 0.45,
				Size = UDim2.fromScale(1, 1),
				Name = "Background",
				ThemeTag = {
					BackgroundColor3 = "AcrylicMain",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}),

			New("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.4,
				Size = UDim2.fromScale(1, 1),
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),

				New("UIGradient", {
					Rotation = 90,
					ThemeTag = {
						Color = "AcrylicGradient",
					},
				}),
			}),

			New("ImageLabel", {
				Image = "rbxassetid://9968344105",
				ImageTransparency = 0.98,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.new(0, 128, 0, 128),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}),

			New("ImageLabel", {
				Image = "rbxassetid://9968344227",
				ImageTransparency = 0.9,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.new(0, 128, 0, 128),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageTransparency = "AcrylicNoise",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}),

			New("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
				New("UIStroke", {
					Transparency = 0.5,
					Thickness = 1,
					ThemeTag = {
						Color = "AcrylicBorder",
					},
				}),
			}),
		})

		local Blur

		if Library.UseAcrylic then
			Blur = AcrylicBlur()
			Blur.Frame.Parent = AcrylicPaint.Frame
			AcrylicPaint.Model = Blur.Model
			AcrylicPaint.AddParent = Blur.AddParent
			AcrylicPaint.SetVisibility = Blur.SetVisibility
		end

		return AcrylicPaint
	end
end

local Acrylic = {
	AcrylicBlur = AcrylicBlur(),
	CreateAcrylic = createAcrylic,
	AcrylicPaint = AcrylicPaint(),
}

function Acrylic.init()
	local baseEffect = Instance.new("DepthOfFieldEffect")
	baseEffect.FarIntensity = 0
	baseEffect.InFocusRadius = 0.1
	baseEffect.NearIntensity = 1

	local depthOfFieldDefaults = {}

	function Acrylic.Enable()
		for _, effect in pairs(depthOfFieldDefaults) do
			effect.Enabled = false
		end
		baseEffect.Parent = game:GetService("Lighting")
	end

	function Acrylic.Disable()
		for _, effect in pairs(depthOfFieldDefaults) do
			effect.Enabled = effect.enabled
		end
		baseEffect.Parent = nil
	end

	local function registerDefaults()
		local function register(object)
			if object:IsA("DepthOfFieldEffect") then
				depthOfFieldDefaults[object] = { enabled = object.Enabled }
			end
		end

		for _, child in pairs(game:GetService("Lighting"):GetChildren()) do
			register(child)
		end

		if game:GetService("Workspace").CurrentCamera then
			for _, child in pairs(game:GetService("Workspace").CurrentCamera:GetChildren()) do
				register(child)
			end
		end
	end

	registerDefaults()
	Acrylic.Enable()
end

local Components = {
	Assets = {
		Close = "rbxassetid://9886659671",
		Min = "rbxassetid://9886659276",
		Max = "rbxassetid://9886659406",
		Restore = "rbxassetid://9886659001",
	},
}

local New = Creator.New
local Spring = Flipper.Spring.new
local Instant = Flipper.Instant.new
local AddSignal = Creator.AddSignal

-- LayoutOrder duy nhat cho moi element/section.
-- Truoc day tat ca deu = 7 -> UIListLayout phai dua vao thu tu child de xep,
-- khi search di chuyen element sang khung ket qua roi tra ve (re-parent ve cuoi
-- danh sach child) thi thu tu bi xao tron. Danh so tang dan de thu tu luon
-- co dinh theo luc tao, khong phu thuoc thu tu re-parent.
local ElementLayoutOrder = 0
local function NextLayoutOrder()
	ElementLayoutOrder = ElementLayoutOrder + 1
	return ElementLayoutOrder
end

-- "Nha" goc cua tung element/section: parent va layout order ngay luc tao.
-- Search se di chuyen element sang khung ket qua; khi xoa search ta tra ve
-- dua tren bang nay nen thu tu LUON dung, khong phu thuoc vao danh sach tam
-- (danh sach tam co the bi lech neu search doi lien tuc / doi tab giua chung).
-- KHONG dung weak table: neu Lua GC don key thi mat "nha" -> element ve sai cho.
-- Entry duoc xoa thu cong trong Element:Destroy.
local ElementHomes = {}

local function RememberHome(Object, Parent, Order)
	if not Object then
		return
	end
	ElementHomes[Object] = { Parent = Parent, LayoutOrder = Order }
end

local function ForgetHome(Object)
	if Object then
		ElementHomes[Object] = nil
	end
end

local function RestoreHome(Object)
	local Home = ElementHomes[Object]
	if not Home then
		return false
	end

	local HomeParent = Home.Parent
	if not HomeParent or not HomeParent:IsDescendantOf(game) then
		return false
	end

	Object.LayoutOrder = Home.LayoutOrder
	if Object.Parent ~= HomeParent then
		Object.Parent = HomeParent
	end
	-- set lai lan nua sau khi doi parent de chac chan layout dung
	Object.LayoutOrder = Home.LayoutOrder
	return true
end

Components.Element = function(Title, Desc, Parent, Hover, Options)
	local Element = { Original = { Text = "" } }
	local Options = Options or {}

	Element.TitleLabel = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
		Text = Title,
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, 0, 0, 14),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		AutoLocalize = false,
		ThemeTag = {
			TextColor3 = "Text",
		},
	})

	Element.DescLabel = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		Text = Desc,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 12,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 14),
		AutoLocalize = false,
		ThemeTag = {
			TextColor3 = "SubText",
		},
	})

	Element.LabelHolder = New("Frame", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 0),
		Size = UDim2.new(1, -28, 0, 0),
	}, {
		New("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
		New("UIPadding", {
			PaddingBottom = UDim.new(0, 13),
			PaddingTop = UDim.new(0, 13),
		}),
		Element.TitleLabel,
		Element.DescLabel,
	})

	Element.Border = New("UIStroke", {
		Transparency = 0.5,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(0, 0, 0),
		ThemeTag = {
			Color = "ElementBorder",
		},
	})

	local ElementOrder = NextLayoutOrder()

	Element.Frame = New("TextButton", {
		Visible = Options.Visible and Options.Visible or true,
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundTransparency = 0.89,
		BackgroundColor3 = Color3.fromRGB(130, 130, 130),
		Parent = Parent,
		AutomaticSize = Enum.AutomaticSize.Y,
		Text = "",
		LayoutOrder = ElementOrder,
		ThemeTag = {
			BackgroundColor3 = "Element",
			BackgroundTransparency = "ElementTransparency",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
		Element.Border,
		Element.LabelHolder,
	})

	RememberHome(Element.Frame, Parent, ElementOrder)

	function Element:SetTitle(Set)
		Element.TitleLabel.Text = Set
	end

	function Element:Visible(Bool)
		Element.Frame.Visible = Bool
	end

	function Element:SetDesc(Set)
		if Set == nil then
			Set = ""
		end
		if Set == "" then
			Element.DescLabel.Visible = false
		else
			Element.DescLabel.Visible = true
		end
		Element.DescLabel.Text = Set
	end

	function Element:AddText(Add)
		if not string.find(Element.TitleLabel.Text, Add, 1, true) then
			Element.TitleLabel.Text = Element.TitleLabel.Text .. "" .. Add
		end
	end

	function Element:GetOriginalText()
		return Element.Original.Text
	end

	function Element:GetTitle()
		return Element.TitleLabel.Text
	end

	function Element:GetDesc()
		return Element.DescLabel.Text
	end

	function Element:Destroy()
		ForgetHome(Element.Frame)
		Element.Frame:Destroy()
	end

	Element:SetTitle(Title)
	Element:SetDesc(Desc)

	Element.Original.Text = Title

	if Hover then
		local Themes = Library.Themes
		local Motor, SetTransparency = Creator.SpringMotor(
			Creator.GetThemeProperty("ElementTransparency"),
			Element.Frame,
			"BackgroundTransparency",
			false,
			true
		)

		Creator.AddSignal(Element.Frame.MouseEnter, function()
			SetTransparency(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"))
		end)
		Creator.AddSignal(Element.Frame.MouseLeave, function()
			SetTransparency(Creator.GetThemeProperty("ElementTransparency"))
		end)
		Creator.AddSignal(Element.Frame.MouseButton1Down, function()
			SetTransparency(Creator.GetThemeProperty("ElementTransparency") + Creator.GetThemeProperty("HoverChange"))
		end)
		Creator.AddSignal(Element.Frame.MouseButton1Up, function()
			SetTransparency(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"))
		end)
	end

	return Element
end

Components.Section = function(Title, Parent)
	local Section = {}

	-- SortOrder phai la LayoutOrder: neu khong, cac TextButton trung ten se
	-- xep theo thu tu child -> re-parent khi clear search lam xao tron
	Section.Layout = New("UIListLayout", {
		Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	Section.Container = New("Frame", {
		Size = UDim2.new(1, 0, 0, 26),
		Position = UDim2.fromOffset(0, 24),
		BackgroundTransparency = 1,
	}, {
		Section.Layout,
	})

	local SectionOrder = NextLayoutOrder()

	Section.Root = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 26),
		LayoutOrder = SectionOrder,
		Parent = Parent,
	}, {
		New("TextLabel", {
			RichText = true,
			Text = Title,
			TextTransparency = 0,
			FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize = 22,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, -16, 0, 18),
			Position = UDim2.fromOffset(0, 2),
			AutoLocalize = false,
			ThemeTag = {
				TextColor3 = "Text",
			},
		}),
		Section.Container,
	})

	RememberHome(Section.Root, Parent, SectionOrder)

	Creator.AddSignal(Section.Layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		Section.Container.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y)
		Section.Root.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y + 25)
	end)
	
	return Section
end
Components.Tab = (function()
	local Components = Components

	local TabModule = {
		Window      = nil,
		Tabs        = {},
		Containers  = {},
		SelectedTab = 0,
		TabCount    = 0,
		Callback    = function() end,
	}

	function TabModule:Init(Window)
		TabModule.Window = Window
		return TabModule
	end

	function TabModule:GetCurrentTabPos()
		local TabHolderPos = TabModule.Window.TabHolder.AbsolutePosition.Y
		local TabPos       = TabModule.Tabs[TabModule.SelectedTab].Frame.AbsolutePosition.Y
		return TabPos - TabHolderPos
	end

	function TabModule:New(Title, Icon, Parent)
		local Window   = TabModule.Window
		local Elements = Library.Elements

		TabModule.TabCount = TabModule.TabCount + 1
		local TabIndex = TabModule.TabCount

		local Tab = {
			Selected = false,
			Name     = Title,
			Type     = "Tab",
		}

		if Library:GetIcon(Icon) then
			Icon = Library:GetIcon(Icon)
		end
		if Icon == "" or Icon == nil then
			Icon = nil
		end

		-- ── Pill background (hidden when unselected) ──────────
		local PillBg = New("Frame", {
			Size             = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			ThemeTag         = { BackgroundColor3 = "Accent" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 8) }),
		})

		-- ── Left accent bar ───────────────────────────────────
		local AccentBar = New("Frame", {
			Size             = UDim2.new(0, 3, 0, 0),   -- height animated
			AnchorPoint      = Vector2.new(0, 0.5),
			Position         = UDim2.new(0, 0, 0.5, 0),
			BackgroundColor3 = Color3.fromRGB(96, 205, 255),
			BackgroundTransparency = 1,
			ThemeTag         = { BackgroundColor3 = "Accent" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 2) }),
		})

		-- ── Icon ──────────────────────────────────────────────
		local IconLabel = New("ImageLabel", {
			AnchorPoint      = Vector2.new(0, 0.5),
			Size             = UDim2.fromOffset(16, 16),
			Position         = UDim2.new(0, 8, 0.5, 0),
			BackgroundTransparency = 1,
			Image            = Icon or "",
			ImageTransparency = 0.35,
			ThemeTag         = { ImageColor3 = "Text" },
		})

		-- ── Title label ───────────────────────────────────────
		local TitleLabel = New("TextLabel", {
			AnchorPoint      = Vector2.new(0, 0.5),
			Position         = Icon and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 12, 0.5, 0),
			Text             = Title,
			RichText         = true,
			TextTransparency = 0.35,
			FontFace         = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.Regular,
				Enum.FontStyle.Normal
			),
			TextSize         = 12,
			TextXAlignment   = Enum.TextXAlignment.Left,
			TextYAlignment   = Enum.TextYAlignment.Center,
			Size             = UDim2.new(1, -12, 1, 0),
			BackgroundTransparency = 1,
			AutoLocalize     = false,
			ThemeTag         = { TextColor3 = "Text" },
		})

		-- ── Tab frame ─────────────────────────────────────────
		Tab.Frame = New("TextButton", {
			Size             = UDim2.new(1, 0, 0, 34),
			BackgroundTransparency = 1,
			Parent           = Parent,
			ThemeTag         = { BackgroundColor3 = "Tab" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 8) }),
			PillBg,
			AccentBar,
			IconLabel,
			TitleLabel,
		})

		-- ── Container scroll frame (unchanged) ───────────────
		local ContainerLayout = New("UIListLayout", {
			Padding      = UDim.new(0, 5),
			SortOrder    = Enum.SortOrder.LayoutOrder,
		})

		Tab.ContainerFrame = New("ScrollingFrame", {
			Size                   = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Parent                 = Window.ContainerHolder,
			Visible                = false,
			BottomImage            = "rbxassetid://6889812791",
			MidImage               = "rbxassetid://6889812721",
			TopImage               = "rbxassetid://6276641225",
			ScrollBarImageColor3   = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.95,
			ScrollBarThickness     = 3,
			BorderSizePixel        = 0,
			CanvasSize             = UDim2.fromScale(0, 0),
			ScrollingDirection     = Enum.ScrollingDirection.Y,
		}, {
			ContainerLayout,
			New("UIPadding", {
				PaddingRight  = UDim.new(0, 10),
				PaddingLeft   = UDim.new(0, 1),
				PaddingTop    = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
			}),
		})

		Creator.AddSignal(ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Tab.ContainerFrame.CanvasSize =
				UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 2)
		end)

		-- ── Easing presets ────────────────────────────────────
		local TI_NORM = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local TI_BACK = TweenInfo.new(0.25, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)

		-- ── State appliers ────────────────────────────────────
		local function applySelected()
			-- pill fades in
			TweenService:Create(PillBg, TI_NORM, {
				BackgroundTransparency = 0.88,
			}):Play()
			-- accent bar grows
			TweenService:Create(AccentBar, TI_BACK, {
				Size                   = UDim2.new(0, 3, 0.55, 0),
				BackgroundTransparency = 0,
			}):Play()
			-- text & icon become fully opaque
			TweenService:Create(TitleLabel, TI_NORM, { TextTransparency  = 0    }):Play()
			TweenService:Create(IconLabel,  TI_NORM, { ImageTransparency = 0    }):Play()
		end

		local function applyUnselected()
			TweenService:Create(PillBg, TI_NORM, {
				BackgroundTransparency = 1,
			}):Play()
			TweenService:Create(AccentBar, TI_NORM, {
				Size                   = UDim2.new(0, 3, 0, 0),
				BackgroundTransparency = 1,
			}):Play()
			TweenService:Create(TitleLabel, TI_NORM, { TextTransparency  = 0.35 }):Play()
			TweenService:Create(IconLabel,  TI_NORM, { ImageTransparency = 0.35 }):Play()
		end

		-- ── Hover (only when not selected) ───────────────────
		Creator.AddSignal(Tab.Frame.MouseEnter, function()
			if not Tab.Selected then
				TweenService:Create(PillBg, TI_NORM, { BackgroundTransparency = 0.94 }):Play()
				TweenService:Create(TitleLabel, TI_NORM, { TextTransparency = 0.15 }):Play()
				TweenService:Create(IconLabel,  TI_NORM, { ImageTransparency = 0.15 }):Play()
			end
		end)
		Creator.AddSignal(Tab.Frame.MouseLeave, function()
			if not Tab.Selected then
				TweenService:Create(PillBg, TI_NORM, { BackgroundTransparency = 1 }):Play()
				TweenService:Create(TitleLabel, TI_NORM, { TextTransparency = 0.35 }):Play()
				TweenService:Create(IconLabel,  TI_NORM, { ImageTransparency = 0.35 }):Play()
			end
		end)
		Creator.AddSignal(Tab.Frame.MouseButton1Down, function()
			TweenService:Create(PillBg, TI_NORM, { BackgroundTransparency = 0.82 }):Play()
		end)
		Creator.AddSignal(Tab.Frame.MouseButton1Up, function()
			local t = Tab.Selected and 0.88 or 0.94
			TweenService:Create(PillBg, TI_NORM, { BackgroundTransparency = t }):Play()
		end)

		-- ── SetTransparency shim (SelectTab still calls this) ─
		Tab.Motor, Tab.SetTransparency = Creator.SpringMotor(1, Tab.Frame, "BackgroundTransparency")

		-- ── Click ─────────────────────────────────────────────
		Creator.AddSignal(Tab.Frame.MouseButton1Click, function()
			TabModule:SelectTab(TabIndex)
			TabModule.Callback(TabIndex)
		end)

		TabModule.Containers[TabIndex] = Tab.ContainerFrame
		TabModule.Tabs[TabIndex]       = Tab

		-- store appliers so SelectTab can call them
		Tab._applySelected   = applySelected
		Tab._applyUnselected = applyUnselected

		Tab.Container   = Tab.ContainerFrame
		Tab.ScrollFrame = Tab.Container

		function Tab:AddSection(SectionTitle)
			local Section = { Type = "Section" }
			local SectionFrame  = Components.Section(SectionTitle, Tab.Container)
			Section.Container   = SectionFrame.Container
			Section.ScrollFrame = Tab.Container
			setmetatable(Section, Elements)
			return Section
		end

		setmetatable(Tab, Elements)
		return Tab
	end

	function TabModule:GetCurrentTab()
		return self.SelectedTab
	end

	function TabModule:SelectTab(Tab)
		local Window = TabModule.Window

		TabModule.SelectedTab = Tab

		-- neu dang search thi xoa search de tra element ve cho cu
		if Window.ClearSearch then
			Window.ClearSearch()
		end

		-- deselect all
		for _, TabObject in next, TabModule.Tabs do
			TabObject.Selected = false
			if TabObject._applyUnselected then
				TabObject._applyUnselected()
			else
				TabObject.SetTransparency(1)
			end
		end

		-- select target
		local target = TabModule.Tabs[Tab]
		target.Selected = true
		if target._applySelected then
			target._applySelected()
		else
			target.SetTransparency(0.89)
		end

		-- update header text + selector bar (existing window logic)
		Window.TabDisplay.Text = target.Name
		Window.SelectorPosMotor:setGoal(
			Flipper.Spring.new(TabModule:GetCurrentTabPos(), { frequency = 6 })
		)

		-- container swap animation (unchanged)
		task.spawn(function()
			Window.ContainerHolder.Parent = Window.ContainerAnim
			Window.ContainerPosMotor:setGoal(Flipper.Spring.new(15, { frequency = 10 }))
			Window.ContainerBackMotor:setGoal(Flipper.Spring.new(1,  { frequency = 10 }))
			task.wait(0.12)
			for _, Container in next, TabModule.Containers do
				Container.Visible = false
			end
			TabModule.Containers[Tab].Visible = true
			Window.ContainerPosMotor:setGoal(Flipper.Spring.new(0, { frequency = 5 }))
			Window.ContainerBackMotor:setGoal(Flipper.Spring.new(0, { frequency = 8 }))
			task.wait(0.12)
			Window.ContainerHolder.Parent = Window.ContainerCanvas
		end)
	end

	return TabModule
end)()
Components.Button = function(Theme, Parent, DialogCheck)
	DialogCheck = DialogCheck or false
	local Button = {}

	Button.Title = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		AutoLocalize = false,
		ThemeTag = {
			TextColor3 = "Text",
		},
	})

	Button.HoverFrame = New("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ThemeTag = {
			BackgroundColor3 = "Hover",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
	})

	Button.Frame = New("TextButton", {
		Size = UDim2.new(0, 0, 0, 32),
		Parent = Parent,
		ThemeTag = {
			BackgroundColor3 = "DialogButton",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
		New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Transparency = 0.65,
			ThemeTag = {
				Color = "DialogButtonBorder",
			},
		}),
		Button.HoverFrame,
		Button.Title,
	})

	local Motor, SetTransparency = Creator.SpringMotor(1, Button.HoverFrame, "BackgroundTransparency", DialogCheck)
	Creator.AddSignal(Button.Frame.MouseEnter, function()
		SetTransparency(0.97)
	end)
	Creator.AddSignal(Button.Frame.MouseLeave, function()
		SetTransparency(1)
	end)
	Creator.AddSignal(Button.Frame.MouseButton1Down, function()
		SetTransparency(1)
	end)
	Creator.AddSignal(Button.Frame.MouseButton1Up, function()
		SetTransparency(0.97)
	end)

	return Button
end
Components.Dialog = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Dialog = {
		Window = nil,
	}

	function Dialog:Init(Window)
		Dialog.Window = Window
		return Dialog
	end

	function Dialog:Create()
		local NewDialog = {
			Buttons = 0,
		}

		NewDialog.TintFrame = New("TextButton", {
			Text = "",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			Parent = Dialog.Window.Root,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		})

		local TintMotor, TintTransparency = Creator.SpringMotor(1, NewDialog.TintFrame, "BackgroundTransparency", true)

		NewDialog.ButtonHolder = New("Frame", {
			Size = UDim2.new(1, -40, 1, -40),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		NewDialog.ButtonHolderFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 70),
			Position = UDim2.new(0, 0, 1, -70),
			ThemeTag = {
				BackgroundColor3 = "DialogHolder",
			},
		}, {
			New("Frame", {
				Size = UDim2.new(1, 0, 0, 1),
				ThemeTag = {
					BackgroundColor3 = "DialogHolderLine",
				},
			}),
			NewDialog.ButtonHolder,
		})

		NewDialog.Title = New("TextLabel", {
			FontFace = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.SemiBold,
				Enum.FontStyle.Normal
			),
			Text = "Dialog",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 22,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 22),
			Position = UDim2.fromOffset(20, 25),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			AutoLocalize = false,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewDialog.Scale = New("UIScale", {
			Scale = 1,
		})

		local ScaleMotor, Scale = Creator.SpringMotor(1.1, NewDialog.Scale, "Scale")

		NewDialog.Root = New("CanvasGroup", {
			Size = UDim2.fromOffset(300, 165),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			GroupTransparency = 1,
			Parent = NewDialog.TintFrame,
			ThemeTag = {
				BackgroundColor3 = "Dialog",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ThemeTag = {
					Color = "DialogBorder",
				},
			}),
			NewDialog.Scale,
			NewDialog.Title,
			NewDialog.ButtonHolderFrame,
		})

		local RootMotor, RootTransparency = Creator.SpringMotor(1, NewDialog.Root, "GroupTransparency")

		function NewDialog:Open()
			Library.DialogOpen = true
			NewDialog.Scale.Scale = 1.1
			TintTransparency(0.75)
			RootTransparency(0)
			Scale(1)
		end

		function NewDialog:Close()
			Library.DialogOpen = false
			TintTransparency(1)
			RootTransparency(1)
			Scale(1.1)
			NewDialog.Root.UIStroke:Destroy()
			task.wait(0.15)
			NewDialog.TintFrame:Destroy()
		end

		function NewDialog:Button(Title, Callback)
			NewDialog.Buttons = NewDialog.Buttons + 1
			Title = Title or "Button"
			Callback = Callback or function() end

			local Button = Components.Button("", NewDialog.ButtonHolder, true)
			Button.Title.Text = Title

			for _, Btn in next, NewDialog.ButtonHolder:GetChildren() do
				if Btn:IsA("TextButton") then
					Btn.Size =
						UDim2.new(1 / NewDialog.Buttons, -(((NewDialog.Buttons - 1) * 10) / NewDialog.Buttons), 0, 32)
				end
			end

			Creator.AddSignal(Button.Frame.MouseButton1Click, function()
				Library:SafeCallback(Callback)
				pcall(function()
					NewDialog:Close()
				end)
			end)

			return Button
		end

		return NewDialog
	end

	return Dialog
end)()
Components.Notification = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Notification = {}

	function Notification:Init(GUI)
		Notification.Holder = New("Frame", {
			Position = UDim2.new(1, -30, 1, -30),
			Size = UDim2.new(0, 310, 1, -30),
			AnchorPoint = Vector2.new(1, 1),
			BackgroundTransparency = 1,
			Parent = GUI,
		}, {
			New("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				Padding = UDim.new(0, 20),
			}),
		})
	end

	function Notification:New(Config)
		Config.Title = Config.Title or "Title"
		Config.Content = Config.Content or "Content"
		Config.SubContent = Config.SubContent or ""
		Config.Duration = Config.Duration or nil
		Config.Buttons = Config.Buttons or {}
		local NewNotification = {
			Closed = false,
		}

		--NewNotification.AcrylicPaint = Acrylic.AcrylicPaint()

		NewNotification.Title = New("TextLabel", {
			Position = UDim2.new(0, 14, 0, 17),
			Text = Config.Title,
			RichText = true,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextSize = 13,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, -12, 0, 12),
			TextWrapped = true,
			BackgroundTransparency = 1,
			AutoLocalize = false,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.ContentLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = Config.Content,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			AutoLocalize = false,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.SubContentLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = Config.SubContent,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			AutoLocalize = false,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		NewNotification.LabelHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(14, 40),
			Size = UDim2.new(1, -28, 0, 0),
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 3),
			}),
			NewNotification.ContentLabel,
			NewNotification.SubContentLabel,
		})

		NewNotification.CloseButton = New("TextButton", {
			Text = "",
			Position = UDim2.new(1, -14, 0, 13),
			Size = UDim2.fromOffset(20, 20),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
		}, {
			New("ImageLabel", {
				Image = Components.Close,
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			}),
		})

		NewNotification.Root = New("Frame", {
		    BackgroundTransparency = 0,
		    Size = UDim2.new(1, 0, 1, 0),
		    Position = UDim2.fromScale(1, 0),
		    ThemeTag = { BackgroundColor3 = "AcrylicMain" },
		}, {
		    New("UICorner", { CornerRadius = UDim.new(0, 8) }),
		    New("UIStroke", {
		        Transparency = 0.5,
		        ThemeTag = { Color = "AcrylicBorder" },
		    }),
		    NewNotification.Title,
		    NewNotification.CloseButton,
		    NewNotification.LabelHolder,
		})

		if Config.Content == "" then
			NewNotification.ContentLabel.Visible = false
		end

		if Config.SubContent == "" then
			NewNotification.SubContentLabel.Visible = false
		end

		NewNotification.Holder = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 200),
			Parent = Notification.Holder,
		}, {
			NewNotification.Root,
		})

		local RootMotor = Flipper.GroupMotor.new({
			Scale = 1,
			Offset = 60,
		})

		RootMotor:onStep(function(Values)
			NewNotification.Root.Position = UDim2.new(Values.Scale, Values.Offset, 0, 0)
		end)

		Creator.AddSignal(NewNotification.CloseButton.MouseButton1Click, function()
			NewNotification:Close()
		end)

		function NewNotification:Open()
			local ContentSize = NewNotification.LabelHolder.AbsoluteSize.Y
			NewNotification.Holder.Size = UDim2.new(1, 0, 0, 58 + ContentSize)

			RootMotor:setGoal({
				Scale = Spring(0, { frequency = 5 }),
				Offset = Spring(0, { frequency = 5 }),
			})
		end

		function NewNotification:Close()
			if not NewNotification.Closed then
				NewNotification.Closed = true
				task.spawn(function()
					RootMotor:setGoal({
						Scale = Spring(1, { frequency = 5 }),
						Offset = Spring(60, { frequency = 5 }),
					})
					task.wait(0.4)
					-- if Library.UseAcrylic then
					-- 	NewNotification.AcrylicPaint.Model:Destroy()
					-- end
					NewNotification.Holder:Destroy()
				end)
			end
		end

		NewNotification:Open()
		if Config.Duration then
			task.delay(Config.Duration, function()
				NewNotification:Close()
			end)
		end
		return NewNotification
	end

	return Notification
end)()
Components.Textbox = function(Parent, Acrylic)
	Acrylic = Acrylic or false
	local Textbox = {}

	Textbox.Input = New("TextBox", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromOffset(10, 0),
		ThemeTag = {
			TextColor3 = "Text",
			PlaceholderColor3 = "SubText",
		},
	})

	Textbox.Container = New("Frame", {
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Position = UDim2.new(0, 6, 0, 0),
		Size = UDim2.new(1, -12, 1, 0),
	}, {
		Textbox.Input,
	})

	Textbox.Indicator = New("Frame", {
		Size = UDim2.new(1, -4, 0, 1),
		Position = UDim2.new(0, 2, 1, 0),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = Acrylic and 0.5 or 0,
		ThemeTag = {
			BackgroundColor3 = Acrylic and "InputIndicator" or "DialogInputLine",
		},
	})

	Textbox.Frame = New("Frame", {
		Size = UDim2.new(0, 0, 0, 30),
		BackgroundTransparency = Acrylic and 0.9 or 0,
		Parent = Parent,
		ThemeTag = {
			BackgroundColor3 = Acrylic and "Input" or "DialogInput",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
		New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Transparency = Acrylic and 0.5 or 0.65,
			ThemeTag = {
				Color = Acrylic and "InElementBorder" or "DialogButtonBorder",
			},
		}),
		Textbox.Indicator,
		Textbox.Container,
	})

	local function Update()
		local PADDING = 2
		local Reveal = Textbox.Container.AbsoluteSize.X

		if not Textbox.Input:IsFocused() or Textbox.Input.TextBounds.X <= Reveal - 2 * PADDING then
			Textbox.Input.Position = UDim2.new(0, PADDING, 0, 0)
		else
			local Cursor = Textbox.Input.CursorPosition
			if Cursor ~= -1 then
				local subtext = string.sub(Textbox.Input.Text, 1, Cursor - 1)
				local width = TextService:GetTextSize(
					subtext,
					Textbox.Input.TextSize,
					Textbox.Input.Font,
					Vector2.new(math.huge, math.huge)
				).X

				local CurrentCursorPos = Textbox.Input.Position.X.Offset + width
				if CurrentCursorPos < PADDING then
					Textbox.Input.Position = UDim2.fromOffset(PADDING - width, 0)
				elseif CurrentCursorPos > Reveal - PADDING - 1 then
					Textbox.Input.Position = UDim2.fromOffset(Reveal - width - PADDING - 1, 0)
				end
			end
		end
	end

	task.spawn(Update)

	Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("Text"), Update)
	Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("CursorPosition"), Update)

	Creator.AddSignal(Textbox.Input.Focused, function()
		Update()
		Textbox.Indicator.Size = UDim2.new(1, -2, 0, 2)
		Textbox.Indicator.Position = UDim2.new(0, 1, 1, 0)
		Textbox.Indicator.BackgroundTransparency = 0
		Creator.OverrideTag(Textbox.Frame, { BackgroundColor3 = Acrylic and "InputFocused" or "DialogHolder" })
		Creator.OverrideTag(Textbox.Indicator, { BackgroundColor3 = "InputIndicatorFocus" })
	end)

	Creator.AddSignal(Textbox.Input.FocusLost, function()
		Update()
		Textbox.Indicator.Size = UDim2.new(1, -4, 0, 1)
		Textbox.Indicator.Position = UDim2.new(0, 2, 1, 0)
		Textbox.Indicator.BackgroundTransparency = 0.5
		Creator.OverrideTag(Textbox.Frame, { BackgroundColor3 = Acrylic and "Input" or "DialogInput" })
		Creator.OverrideTag(Textbox.Indicator, { BackgroundColor3 = Acrylic and "InputIndicator" or "DialogInputLine" })
	end)

	return Textbox
end
Components.TitleBar = function(Config)
	local TitleBar = {}

	local function BarButton(Icon, Pos, Parent, Callback)
		local Button = { Callback = Callback or function() end }

		Button.Frame = New("TextButton", {
			Size             = UDim2.new(0, 28, 1, -10),
			AnchorPoint      = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Parent           = Parent,
			Position         = Pos,
			Text             = "",
			ThemeTag         = { BackgroundColor3 = "Text" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 6) }),
			New("ImageLabel", {
				Image       = Icon,
				Size        = UDim2.fromOffset(14, 14),
				Position    = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Name        = "Icon",
				ThemeTag    = { ImageColor3 = "Text" },
			}),
		})

		local Motor, SetTransparency = Creator.SpringMotor(1, Button.Frame, "BackgroundTransparency")
		AddSignal(Button.Frame.MouseEnter,        function() SetTransparency(0.92) end)
		AddSignal(Button.Frame.MouseLeave,        function() SetTransparency(1, true) end)
		AddSignal(Button.Frame.MouseButton1Down,  function() SetTransparency(0.95) end)
		AddSignal(Button.Frame.MouseButton1Up,    function() SetTransparency(0.92) end)
		AddSignal(Button.Frame.MouseButton1Click, Button.Callback)

		Button.SetCallback = function(Func) Button.Callback = Func end
		return Button
	end

	-- ── TitleBar frame (height 40) ────────────────────────────
	TitleBar.Frame = New("Frame", {
		Size             = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		Parent           = Config.Parent,
	}, {
		-- ── Logo (20×20, vertically centered, left) ──────────
		New("ImageLabel", {
			Image            = "rbxassetid://115743955187199",
			Size             = UDim2.fromOffset(20, 20),
			AnchorPoint      = Vector2.new(0, 0.5),
			Position         = UDim2.new(0, 14, 0.5, 0),    -- 14px from left, vcenter
			BackgroundTransparency = 1,
		}, {
			New("UIAspectRatioConstraint", {
				AspectRatio = 1,
				AspectType  = Enum.AspectType.FitWithinMaxSize,
			}),
		}),

		-- ── Title text (vcenter, after logo) ─────────────────
		New("TextLabel", {
			RichText         = true,
			Text             = Config.Title,
			FontFace         = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.SemiBold,
				Enum.FontStyle.Normal
			),
			TextSize         = 13,
			TextXAlignment   = Enum.TextXAlignment.Left,
			TextYAlignment   = Enum.TextYAlignment.Center,
			-- ตำแหน่ง: logo 20px + gap 8px = offset 42
			Position         = UDim2.new(0, 42, 0, 0),
			Size             = UDim2.fromScale(0, 1),
			AutomaticSize    = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			AutoLocalize     = false,
			ThemeTag         = { TextColor3 = "Text" },
		}),

		-- ── Subtitle text (vcenter, after title) ─────────────
		-- เราคำนวณ offset ไม่ได้ตอน runtime เพราะ TextBounds
		-- ใช้ Frame ครอบแทน แล้วจัดใน UIListLayout แนวนอน
		New("Frame", {
			-- Frame นี้ใช้แค่จัด subtitle ให้อยู่หลัง title
			-- วางไว้ใน inner container ด้านล่าง
			Size             = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
		}),

		-- ── divider ───────────────────────────────────────────
		New("Frame", {
			BackgroundTransparency = 0.5,
			Size             = UDim2.new(1, 0, 0, 1),
			Position         = UDim2.new(0, 0, 1, 0),
			ThemeTag         = { BackgroundColor3 = "TitleBarLine" },
		}),

		-- ── Text row container (logo + title + subtitle inline) 
		-- ใช้ Frame + UIListLayout แทนที่จะวาง absolute
		-- (override frame ด้านบน — ใช้วิธีนี้แทน)
	})

	-- ── สร้าง text row ใหม่ใน TitleBar.Frame โดยใช้ UIListLayout ─
	-- ลบ children เดิมที่ไม่ใช้ออก แล้ว rebuild ด้วย approach นี้:
	--
	-- TitleBar.Frame structure จริง:
	--   [ImageLabel logo 20x20, vcenter absolute]
	--   [Frame textRow: UIListLayout horizontal, vcenter]
	--     [TextLabel title]
	--     [TextLabel subtitle dim]
	--   [Frame divider bottom]
	--   [BarButtons close/max/min]

	-- rebuild ด้วย clean approach
	TitleBar.Frame:ClearAllChildren()

	-- logo
	New("ImageLabel", {
		Image            = "rbxassetid://115743955187199",
		Size             = UDim2.fromOffset(20, 20),
		AnchorPoint      = Vector2.new(0, 0.5),
		Position         = UDim2.new(0, 14, 0.5, 0),
		BackgroundTransparency = 1,
		Parent           = TitleBar.Frame,
	}, {
		New("UIAspectRatioConstraint", {
			AspectRatio = 1,
			AspectType  = Enum.AspectType.FitWithinMaxSize,
		}),
	})

	-- text row (title + subtitle horizontal, vcenter)
	New("Frame", {
		AnchorPoint      = Vector2.new(0, 0.5),
		Position         = UDim2.new(0, 42, 0.5, 0),   -- logo 20 + gap 8 + left 14 = 42
		Size             = UDim2.new(1, -160, 0, 16),   -- ลบพื้นที่ปุ่ม 3 อัน
		BackgroundTransparency = 1,
		Parent           = TitleBar.Frame,
	}, {
		New("UIListLayout", {
			Padding           = UDim.new(0, 6),
			FillDirection     = Enum.FillDirection.Horizontal,
			SortOrder         = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
		New("TextLabel", {
			RichText         = true,
			Text             = Config.Title,
			FontFace         = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.SemiBold,
				Enum.FontStyle.Normal
			),
			TextSize         = 13,
			TextXAlignment   = Enum.TextXAlignment.Left,
			TextYAlignment   = Enum.TextYAlignment.Center,
			Size             = UDim2.fromScale(0, 1),
			AutomaticSize    = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			AutoLocalize     = false,
			LayoutOrder      = 1,
			ThemeTag         = { TextColor3 = "Text" },
		}),
		New("TextLabel", {
			RichText         = true,
			Text             = Config.SubTitle or "",
			TextTransparency = 0.5,
			FontFace         = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.SemiBold,
				Enum.FontStyle.Normal
			),
			TextSize         = 13,
			TextXAlignment   = Enum.TextXAlignment.Left,
			TextYAlignment   = Enum.TextYAlignment.Center,
			Size             = UDim2.fromScale(0, 1),
			AutomaticSize    = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			AutoLocalize     = false,
			LayoutOrder      = 2,
			ThemeTag         = { TextColor3 = "SubText" },
		}),
	})

	-- divider
	New("Frame", {
		BackgroundTransparency = 0.5,
		Size             = UDim2.new(1, 0, 0, 1),
		Position         = UDim2.new(0, 0, 1, 0),
		Parent           = TitleBar.Frame,
		ThemeTag         = { BackgroundColor3 = "TitleBarLine" },
	})

	-- window buttons
	TitleBar.CloseButton = BarButton(
		Components.Assets.Close,
		UDim2.new(1, -6, 0.5, 0),
		TitleBar.Frame,
		function()
			Library.Window:Dialog({
				Title   = "Close",
				Content = "Are you sure you want to unload the interface?",
				Buttons = {
					{ Title = "Yes", Callback = function() Library:Destroy() end },
					{ Title = "No" },
				},
			})
		end
	)
	TitleBar.MaxButton = BarButton(
		Components.Assets.Max,
		UDim2.new(1, -38, 0.5, 0),
		TitleBar.Frame,
		function() Config.Window.Maximize(not Config.Window.Maximized) end
	)
	TitleBar.MinButton = BarButton(
		Components.Assets.Min,
		UDim2.new(1, -70, 0.5, 0),
		TitleBar.Frame,
		function() Library.Window:Minimize() end
	)

	return TitleBar
end

Components.Window = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	return function(Config)
		local Window = {
			Minimized = false,
			Maximized = false,
			Size = Config.Size,
			CurrentPos = 0,
			TabWidth = 0,
			Position = UDim2.fromOffset(
				Camera.ViewportSize.X / 2 - Config.Size.X.Offset / 2,
				Camera.ViewportSize.Y / 2 - Config.Size.Y.Offset / 2
			),
		}

		local Dragging, DragInput, MousePos, StartPos = false
		local Resizing, ResizePos = false
		local MinimizeNotif = false

		--Window.AcrylicPaint = Acrylic.AcrylicPaint()
		Window.TabWidth = Config.TabWidth

		local Selector = New("Frame", {
			Size = UDim2.fromOffset(4, 0),
			BackgroundColor3 = Color3.fromRGB(76, 194, 255),
			Position = UDim2.fromOffset(0, 17),
			AnchorPoint = Vector2.new(0, 0.5),
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 2),
			}),
		})

		local OFFSETY = 120

		local ResizeStartFrame = New("Frame", {
			Size = UDim2.fromOffset(20, 20),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -20, 1, -20),
		})

		Window.TabHolder = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ScrollBarImageTransparency = 1,
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 4),
			}),
		})

		local Icon = New("TextButton", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0, Window.TabWidth, 0, Window.TabWidth),
			Position = UDim2.new(0, 12, 0, (Window.TabWidth/4)- 20),
			BorderSizePixel = 0
		}, {
			New("UIPadding", {
				PaddingBottom = UDim.new(0, 2),
				PaddingLeft = UDim.new(0, 2),
				PaddingRight = UDim.new(0, 2),
				PaddingTop = UDim.new(0, 2),
			}),
			New("ImageLabel", {
				Image = "rbxassetid://115743955187199",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
			}, {
				New("UIAspectRatioConstraint", {
					AspectRatio = 1,
					AspectType = Enum.AspectType.FitWithinMaxSize,
				})
			})
		})

		local OFFSETY = 0  -- tab list เริ่มใต้ titlebar ทันที

		-- ── Search bar toggle (Config.SearchBar) ──────────────
		local UseSearchBar = Config.SearchBar and true or false

		-- ── Search box (tren cung phan hien thi tab) ──────────
		local SearchIcon = New("ImageLabel", {
			Image       = "rbxassetid://10734943674",
			Size        = UDim2.fromOffset(14, 14),
			AnchorPoint = Vector2.new(0, 0.5),
			Position    = UDim2.new(0, 9, 0.5, 0),
			BackgroundTransparency = 1,
			ThemeTag    = { ImageColor3 = "SubText" },
		})

		local SearchInput = New("TextBox", {
			FontFace         = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text             = "",
			PlaceholderText  = "Search...",
			TextSize         = 12,
			TextXAlignment   = Enum.TextXAlignment.Left,
			TextYAlignment   = Enum.TextYAlignment.Center,
			BackgroundTransparency = 1,
			Size             = UDim2.new(1, -36, 1, 0),
			Position         = UDim2.new(0, 30, 0, 0),
			ClearTextOnFocus = false,
			TextTruncate     = Enum.TextTruncate.AtEnd,
			AutoLocalize     = false,
			ThemeTag         = { TextColor3 = "Text", PlaceholderColor3 = "SubText" },
		})

		local SearchStroke = New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Transparency    = 0.5,
			ThemeTag        = { Color = "InElementBorder" },
		})

		local SearchBox = New("Frame", {
			Size     = UDim2.new(0, Window.TabWidth, 0, 30),
			Position = UDim2.new(0, 12, 0, 52),
			BackgroundTransparency = 0.9,
			Visible  = UseSearchBar,
			ThemeTag = { BackgroundColor3 = "Input" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 8) }),
			SearchStroke,
			SearchIcon,
			SearchInput,
		})

		-- focus effect: sang stroke khi dang go
		Creator.AddSignal(SearchInput.Focused, function()
			TweenService:Create(SearchStroke,
				TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ Transparency = 0.1 }
			):Play()
		end)
		Creator.AddSignal(SearchInput.FocusLost, function()
			TweenService:Create(SearchStroke,
				TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ Transparency = 0.5 }
			):Play()
		end)

		-- ── Search: gom ket qua tu TAT CA cac tab vao 1 khung ──
		local SearchLayout = New("UIListLayout", {
			Padding   = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		local SearchResults = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Visible = false,
			ZIndex = 5,
			BottomImage = "rbxassetid://6889812791",
			MidImage = "rbxassetid://6889812721",
			TopImage = "rbxassetid://6276641225",
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.95,
			ScrollBarThickness = 3,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			SearchLayout,
			New("UIPadding", {
				PaddingRight  = UDim.new(0, 10),
				PaddingLeft   = UDim.new(0, 1),
				PaddingTop    = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
			}),
		})

		Creator.AddSignal(SearchLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			SearchResults.CanvasSize = UDim2.new(0, 0, 0, SearchLayout.AbsoluteContentSize.Y + 2)
		end)

		-- Danh sach element dang bi "muon" sang khung ket qua
		local MovedElements = {}

		local function ElementMatches(frame, q)
			for _, d in ipairs(frame:GetDescendants()) do
				if d:IsA("TextLabel") and d.Text ~= "" and d.Text:lower():find(q, 1, true) then
					return true
				end
			end
			return false
		end

		-- Tra cac element ve dung tab/section cu.
		-- Dung ElementHomes (ghi luc tao) thay vi parent tam thoi -> khong bao gio
		-- bi xao tron du search nhieu lan hay doi tab giua chung.
		local function RestoreElements()
			local Moved = MovedElements
			MovedElements = {}

			for _, Element in ipairs(Moved) do
				if Element and Element.Parent then
					RestoreHome(Element)
				end
			end

			-- quet them: bat ky element nao con sot lai trong khung ket qua
			for _, Child in ipairs(SearchResults:GetChildren()) do
				if Child:IsA("TextButton") then
					RestoreHome(Child)
				end
			end
		end

		-- tim element khop trong container (ke ca trong Section) va don vao SearchResults
		local function CollectMatches(container, q, order)
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("TextButton") then
					if ElementMatches(child, q) then
						-- dam bao co "nha" de tra ve (element tao truoc ban va nay)
						if not ElementHomes[child] then
							RememberHome(child, child.Parent, child.LayoutOrder)
						end

						table.insert(MovedElements, child)
						child.LayoutOrder = order.n
						order.n = order.n + 1
						child.Parent = SearchResults
					end
				elseif child:IsA("Frame") then
					CollectMatches(child, q, order)
				end
			end
		end

		-- dung de xoa search khi nguoi dung bam sang tab khac
		Window.ClearSearch = function()
			if SearchInput.Text ~= "" then
				SearchInput.Text = "" -- kich hoat handler ben duoi -> tu restore
			else
				RestoreElements()
				SearchResults.Visible = false
			end
		end

		Creator.AddSignal(SearchInput:GetPropertyChangedSignal("Text"), function()
			local q = SearchInput.Text:lower()

			-- luon tra element ve cho cu truoc khi loc lai
			RestoreElements()

			if q == "" then
				SearchResults.Visible = false
				-- hien lai tat ca nut tab + container cua tab dang chon
				for _, Tab in next, Components.Tab.Tabs do
					if Tab.Frame then Tab.Frame.Visible = true end
				end
				for _, Container in next, Components.Tab.Containers do
					Container.Visible = false
				end
				local Sel = Components.Tab.Containers[Components.Tab.SelectedTab]
				if Sel then Sel.Visible = true end
				return
			end

			-- parent lazy vi ContainerCanvas duoc tao sau doan code nay
			if not SearchResults.Parent and Window.ContainerCanvas then
				SearchResults.Parent = Window.ContainerCanvas
			end

			-- an het container cac tab, chi hien khung ket qua
			for _, Container in next, Components.Tab.Containers do
				Container.Visible = false
			end

			-- gom element khop tu TAT CA cac tab
			local order = { n = 1 }
			for _, Tab in next, Components.Tab.Tabs do
				local before = #MovedElements
				if Tab.ContainerFrame then
					CollectMatches(Tab.ContainerFrame, q, order)
				end
				local hasMatch = #MovedElements > before
				local nameMatch = Tab.Name
					and tostring(Tab.Name):lower():find(q, 1, true) ~= nil
				if Tab.Frame then
					Tab.Frame.Visible = hasMatch or nameMatch or false
				end
			end

			SearchResults.Visible = true
		end)

		local TabFrame = New("Frame", {
			Size             = UDim2.new(0, Window.TabWidth, 1, UseSearchBar and -104 or -64),
			Position         = UDim2.new(0, 12, 0, UseSearchBar and 92 or 52),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		}, {
			Window.TabHolder,
			Selector,
		})

		-- ── API bật/tắt search bar ────────────────────────────
		function Window:SetSearchBar(Value)
			UseSearchBar = Value and true or false
			SearchBox.Visible = UseSearchBar
			if not UseSearchBar then
				-- reset filter khi tắt
				SearchInput.Text = ""
			end
			TabFrame.Size     = UDim2.new(0, Window.TabWidth, 1, UseSearchBar and -104 or -64)
			TabFrame.Position = UDim2.new(0, 12, 0, UseSearchBar and 92 or 52)
		end

		Window.TabDisplay = New("TextLabel", {
			RichText         = true,
			Text             = "Tab",
			TextTransparency = 0,
			FontFace         = Font.new("rbxassetid://12187365364",
			                   Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize         = 22,
			TextXAlignment   = Enum.TextXAlignment.Left,
			TextYAlignment   = Enum.TextYAlignment.Center,
			Size             = UDim2.new(1, -16, 0, 22),
			Position         = UDim2.fromOffset(Window.TabWidth + 26, 56),
			BackgroundTransparency = 1,
			AutoLocalize     = false,
			ThemeTag         = { TextColor3 = "Text" },
		})

		Window.ContainerHolder = New("Frame", {
			Size             = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		})

		Window.ContainerAnim = New("CanvasGroup", {
			Size             = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		})

		Window.ContainerCanvas = New("Frame", {
			Size             = UDim2.new(1, -Window.TabWidth - 32, 1, -102),
			Position         = UDim2.fromOffset(Window.TabWidth + 26, 90),
			BackgroundTransparency = 1,
		}, {
			Window.ContainerAnim,
			Window.ContainerHolder,
		})

		local AcrylicFrame = New("Frame", {
		    Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 0.12,										
		    ThemeTag = { BackgroundColor3 = "AcrylicMain" },
		}, {
		    New("UICorner", { CornerRadius = UDim.new(0, 8) }),
		})
		
		Window.AcrylicPaint = {
		    Frame = AcrylicFrame,
		    Model = nil,
		    AddParent = function() end,
		    SetVisibility = function() end,
		}
		
		Window.Root = New("Frame", {
		    BackgroundTransparency = 1,
		    Size = Window.Size,
		    Position = Window.Position,
		    Parent = Config.Parent,
		}, {
		    AcrylicFrame,   -- ใช้ตัวแปร แทน Window.AcrylicPaint.Frame
		    Window.TabDisplay,
		    Window.ContainerCanvas,
		    SearchBox,
		    TabFrame,
		    ResizeStartFrame,
		})

		Window.TitleBar = Components.TitleBar({
			Title = Config.Title,
			SubTitle = Config.SubTitle,
			Parent = Window.Root,
			Window = Window,
		})

		if Library.UseAcrylic then
			Window.AcrylicPaint.AddParent(Window.Root)
		end

		local SizeMotor = Flipper.GroupMotor.new({
			X = Window.Size.X.Offset,
			Y = Window.Size.Y.Offset,
		})

		local PosMotor = Flipper.GroupMotor.new({
			X = Window.Position.X.Offset,
			Y = Window.Position.Y.Offset,
		})

		Window.SelectorPosMotor = Flipper.SingleMotor.new(17)
		Window.SelectorSizeMotor = Flipper.SingleMotor.new(0)
		Window.ContainerBackMotor = Flipper.SingleMotor.new(0)
		Window.ContainerPosMotor = Flipper.SingleMotor.new(94)

		SizeMotor:onStep(function(values)
			Window.Root.Size = UDim2.new(0, values.X, 0, values.Y)
		end)

		PosMotor:onStep(function(values)
			Window.Root.Position = UDim2.new(0, values.X, 0, values.Y)
		end)

		local LastValue = 0
		local LastTime = 0
		Window.SelectorPosMotor:onStep(function(Value)
			Selector.Position = UDim2.new(0, 0, 0, Value + 17)
			local Now = tick()
			local DeltaTime = Now - LastTime

			if LastValue ~= nil then
				Window.SelectorSizeMotor:setGoal(Spring((math.abs(Value - LastValue) / (DeltaTime * 60)) + 16))
				LastValue = Value
			end
			LastTime = Now
		end)

		Window.SelectorSizeMotor:onStep(function(Value)
			Selector.Size = UDim2.new(0, 4, 0, Value)
		end)

		Window.ContainerBackMotor:onStep(function(Value)
			Window.ContainerAnim.GroupTransparency = Value
		end)

		Window.ContainerPosMotor:onStep(function(Value)
			Window.ContainerAnim.Position = UDim2.fromOffset(0, Value)
		end)

		local OldSizeX
		local OldSizeY
		Window.Maximize = function(Value, NoPos, Instant)
			Window.Maximized = Value
			Window.TitleBar.MaxButton.Frame.Icon.Image = Value and Components.Assets.Restore or Components.Assets.Max

			if Value then
				OldSizeX = Window.Size.X.Offset
				OldSizeY = Window.Size.Y.Offset
			end
			local SizeX = Value and Camera.ViewportSize.X or OldSizeX
			local SizeY = Value and Camera.ViewportSize.Y or OldSizeY
			SizeMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(SizeX, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(SizeY, { frequency = 6 }),
			})
			Window.Size = UDim2.fromOffset(SizeX, SizeY)

			if not NoPos then
				PosMotor:setGoal({
					X = Spring(Value and 0 or Window.Position.X.Offset, { frequency = 6 }),
					Y = Spring(Value and 0 or Window.Position.Y.Offset, { frequency = 6 }),
				})
			end
		end

		Creator.AddSignal(Window.TitleBar.Frame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				MousePos = Input.Position
				StartPos = Window.Root.Position

				if Window.Maximized then
					StartPos = UDim2.fromOffset(
						Mouse.X - (Mouse.X * ((OldSizeX - 100) / Window.Root.AbsoluteSize.X)),
						Mouse.Y - (Mouse.Y * (OldSizeY / Window.Root.AbsoluteSize.Y))
					)
				end

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		Creator.AddSignal(Window.TitleBar.Frame.InputChanged, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseMovement
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = Input
			end
		end)

		Creator.AddSignal(ResizeStartFrame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Resizing = true
				ResizePos = Input.Position
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				Window.Position = UDim2.fromOffset(StartPos.X.Offset + Delta.X, StartPos.Y.Offset + Delta.Y)
				PosMotor:setGoal({
					X = Instant(Window.Position.X.Offset),
					Y = Instant(Window.Position.Y.Offset),
				})

				if Window.Maximized then
					Window.Maximize(false, true, true)
				end
			end

			if
				(Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)
				and Resizing
			then
				local Delta = Input.Position - ResizePos
				local StartSize = Window.Size

				local TargetSize = Vector3.new(StartSize.X.Offset, StartSize.Y.Offset, 0) + Vector3.new(1, 1, 0) * Delta
				local TargetSizeClamped =
					Vector2.new(math.clamp(TargetSize.X, 470, 2048), math.clamp(TargetSize.Y, 380, 2048))

				SizeMotor:setGoal({
					X = Flipper.Instant.new(TargetSizeClamped.X),
					Y = Flipper.Instant.new(TargetSizeClamped.Y),
				})
			end
		end)

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if Resizing == true or Input.UserInputType == Enum.UserInputType.Touch then
				Resizing = false
				Window.Size = UDim2.fromOffset(SizeMotor:getValue().X, SizeMotor:getValue().Y)
			end
		end)

		Creator.AddSignal(Window.TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Window.TabHolder.CanvasSize = UDim2.new(0, 0, 0, Window.TabHolder.UIListLayout.AbsoluteContentSize.Y)
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if
				type(Library.MinimizeKeybind) == "table"
				and Library.MinimizeKeybind.Type == "Keybind"
				and not UserInputService:GetFocusedTextBox()
			then
				if Input.KeyCode.Name == Library.MinimizeKeybind.Value then
					Window:Minimize()
				end
			elseif Input.KeyCode == Library.MinimizeKey and not UserInputService:GetFocusedTextBox() then
				Window:Minimize()
			end
		end)

		function Window:ToggleInterface()
			Window.Minimized = not Window.Minimized
			Window.Root.Visible = not Window.Minimized
		end

		function Window:Minimize()
			Window.Minimized = not Window.Minimized
			Window.Root.Visible = not Window.Minimized
			if not MinimizeNotif then
				MinimizeNotif = true
				local Key = Library.MinimizeKeybind and Library.MinimizeKeybind.Value or Library.MinimizeKey.Name
				Library:Notify({
					Title = "Interface",
					Content = "Press " .. Key .. " to toggle the interface.",
					Duration = 6
				})
			end
			--pcall(SwapIco)
		end

		function Window:Destroy()
			-- if Library.UseAcrylic then
			-- 	Window.AcrylicPaint.Model:Destroy()
			-- end
			Window.Root:Destroy()
		end

		local DialogModule = Components.Dialog:Init(Window)
		function Window:Dialog(Config)
			local Dialog = DialogModule:Create()
			Dialog.Title.Text = Config.Title

			local Content = New("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				Text = Config.Content,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				Size = UDim2.new(1, -40, 1, 0),
				Position = UDim2.fromOffset(20, 60),
				BackgroundTransparency = 1,
				Parent = Dialog.Root,
				ClipsDescendants = false,
				AutoLocalize = false,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})

			New("UISizeConstraint", {
				MinSize = Vector2.new(300, 165),
				MaxSize = Vector2.new(620, math.huge),
				Parent = Dialog.Root,
			})

			Dialog.Root.Size = UDim2.fromOffset(Content.TextBounds.X + 40, 165)
			if Content.TextBounds.X + 40 > Window.Size.X.Offset - 120 then
				Dialog.Root.Size = UDim2.fromOffset(Window.Size.X.Offset - 120, 165)
				Content.TextWrapped = true
				Dialog.Root.Size = UDim2.fromOffset(Window.Size.X.Offset - 120, Content.TextBounds.Y + 150)
			end

			for _, Button in next, Config.Buttons do
				Dialog:Button(Button.Title, Button.Callback)
			end

			Dialog:Open()
		end

		local TabModule = Components.Tab:Init(Window)
		function Window:AddTab(TabConfig)
			return TabModule:New(TabConfig.Title, TabConfig.Icon, Window.TabHolder)
		end

		function Window:GetCurrentTab()
			return TabModule:GetCurrentTab()
		end

		function Window:TabChanged(func)
			TabModule.Callback = func
		end

		function Window:SelectTab(Tab)
			TabModule:SelectTab(Tab)
		end

		Creator.AddSignal(Window.TabHolder:GetPropertyChangedSignal("CanvasPosition"), function()
			LastValue = TabModule:GetCurrentTabPos() + 16
			LastTime = 0
			Window.SelectorPosMotor:setGoal(Instant(TabModule:GetCurrentTabPos()))
		end)

		return Window
	end
end)()

local ElementsTable = {}

ElementsTable.Button = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Button"

	function Element:New(Config)
		assert(Config.Title, "Button - Missing Title")
		Config.Callback = Config.Callback or function() end

		local ButtonFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)

		local ButtonIco = New("ImageLabel", {
			Image = "rbxassetid://10734898476",
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			BackgroundTransparency = 1,
			Parent = ButtonFrame.Frame,
			ThemeTag = {
				ImageColor3 = "Text",
			},
		})

		Creator.AddSignal(ButtonFrame.Frame.MouseButton1Click, function()
			Library:SafeCallback(Config.Callback)
		end)
		return ButtonFrame
	end

	return Element
end)()
ElementsTable.Toggle = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Toggle"

	function Element:New(Idx, Config)
		assert(Config.Title, "Toggle - Missing Title")

		local Toggle = {
			OriginalTitle  = Config.Title,
			OriginalDesc   = Config.Description,
			Value          = Config.Default or false,
			Callback       = Config.Callback or function(Value) end,
			Type           = "Toggle",
		}

		local ToggleFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)
		ToggleFrame.DescLabel.Size = UDim2.new(1, -54, 0, 14)

		Toggle.SetTitle        = ToggleFrame.SetTitle
		Toggle.AddText         = ToggleFrame.AddText
		Toggle.SetDesc         = ToggleFrame.SetDesc
		Toggle.Visible         = ToggleFrame.Visible
		Toggle.GetOriginalText = ToggleFrame.GetOriginalText
		Toggle.Elements        = ToggleFrame

		-- ── Track (pill) ──────────────────────────────────────
		local Track = New("Frame", {
			Size             = UDim2.fromOffset(44, 24),
			AnchorPoint      = Vector2.new(1, 0.5),
			Position         = UDim2.new(1, -10, 0.5, 0),
			BackgroundColor3 = Color3.fromRGB(60, 60, 60),
			Parent           = ToggleFrame.Frame,
			ThemeTag         = { BackgroundColor3 = "Element" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			New("UIStroke", {
				Transparency    = 0.6,
				Thickness       = 1,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag        = { Color = "InElementBorder" },
			}),
		})

		-- ── Accent fill (clipped inside track) ───────────────
		local Fill = New("Frame", {
			Size             = UDim2.new(0, 0, 1, 0),   -- starts empty
			BackgroundColor3 = Color3.fromRGB(96, 205, 255),
			ThemeTag         = { BackgroundColor3 = "Accent" },
			Parent           = Track,
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})

		-- ── Thumb ─────────────────────────────────────────────
		local Thumb = New("Frame", {
			Size             = UDim2.fromOffset(16, 16),
			AnchorPoint      = Vector2.new(0, 0.5),
			Position         = UDim2.new(0, 3, 0.5, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			ZIndex           = 3,
			Parent           = Track,
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})

		-- ── Easing helpers ────────────────────────────────────
		local TI_FAST  = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local TI_BACK  = TweenInfo.new(0.20, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)
		local TI_QUICK = TweenInfo.new(0.10, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

		-- OFF state
		local function applyOff()
			TweenService:Create(Fill,  TI_FAST, { Size     = UDim2.new(0, 0, 1, 0)   }):Play()
			TweenService:Create(Thumb, TI_BACK, { Position = UDim2.new(0, 3, 0.5, 0) }):Play()
		end

		-- ON state
		local function applyOn()
			TweenService:Create(Fill,  TI_FAST, { Size     = UDim2.fromScale(1, 1)    }):Play()
			TweenService:Create(Thumb, TI_BACK, { Position = UDim2.new(0, 23, 0.5, 0)}):Play()
		end

		-- Press squish
		Creator.AddSignal(ToggleFrame.Frame.MouseButton1Down, function()
			TweenService:Create(Thumb, TI_QUICK, {
				Size = UDim2.fromOffset(Toggle.Value and 14 or 18, 16),
			}):Play()
		end)
		Creator.AddSignal(ToggleFrame.Frame.MouseButton1Up, function()
			TweenService:Create(Thumb, TI_BACK, {
				Size = UDim2.fromOffset(16, 16),
			}):Play()
		end)

		-- ── Public API ────────────────────────────────────────
		function Toggle:OnChanged(Func)
			Toggle.Changed = Func
			Func(Toggle.Value)
		end

		function Toggle:SetValue(Value)
			Value = not not Value
			Toggle.Value = Value

			if Value then applyOn() else applyOff() end

			Library:SafeCallbackToggles(Config.Title, Toggle.Callback, Toggle.Value)
			Library:SafeCallbackToggles(Config.Title, Toggle.Changed,  Toggle.Value)
		end

		function Toggle:GetValue()
			return self.Value
		end

		function Toggle:Destroy()
			ToggleFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ToggleFrame.Frame.MouseButton1Click, function()
			Toggle:SetValue(not Toggle.Value)
		end)

		Toggle:SetValue(Toggle.Value)

		Library.Options[Idx] = Toggle
		return Toggle
	end

	return Element
end)()
ElementsTable.Dropdown = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Dropdown"

	function Element:New(Idx, Config)

		local Dropdown = {
			Values = Config.Values,
			Value = Config.Default,
			Multi = Config.Multi,
			Buttons = {},
			Opened = false,
			Type = "Dropdown",
			Callback = Config.Callback or function() end,
			Searchable = Config.Searchable or false,
			-- Lazy loading properties
			LoadedItems = 0,
			-- Set cac index da duoc tao button. Truoc day chi dem so luong
			-- (LoadedItems) roi gia dinh da load lien tuc tu index 1, nen khi
			-- LoadRequiredItems load 1 khoang o giua (vd 11..21) thi batch sau
			-- lai load lai tu 12 -> item bi lap 2 lan.
			LoadedIndices = {},
			-- Con tro index tiep theo can quet khi load batch
			NextLoadIndex = 1,
			BatchSize = 20, -- จำนวน items ที่โหลดต่อครั้ง
			IsLoadingBatch = false
		}

		if Dropdown.Multi and Config.AllowNull then
			Dropdown.Value = {}
		end

		local DropdownFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config)
		DropdownFrame.DescLabel.Size = UDim2.new(1, -170, 0, 14)

		Dropdown.SetTitle = DropdownFrame.SetTitle
		Dropdown.SetDesc = DropdownFrame.SetDesc
		Dropdown.Visible = DropdownFrame.Visible
		Dropdown.Elements = DropdownFrame

				local DropdownDisplay = New("TextBox", {
			FontFace        = Font.new("rbxasset://fonts/families/GothamSSm.json",
			                           Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text            = "",
			PlaceholderText = "...",
			PlaceholderColor3 = Color3.fromRGB(200, 200, 200),
			TextColor3      = Color3.fromRGB(240, 240, 240),
			TextSize        = 13,
			AutomaticSize   = Enum.AutomaticSize.Y,
			TextYAlignment  = Enum.TextYAlignment.Center,
			TextXAlignment  = Enum.TextXAlignment.Left,
			Size            = UDim2.new(1, Dropdown.Multi and -26 or -20, 0.5, 0),
			Position        = UDim2.new(0, 6, 0.5, 0),
			AnchorPoint     = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			TextTruncate    = Enum.TextTruncate.AtEnd,
			Interactable    = false,
			AutoLocalize    = false,
			ThemeTag        = { TextColor3 = "Text", PlaceholderColor3 = "SubText" },
		})

		-- chevron icon (right side)
		local DropdownIco = New("ImageLabel", {
			Image           = "rbxassetid://10709790948",
			Size            = UDim2.fromOffset(14, 14),
			AnchorPoint     = Vector2.new(1, 0.5),
			Position        = UDim2.new(1, -4, 0.5, 0),
			BackgroundTransparency = 1,
			Rotation        = 90,
			ThemeTag        = { ImageColor3 = "SubText" },
		})

		-- underline (bottom border only — no box)
		local DropdownUnderline = New("Frame", {
			Size            = UDim2.new(1, 0, 0, 1),
			AnchorPoint     = Vector2.new(0, 1),
			Position        = UDim2.new(0, 0, 1, 0),
			BackgroundTransparency = 0.5,
			ThemeTag        = { BackgroundColor3 = "InElementBorder" },
		})

		local DropdownInner = New("TextButton", {
			Size            = UDim2.fromOffset(160, 28),
			Position        = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint     = Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent          = DropdownFrame.Frame,
			AutoLocalize    = false,
			ThemeTag        = { BackgroundColor3 = "DropdownFrame" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 10) }),
			DropdownIco,
			DropdownDisplay,
		})

		-- focus/open: underline brightens
		local TI_UL = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		Creator.AddSignal(DropdownInner.MouseEnter, function()
			TweenService:Create(DropdownUnderline, TI_UL, { BackgroundTransparency = 0.2 }):Play()
		end)
		Creator.AddSignal(DropdownInner.MouseLeave, function()
			TweenService:Create(DropdownUnderline, TI_UL, {
				BackgroundTransparency = Dropdown.Opened and 0 or 0.5
			}):Play()
		end)

		-- เพิ่ม hover effect สำหรับ dropdown
		local DropdownHoverMotor, SetDropdownHover = Creator.SpringMotor(0.9, DropdownInner, "BackgroundTransparency")
		Creator.AddSignal(DropdownInner.MouseEnter, function()
			SetDropdownHover(0.8)
		end)
		Creator.AddSignal(DropdownInner.MouseLeave, function()
			SetDropdownHover(0.9)
		end)

		-- เพิ่ม hover effect สำหรับ clear button
		if ClearButton then
			local ClearHoverMotor, SetClearHover = Creator.SpringMotor(0.15, ClearButton, "BackgroundTransparency")
			Creator.AddSignal(ClearButton.MouseEnter, function()
				SetClearHover(0.05)
				-- เพิ่ม scale effect
				TweenService:Create(ClearButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
					Size = UDim2.fromOffset(32, 32)
				}):Play()
			end)
			Creator.AddSignal(ClearButton.MouseLeave, function()
				SetClearHover(0.15)
				-- คืนขนาดเดิม
				TweenService:Create(ClearButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
					Size = UDim2.fromOffset(30, 30)
				}):Play()
			end)
			Creator.AddSignal(ClearButton.MouseButton1Down, function()
				SetClearHover(0.0)
				-- เพิ่ม press effect
				TweenService:Create(ClearButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
					Size = UDim2.fromOffset(28, 28)
				}):Play()
			end)
			Creator.AddSignal(ClearButton.MouseButton1Up, function()
				SetClearHover(0.05)
				TweenService:Create(ClearButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
					Size = UDim2.fromOffset(32, 32)
				}):Play()
			end)

			-- ฟังก์ชันล้างค่าทั้งหมด
			Creator.AddSignal(ClearButton.MouseButton1Click, function()
				if Dropdown.Multi then
					Dropdown.Value = {}
					for _, Button in next, Dropdown.Buttons do
						Button:UpdateButton()
					end
					Dropdown:Display()
					-- ปิด dropdown หลังล้างค่า
					Dropdown:Close()
					Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
					Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
				end
			end)
		end

		local DropdownListLayout = New("UIListLayout", {
			Padding = UDim.new(0, 10), -- เพิ่ม padding
		})

		local DropdownScrollFrame = New("ScrollingFrame", {
			Size = UDim2.new(1, -8, 1, -12), -- ปรับขนาด
			Position = UDim2.fromOffset(6, 6), -- ปรับตำแหน่ง
			BackgroundTransparency = 1,
			BottomImage = "rbxassetid://6889812791",
			MidImage = "rbxassetid://6889812721",
			TopImage = "rbxassetid://6276641225",
			ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120),
			ScrollBarImageTransparency = 0.6,
			ScrollBarThickness = 6,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			DropdownListLayout,
		})

		local DropdownHolderFrame = New("Frame", {
		    Size             = UDim2.fromScale(1, 0.6),
		    ThemeTag         = { BackgroundColor3 = "DropdownHolder" },
		}, {
		    New("UICorner", {
		        CornerRadius = UDim.new(0, 20),
		    }),
		    New("UIStroke", {
		        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		        Transparency    = 0.5,
		        ThemeTag        = { Color = "InElementBorder" },
		    }),
		    DropdownScrollFrame,
		})

		local DropdownHolderCanvas = New("Frame", {
		    BackgroundTransparency = 1,
		    Size             = UDim2.fromOffset(170, 300),
		    Parent           = Library.GUI,
		    Visible          = false,
		}, {
			DropdownHolderFrame,
			New("UISizeConstraint", {
				MinSize = Vector2.new(170, 0),
			}),
		})

		-- Loading indicator frame with better styling
		local LoadingIndicator = New("Frame", {
			Size = UDim2.new(1, -5, 0, 35),
			BackgroundColor3 = Color3.fromRGB(50, 50, 60),
			BackgroundTransparency = 0.7,
			Parent = DropdownScrollFrame,
			Name = "LoadingIndicator",
			Visible = false,
		}, {
			New("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				Text = "📦 Loading more items...",
				TextColor3 = Color3.fromRGB(150, 150, 150),
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Center,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				AutoLocalize = false,
			}),
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		})
 
		-- SEARCHABLE BOX with enhanced styling --

		local Border = New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(100, 100, 120),
			Transparency = 0.3,
			Thickness = 1.5,
			ThemeTag = {
				Color = "ElementBorder",
			},
		})

		local searchIcon = New("ImageLabel", {
			Image = "rbxassetid://10734943674",
			Size = UDim2.fromOffset(18, 18),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 8, 0.5, 0),
			BackgroundTransparency = 1,
			Rotation = 0,
			ThemeTag = {
				ImageColor3 = "SubText",
			},
		})

		local SearchBase = New("Frame", {
			Visible = false,
			Size = UDim2.new(0, 170, 0, 35), -- เพิ่มความสูง
			Parent = Library.GUI,
			AutomaticSize = Enum.AutomaticSize.Y,
			ThemeTag = {
				BackgroundColor3 = "DropdownHolder",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8), -- เพิ่มขนาด corner
			}),
			searchIcon,
			Border,
		})

		-- เพิ่ม gradient effect สำหรับ search box
		local SearchGradient = New("UIGradient", {
			Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1.0, Color3.fromRGB(240, 240, 250))
			},
			Rotation = 45,
			Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0.0, 0.95),
				NumberSequenceKeypoint.new(1.0, 0.98)
			},
			Parent = SearchBase,
		})

        local DropdownSearch = New("TextBox", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = "",
			PlaceholderText = "Search...",
			PlaceholderColor3 = Color3.fromRGB(180, 180, 190),
            Parent = SearchBase,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -30, 1, -4),
			Position = UDim2.new(0, 30, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			LayoutOrder = 7,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Interactable = true,
			AutoLocalize = false,
			ThemeTag = {
				TextColor3 = "Text",
				PlaceholderColor3 = "SubText"
			},
		})

		-- เพิ่ม focus effect สำหรับ search box
		local SearchFocusMotor, SetSearchFocus = Creator.SpringMotor(0.3, Border, "Transparency")
		Creator.AddSignal(DropdownSearch.Focused, function()
			SetSearchFocus(0.1)
		end)
		Creator.AddSignal(DropdownSearch.FocusLost, function()
			SetSearchFocus(0.3)
		end)

		table.insert(Library.OpenFrames, DropdownHolderCanvas)

        local XADD = 195
        local DEFAULT_Y_OFFSET_WITH_OBJ = -5
        local DEFAULT_Y_OFFSET_WITHOUT_OBJ = 18
        local MAX_DROPDOWN_ITEMS = 5

        local MoveList = {
            { Instance = DropdownHolderCanvas, YOffset = 35}, -- no custom offset
            { Instance = SearchBase, YOffset = 0 }, -- custom Y offset
            { Instance = ClearButton, YOffset = 0, XOffset = 175 }, -- Clear button ข้างๆ search
        }

        local function RecalculateListPosition()
            local Add = 0
            local availableSpace = Camera.ViewportSize.Y - DropdownInner.AbsolutePosition.Y
            local neededSpace = DropdownHolderCanvas.AbsoluteSize.Y - 5

            if availableSpace < neededSpace then
                Add = neededSpace - availableSpace + 40
            end

            local defaultYOffset = (DEFAULT_Y_OFFSET_WITH_OBJ - Add) or DEFAULT_Y_OFFSET_WITHOUT_OBJ
            local baseX = DropdownInner.AbsolutePosition.X - 1 + XADD
            local baseY = DropdownInner.AbsolutePosition.Y + defaultYOffset

            for _, entry in ipairs(MoveList) do
                local inst = entry.Instance
                if inst then -- เช็คว่า instance มีอยู่จริง
                    local xOffset = entry.XOffset or 0
                    local yOffset = entry.YOffset or 0

                    inst.Position = UDim2.fromOffset(baseX + xOffset, baseY + yOffset)
                end
            end
        end

		local ListSizeX = 0
		local function RecalculateListSize()
			if #Dropdown.Values > MAX_DROPDOWN_ITEMS then
				DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, (42 * MAX_DROPDOWN_ITEMS) - 10) -- ปรับขนาดตาม item ที่ใหญ่ขึ้น
			else
				DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, DropdownListLayout.AbsoluteContentSize.Y + 30)
			end
		end

		local function RecalculateCanvasSize()
			-- Dung kich thuoc THAT tu UIListLayout (item 34px + padding 10px)
			-- thay vi uoc luong 36/4 -> truoc day canvas nho hon noi dung that,
			-- lam khong the cuon xuong xem item thu 6+ duoc
			local contentHeight = DropdownListLayout.AbsoluteContentSize.Y

			-- Them cho cho loading indicator neu con item chua load
			if Dropdown.LoadedItems < #Dropdown.Values then
				contentHeight = contentHeight + 45
			end

			DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, contentHeight + 10)
		end

		-- Cap nhat canvas moi khi noi dung list thay doi (load them batch, filter...)
		Creator.AddSignal(DropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), RecalculateCanvasSize)

		RecalculateListPosition()
		RecalculateListSize()

		Creator.AddSignal(DropdownInner:GetPropertyChangedSignal("AbsolutePosition"), RecalculateListPosition)

		-- Scroll detection for lazy loading
		Creator.AddSignal(DropdownScrollFrame:GetPropertyChangedSignal("CanvasPosition"), function()
			if not Dropdown.Opened or Dropdown.IsLoadingBatch then return end
			
			local scrollFrame = DropdownScrollFrame
			local scrollPosition = scrollFrame.CanvasPosition.Y
			local scrollFrameHeight = scrollFrame.AbsoluteSize.Y
			local canvasHeight = scrollFrame.CanvasSize.Y.Offset
			
			-- เช็คว่า scroll ถึงใกล้ท้ายแล้วมั้ย (เหลือ 50 pixels จาก content จริง)
			if scrollPosition + scrollFrameHeight >= canvasHeight - 50 and Dropdown.LoadedItems < #Dropdown.Values then
				Dropdown:LoadNextBatch()
			end
		end)

		Creator.AddSignal(DropdownSearch:GetPropertyChangedSignal("Text"), function()
			local Text = DropdownSearch.Text
			if #Text == 0 then
				for _, Element in next, DropdownScrollFrame:GetChildren() do
					if not Element:IsA("UIListLayout") and Element.Name ~= "LoadingIndicator" then
						local Value = Element.ButtonLabel.Text
						local Similar = Value:lower():match(Text:lower()) or Value:lower() == Text:lower()
						Element.Visible = true
					end
				end
			end
			for _, Element in next, DropdownScrollFrame:GetChildren() do
				if not Element:IsA("UIListLayout") and Element.Name ~= "LoadingIndicator" then
					local Value = Element.ButtonLabel.Text
					local Similar = Value:lower():match(Text:lower()) or Value:lower() == Text:lower()
					Element.Visible = Similar and true or false
				end
			end

			RecalculateListPosition()
			RecalculateListSize()
		end)

		Creator.AddSignal(DropdownSearch.Focused, function()
			DropdownSearch.Text = ""
		end)

		Creator.AddSignal(DropdownSearch.FocusLost, function(Enter, Input)
			if #DropdownSearch.Text > 0 then
				local Tick = tick()
				repeat wait() until tick() - Tick > 5 or DropdownSearch:IsFocused()
				if not DropdownSearch:IsFocused() then
					DropdownSearch.Text = ""
				end
			end
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

                if not Dropdown.Opened then return end

                local pos = input.Position
                local inDropdownInner = DropdownInner.AbsolutePosition.X <= pos.X
                    and pos.X <= DropdownInner.AbsolutePosition.X + DropdownInner.AbsoluteSize.X
                    and DropdownInner.AbsolutePosition.Y <= pos.Y
                    and pos.Y <= DropdownInner.AbsolutePosition.Y + DropdownInner.AbsoluteSize.Y

                local inDropdownHolder = DropdownHolderFrame.AbsolutePosition.X <= pos.X
                    and pos.X <= DropdownHolderFrame.AbsolutePosition.X + DropdownHolderFrame.AbsoluteSize.X
                    and (DropdownHolderFrame.AbsolutePosition.Y - 21) <= pos.Y
                    and pos.Y <= DropdownHolderFrame.AbsolutePosition.Y + DropdownHolderFrame.AbsoluteSize.Y

                local inSearchBox = false
                if SearchBase.Visible then
                    inSearchBox = SearchBase.AbsolutePosition.X <= pos.X
                        and pos.X <= SearchBase.AbsolutePosition.X + SearchBase.AbsoluteSize.X
                        and SearchBase.AbsolutePosition.Y <= pos.Y
                        and pos.Y <= SearchBase.AbsolutePosition.Y + SearchBase.AbsoluteSize.Y
                end

                local inClearButton = false
                if ClearButton and ClearButton.Visible then
                    inClearButton = ClearButton.AbsolutePosition.X <= pos.X
                        and pos.X <= ClearButton.AbsolutePosition.X + ClearButton.AbsoluteSize.X
                        and ClearButton.AbsolutePosition.Y <= pos.Y
                        and pos.Y <= ClearButton.AbsolutePosition.Y + ClearButton.AbsoluteSize.Y
                end

                if not inDropdownInner and not inDropdownHolder and not inSearchBox and not inClearButton then
                    Dropdown:Close() -- เรียกใช้ Close() ที่จะซ่อนปุ่มกากบาท
                end
            end
        end)

        Creator.AddSignal(DropdownInner.MouseButton1Click, function()
			if Dropdown.Opened then
				Dropdown:Close()
				return
			end
			Dropdown:Open()
		end)

		local ScrollFrame = self.ScrollFrame
		function Dropdown:Open()    
			Dropdown.Opened = true
			if Dropdown.Searchable then
				SearchBase.Visible = true
			end
			if ClearButton and Dropdown.Multi then
				local has = false
				for _ in pairs(Dropdown.Value) do has = true break end
				ClearButton.Visible = has
			end
			ScrollFrame.ScrollingEnabled = false
			DropdownHolderCanvas.Visible = true

			if Dropdown.LoadedItems == 0 and #Dropdown.Values > 0 then
				Dropdown:LoadNextBatch()
			end

			-- minimal: fade in + slight scale from 0.97 → 1
			DropdownHolderFrame.Size = UDim2.fromScale(1, 0)
			TweenService:Create(DropdownHolderFrame,
				TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ Size = UDim2.fromScale(1, 1) }
			):Play()
			TweenService:Create(DropdownIco,
				TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ Rotation = -90 }
			):Play()
		end

		function Dropdown:Close()
			Dropdown.Opened = false
			SearchBase.Visible = false
			if ClearButton then
				ClearButton.Visible = false -- บังคับซ่อนเมื่อปิด dropdown
			end
			ScrollFrame.ScrollingEnabled = true
			DropdownDisplay.Interactable = false
			DropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
			DropdownHolderCanvas.Visible = false
			TweenService:Create(
				DropdownIco,
				TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ Rotation = 90 }
			):Play()
			DropdownSearch:ReleaseFocus(false)
			Dropdown:Display()
		end

		function Dropdown:Display()
			local Values = Dropdown.Values
			local Str = ""

			if Config.Multi then
				local count = 0
				for Idx, Value in next,Values do
					if Dropdown.Value[Value] then
						count = count + 1
						if count <= 3 then
							Str = Str .. Value .. ", "
						elseif count == 4 then
							Str = Str .. "and " .. (count - 3) .. " more..."
							break
						end
					end
				end
				if count <= 3 then
					Str = Str:sub(1, #Str - 2)
				end
				
				-- แสดง/ซ่อนปุ่มกากบาท
				if ClearButton then
					-- แสดงเฉพาะเมื่อ dropdown เปิดอยู่ และมีรายการที่เลือก
					ClearButton.Visible = Dropdown.Opened and count > 0
				end
			else
				Str = Dropdown.Value or ""
			end

			DropdownDisplay.PlaceholderText = (Str == "" and "..." or Str)
		end

		function Dropdown:GetActiveValues()
			if Config.Multi then
				local T = {}

				for Value, Bool in next, Dropdown.Value do
					table.insert(T, Value)
				end

				return T
			else
				return Dropdown.Value and 1 or 0
			end
		end

		function Dropdown:SetActiveValues(Value)
			Dropdown.Value = Value

			Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
			Library:SafeCallback(Dropdown.Changed, Dropdown.Value)

			Dropdown:BuildDropdownList()
		end

		-- ฟังก์ชันสำหรับโหลด item แต่ละตัว with enhanced styling
		local function LoadItem(Idx, Value)
			-- Chan tao trung: neu index nay da co button roi thi tra ve luon.
			-- Day la nguyen nhan chinh khien danh sach (vd Fluent.Themes) hien
			-- ra 2 lan khi mo dropdown.
			if Dropdown.LoadedIndices[Idx] then
				return Dropdown.LoadedIndices[Idx]
			end

			local Table = {}

			-- accent bar ซ้าย
			local ButtonAccent = New("Frame", {
				Size             = UDim2.new(0, 3, 0, 0),
				AnchorPoint      = Vector2.new(0, 0.5),
				Position         = UDim2.new(0, 0, 0.5, 0),
				BackgroundTransparency = 1,
				ThemeTag         = { BackgroundColor3 = "Accent" },
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, 2) }),
			})

			local ButtonLabel = New("TextLabel", {
				FontFace         = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				Text             = tostring(Value),
				TextColor3       = Color3.fromRGB(200, 200, 200),
				TextSize         = 13,
				TextXAlignment   = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				AutomaticSize    = Enum.AutomaticSize.Y,
				Size             = UDim2.new(1, -28, 1, 0),
				Position         = UDim2.fromOffset(14, 0),
				Name             = "ButtonLabel",
				AutoLocalize     = false,
				ThemeTag         = { TextColor3 = "Text" },
			})

			local SelectDot = New("Frame", {
				Size             = UDim2.fromOffset(6, 6),
				AnchorPoint      = Vector2.new(1, 0.5),
				Position         = UDim2.new(1, -10, 0.5, 0),
				BackgroundTransparency = 1,
				ThemeTag         = { BackgroundColor3 = "Accent" },
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			})

			local Button = New("TextButton", {
				Size             = UDim2.new(1, -10, 0, 34),   -- padding กว้างขึ้น
				BackgroundTransparency = 1,
				ZIndex           = 23,
				Text             = "",
				Parent           = DropdownScrollFrame,
				LayoutOrder      = Idx,
				ThemeTag         = { BackgroundColor3 = "DropdownOption" },
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, 14) }),  -- มนขึ้นจาก 6
				ButtonAccent,
				ButtonLabel,
				SelectDot,
			})

			local Selected
			if Config.Multi then
				Selected = Dropdown.Value[Value] == true
			else
				Selected = Dropdown.Value == Value
			end

			local TI = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

			local function applyState(sel)
				TweenService:Create(Button, TI, {
					BackgroundTransparency = sel and 0.82 or 1,
				}):Play()
				TweenService:Create(ButtonAccent, TI, {
					BackgroundTransparency = sel and 0 or 1,
					Size = sel and UDim2.new(0, 3, 0.5, 0) or UDim2.new(0, 3, 0, 0),
				}):Play()
				TweenService:Create(SelectDot, TI, {
					BackgroundTransparency = sel and 0 or 1,
				}):Play()
				TweenService:Create(ButtonLabel, TI, {
					TextTransparency = sel and 0 or 0.15,
				}):Play()
			end

			Creator.AddSignal(Button.MouseEnter, function()
				if not Selected then
					TweenService:Create(Button, TI, { BackgroundTransparency = 0.90 }):Play()
					TweenService:Create(ButtonLabel, TI, { TextTransparency = 0 }):Play()
				end
			end)
			Creator.AddSignal(Button.MouseLeave, function()
				TweenService:Create(Button, TI, {
					BackgroundTransparency = Selected and 0.82 or 1,
				}):Play()
				TweenService:Create(ButtonLabel, TI, {
					TextTransparency = Selected and 0 or 0.15,
				}):Play()
			end)
			Creator.AddSignal(Button.MouseButton1Down, function()
				TweenService:Create(Button, TI, { BackgroundTransparency = 0.72 }):Play()
			end)
			Creator.AddSignal(Button.MouseButton1Up, function()
				TweenService:Create(Button, TI, {
					BackgroundTransparency = Selected and 0.82 or 0.90,
				}):Play()
			end)

			function Table:UpdateButton()
				if Config.Multi then
					Selected = Dropdown.Value[Value] == true
				else
					Selected = Dropdown.Value == Value
				end
				applyState(Selected)
			end

			AddSignal(Button.Activated, function()
				local Try = not Selected
				if Dropdown:GetActiveValues() == 1 and not Try and not Config.AllowNull then
					-- block deselect last
				else
					if Config.Multi then
						Selected = Try
						Dropdown.Value[Value] = Selected and true or nil
					else
						Selected = Try
						Dropdown.Value = Selected and Value or nil
						for _, OtherButton in next, Dropdown.Buttons do
							OtherButton:UpdateButton()
						end
					end
					Table:UpdateButton()
					if not (Dropdown.Searchable and #DropdownDisplay.Text > 0) then
						Dropdown:Display()
					end
					Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
					Library:SafeCallback(Dropdown.Changed,  Dropdown.Value)
				end
			end)

			Table:UpdateButton()
			Dropdown.Buttons[Button] = Table
			Dropdown.LoadedIndices[Idx] = Button
			Dropdown.LoadedItems = Dropdown.LoadedItems + 1
			return Button
		end

		-- ฟังก์ชันโหลดเฉพาะ items ที่จำเป็น (สำหรับ SetValue)
		function Dropdown:LoadRequiredItems(targetValues)
			task.spawn(function()
				-- เคลียร์ items เก่า
				for _, Element in next, DropdownScrollFrame:GetChildren() do
					if not Element:IsA("UIListLayout") and Element.Name ~= "LoadingIndicator" then
						Element:Destroy()
					end
				end

				Dropdown.Buttons = {}
				Dropdown.LoadedItems = 0
				Dropdown.LoadedIndices = {}
				Dropdown.NextLoadIndex = 1
				ListSizeX = 0

				-- โหลดเฉพาะ items ที่มีใน targetValues และ items รอบๆ
				local indicesToLoad = {}
				local loadRadius = 10 -- โหลด 10 items รอบๆ ค่าที่ต้องการ
				
				for _, targetValue in ipairs(targetValues) do
					local targetIndex = table.find(Dropdown.Values, targetValue)
					if targetIndex then
						-- เพิ่ม index หลักและ index รอบๆ
						for i = math.max(1, targetIndex - loadRadius), math.min(#Dropdown.Values, targetIndex + loadRadius) do
							indicesToLoad[i] = true
						end
					end
				end

				-- โหลด items ที่จำเป็น
				for i = 1, #Dropdown.Values do
					if indicesToLoad[i] then
						LoadItem(i, Dropdown.Values[i])

						-- อัพเดท text bounds สำหรับขนาด
						if ListSizeX == 0 then
							for Button, Table in next, Dropdown.Buttons do
								if Button and Button.ButtonLabel and Button.ButtonLabel.TextBounds then
									if Button.ButtonLabel.TextBounds.X > ListSizeX then
										ListSizeX = Button.ButtonLabel.TextBounds.X
									end
								end
							end
							ListSizeX = ListSizeX + 40
						end
					end
				end

				-- อัพเดท canvas size
				RecalculateCanvasSize()
				RecalculateListSize()
				Dropdown:Display()
			end)
		end

		-- ฟังก์ชันโหลด batch ถัดไป
		function Dropdown:LoadNextBatch()
			if Dropdown.IsLoadingBatch or Dropdown.LoadedItems >= #Dropdown.Values then
				return
			end

			Dropdown.IsLoadingBatch = true
			LoadingIndicator.Visible = true
			LoadingIndicator.LayoutOrder = 9999 -- ให้อยู่ล่างสุด

			task.spawn(function()
				-- Quet tu con tro, BO QUA index da co button (do LoadRequiredItems
				-- da load truoc do) -> khong tao lai item trung
				local i = Dropdown.NextLoadIndex or 1
				local loaded = 0

				while i <= #Dropdown.Values and loaded < Dropdown.BatchSize do
					if Dropdown.Values[i] and not Dropdown.LoadedIndices[i] then
						LoadItem(i, Dropdown.Values[i])
						loaded = loaded + 1

						-- อัพเดท text bounds สำหรับขนาด
						if ListSizeX == 0 then
							for Button, Table in next, Dropdown.Buttons do
								if Button and Button.ButtonLabel and Button.ButtonLabel.TextBounds then
									if Button.ButtonLabel.TextBounds.X > ListSizeX then
										ListSizeX = Button.ButtonLabel.TextBounds.X
									end
								end
							end
							ListSizeX = ListSizeX + 40 -- เพิ่มขนาดสำหรับ padding
						end

						-- หยุดเล็กน้อยเพื่อไม่ให้แลค (ถ้าจำเป็น)
						if loaded % 10 == 0 then
							task.wait()
						end
					end
					i = i + 1
				end

				Dropdown.NextLoadIndex = i
				Dropdown.IsLoadingBatch = false
				
				-- อัพเดท canvas size ตามจำนวน items ที่โหลดแล้ว
				RecalculateCanvasSize()
				
				-- ซ่อน loading indicator ถ้าโหลดครบแล้ว
				if Dropdown.LoadedItems >= #Dropdown.Values then
					LoadingIndicator.Visible = false
				else
					LoadingIndicator.Visible = false -- ซ่อนชั่วคราว จะแสดงอีกครั้งเมื่อ scroll
				end

				RecalculateListSize()
				Dropdown:Display()
			end)
		end

		function Dropdown:BuildDropdownList()
			task.spawn(function()
				-- เคลียร์ items เก่า
				for _, Element in next, DropdownScrollFrame:GetChildren() do
					if not Element:IsA("UIListLayout") and Element.Name ~= "LoadingIndicator" then
						Element:Destroy()
					end
				end

				Dropdown.Buttons = {}
				Dropdown.LoadedItems = 0
				Dropdown.LoadedIndices = {}
				Dropdown.NextLoadIndex = 1
				ListSizeX = 0

				-- รีเซ็ต canvas size ให้เล็กก่อน
				DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, 0)
				
				-- ไม่โหลดทันที รอให้เปิด dropdown ก่อน
				-- Dropdown:LoadNextBatch() -- ลบบรรทัดนี้
			end)
		end

		function Dropdown:SetValues(NewValues)
			if NewValues then
				Dropdown.Values = NewValues
			end

			Dropdown:BuildDropdownList()
		end

		function Dropdown:OnChanged(Func)
			Dropdown.Changed = Func
			Func(Dropdown.Value)
		end

		function Dropdown:SetValue(Val)
			local needsLoading = false
			local targetValues = {}
			
			if Dropdown.Multi then
				local nTable = {}

				for Value, Bool in next, Val do
					if table.find(Dropdown.Values, Value) then
						nTable[Value] = true
						table.insert(targetValues, Value)
					end
				end

				Dropdown.Value = nTable
				needsLoading = next(nTable) ~= nil
			else
				if not Val then
					Dropdown.Value = nil
				elseif table.find(Dropdown.Values, Val) then
					Dropdown.Value = Val
					table.insert(targetValues, Val)
					needsLoading = true
				end
			end

			-- ถ้ามีการ set ค่าใหม่ ให้โหลดเฉพาะ items ที่จำเป็น
			if needsLoading and #targetValues > 0 then
				Dropdown:LoadRequiredItems(targetValues)
			else
				Dropdown:BuildDropdownList()
			end

			Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
			Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
			wait(.2)
		end

		function Dropdown:GetValue()
			return self.Value
		end

		function Dropdown:Destroy()
			DropdownFrame:Destroy()
			Library.Options[Idx] = nil
		end

		-- ฟังก์ชันเช็คว่า value ถูกโหลดแล้วหรือยัง
		function Dropdown:IsValueLoaded(value)
			for Button, Table in next, Dropdown.Buttons do
				if Button and Button.ButtonLabel and Button.ButtonLabel.Text == tostring(value) then
					return true
				end
			end
			return false
		end

		-- ฟังก์ชันโหลด value เฉพาะตัว (ถ้ายังไม่ถูกโหลด)
		function Dropdown:EnsureValueLoaded(value)
			if not Dropdown:IsValueLoaded(value) then
				local index = table.find(Dropdown.Values, value)
				if index then
					LoadItem(index, value) -- LoadItem tu tang LoadedItems
					RecalculateCanvasSize()
					RecalculateListSize()
				end
			end
		end

		-- ฟังก์ชันปรับแต่ง batch size
		function Dropdown:SetBatchSize(size)
			Dropdown.BatchSize = math.max(1, size or 20)
		end

		-- ฟังก์ชันโหลดทั้งหมดทันที (สำหรับกรณีพิเศษ)
		function Dropdown:LoadAllItems()
			while Dropdown.LoadedItems < #Dropdown.Values do
				local before = Dropdown.LoadedItems
				Dropdown:LoadNextBatch()
				task.wait()
				-- tranh vong lap vo han neu batch khong load duoc them gi
				if Dropdown.LoadedItems == before and not Dropdown.IsLoadingBatch then
					break
				end
			end
		end

		-- ฟังก์ชันล้างค่าทั้งหมด (สำหรับ Multi dropdown)
		function Dropdown:ClearAll()
			if Dropdown.Multi then
				Dropdown.Value = {}
				for _, Button in next, Dropdown.Buttons do
					Button:UpdateButton()
				end
				Dropdown:Display()
				Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
				Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
			end
		end

		Dropdown:BuildDropdownList()
		Dropdown:Display()

		-- ไม่เรียก BuildDropdownList ซ้ำ เพราะมันจะไม่โหลด items แล้ว

		local Defaults = {}

		if type(Config.Default) == "string" then
			local Idx = table.find(Dropdown.Values, Config.Default)
			if Idx then
				table.insert(Defaults, Idx)
			end
		elseif type(Config.Default) == "table" then
			for _, Value in next, Config.Default do
				local Idx = table.find(Dropdown.Values, Value)
				if Idx then
					table.insert(Defaults, Idx)
				end
			end
		elseif type(Config.Default) == "number" and Dropdown.Values[Config.Default] ~= nil then
			table.insert(Defaults, Config.Default)
		end

		if next(Defaults) then
			for i = 1, #Defaults do
				local Index = Defaults[i]
				if Config.Multi then
					Dropdown.Value[Dropdown.Values[Index]] = true
				else
					Dropdown.Value = Dropdown.Values[Index]
				end

				if not Config.Multi then
					break
				end
			end

			-- โหลดเฉพาะ items ที่จำเป็นสำหรับ default values
			local targetValues = {}
			if Config.Multi then
				for value, _ in pairs(Dropdown.Value) do
					table.insert(targetValues, value)
				end
			else
				if Dropdown.Value then
					table.insert(targetValues, Dropdown.Value)
				end
			end
			
			if #targetValues > 0 then
				Dropdown:LoadRequiredItems(targetValues)
			else
				Dropdown:BuildDropdownList()
			end
			
			Dropdown:Display()
		else
			-- ถ้าไม่มี default values ก็แค่ build list ธรรมดา (ไม่โหลด items)
			Dropdown:BuildDropdownList()
			Dropdown:Display()
		end

		Library.Options[Idx] = Dropdown

		return Dropdown
	
	
	end

	return Element
end)()
ElementsTable.Paragraph = (function()
	local Paragraph = {}
	Paragraph.__index = Paragraph
	Paragraph.__type = "Paragraph"

	function Paragraph:New(Config)
		assert(Config.Title, "Paragraph - Missing Title")
		Config.Content = Config.Content or ""

		local Paragraph = Components.Element(Config.Title, Config.Content, Paragraph.Container, false, Config)
		Paragraph.Frame.BackgroundTransparency = 0.92
		Paragraph.Border.Transparency = 0.6

		Paragraph.SetTitle = Paragraph.SetTitle
		Paragraph.SetDesc = Paragraph.SetDesc
		Paragraph.Visible = Paragraph.Visible
		Paragraph.Elements = Paragraph

		return Paragraph
	end

	return Paragraph
end)()
ElementsTable.Slider = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Slider"

	function Element:New(Idx, Config)
		assert(Config.Title,    "Slider - Missing Title.")
		assert(Config.Default,  "Slider - Missing default value.")
		assert(Config.Min,      "Slider - Missing minimum value.")
		assert(Config.Max,      "Slider - Missing maximum value.")
		assert(Config.Rounding, "Slider - Missing rounding value.")

		local Slider = {
			Value    = nil,
			Min      = Config.Min,
			Max      = Config.Max,
			Rounding = Config.Rounding,
			Callback = Config.Callback or function(Value) end,
			Type     = "Slider",
		}

		local Dragging = false
		local Typing   = false

		local SliderFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config)

		SliderFrame.TitleLabel.Size = UDim2.new(1, -60, 0, 14)
		SliderFrame.DescLabel.Size  = UDim2.new(1, -60, 0, 14)

		Slider.Elements  = SliderFrame
		Slider.SetTitle  = SliderFrame.SetTitle
		Slider.SetDesc   = SliderFrame.SetDesc
		Slider.Visible   = SliderFrame.Visible

		-- ── Value display box (ขวาบน) ────────────────────────
		local SliderDisplay = New("TextBox", {
			FontFace         = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text             = tostring(Config.Default),
			PlaceholderText  = "",
			TextSize         = 12,
			TextWrapped      = false,
			TextXAlignment   = Enum.TextXAlignment.Center,
			BackgroundTransparency = 0.85,
			Size             = UDim2.new(0, 48, 0, 20),
			Position         = UDim2.new(1, -10, 0, 8),
			AnchorPoint      = Vector2.new(1, 0),
			ZIndex           = 4,
			ClearTextOnFocus = false,
			Parent           = SliderFrame.Frame,
			ThemeTag         = { TextColor3 = "SubText", BackgroundColor3 = "Element" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 4) }),
			New("UIStroke", {
				Thickness       = 1,
				Transparency    = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag        = { Color = "InElementBorder" },
			}),
		})

		-- ── Rail container ────────────────────────────────────
		local SliderRail = New("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(7, 0),
			Size     = UDim2.new(1, -14, 1, 0),
		})

		-- ── Thin visual rail ──────────────────────────────────
		local RailBg = New("Frame", {
			Size             = UDim2.new(1, 0, 0, 3),
			AnchorPoint      = Vector2.new(0, 0.5),
			Position         = UDim2.fromScale(0, 0.5),
			BackgroundTransparency = 0.65,
			Parent           = SliderRail,
			ThemeTag         = { BackgroundColor3 = "SliderRail" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})

		-- ── Accent fill ───────────────────────────────────────
		local SliderFill = New("Frame", {
			Size     = UDim2.fromScale(0, 1),
			Parent   = RailBg,
			ThemeTag = { BackgroundColor3 = "Accent" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})

		-- ── Thumb ─────────────────────────────────────────────
		local SliderDot = New("Frame", {
			Size             = UDim2.fromOffset(14, 14),
			AnchorPoint      = Vector2.new(0, 0.5),
			Position         = UDim2.new(0, -7, 0.5, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			ZIndex           = 5,
			Parent           = SliderRail,
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			New("UIStroke", {
				Thickness       = 1.5,
				Transparency    = 0.35,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag        = { Color = "Accent" },
			}),
		})

		-- ── Rail track อยู่ล่างสุดของ element ────────────────
		local SliderTrack = New("Frame", {
			Size        = UDim2.new(1, -20, 0, 4),
			AnchorPoint = Vector2.new(0, 1),
			Position    = UDim2.new(0, 10, 1, -8),
			BackgroundTransparency = 0.4,
			Parent      = SliderFrame.Frame,
			ThemeTag    = { BackgroundColor3 = "SliderRail" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			RailBg,
			SliderRail,
		})

		-- padding ล่างให้ frame ขยายพอรับ rail
		New("UIPadding", {
			PaddingBottom = UDim.new(0, 28),
			Parent        = SliderFrame.LabelHolder,
		})

		-- ── Easing ────────────────────────────────────────────
		local TI_MOVE  = TweenInfo.new(0.08, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local TI_THUMB = TweenInfo.new(0.12, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)

		-- ── Input bindings ────────────────────────────────────
		-- Chi ap dung khi go xong (Enter / bo focus) de khong clamp tung ky tu
		AddSignal(SliderDisplay.Focused, function()
			Typing = true
		end)

		AddSignal(SliderDisplay.FocusLost, function()
			Typing = false
			local num = tonumber(SliderDisplay.Text)
			if num then
				Slider:SetValue(num)
			else
				SliderDisplay.Text = tostring(Slider.Value)
			end
		end)

		Creator.AddSignal(SliderDot.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				TweenService:Create(SliderDot, TI_THUMB, { Size = UDim2.fromOffset(18, 18) }):Play()
			end
		end)

		Creator.AddSignal(SliderDot.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = false
				TweenService:Create(SliderDot, TI_THUMB, { Size = UDim2.fromOffset(14, 14) }):Play()
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if Dragging and (
				Input.UserInputType == Enum.UserInputType.MouseMovement
				or Input.UserInputType == Enum.UserInputType.Touch
			) then
				local SizeScale = math.clamp(
					(Input.Position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X,
					0, 1
				)
				Slider:SetValue(Slider.Min + (Slider.Max - Slider.Min) * SizeScale)
			end
		end)

		-- ── Public API ────────────────────────────────────────
		function Slider:OnChanged(Func)
			Slider.Changed = Func
			Func(Slider.Value)
		end

		function Slider:SetValue(Value)
			Value = Value or self.Value

			if (not tonumber(Value)) and tostring(Value):len() > 0 then
				Value = self.Value
			end

			self.Value = Library:Round(
				math.clamp(tonumber(Value), Slider.Min, Slider.Max),
				Slider.Rounding
			) or 0

			local pct = (self.Value - Slider.Min) / (Slider.Max - Slider.Min)

			TweenService:Create(SliderDot,  TI_MOVE, { Position = UDim2.new(pct, -7, 0.5, 0) }):Play()
			TweenService:Create(SliderFill, TI_MOVE, { Size     = UDim2.fromScale(pct, 1)      }):Play()

			if not Typing then
				SliderDisplay.Text = tostring(self.Value)
			end

			Library:SafeCallback(Slider.Callback, self.Value)
			Library:SafeCallback(Slider.Changed,  self.Value)
		end

		function Slider:GetValue()
			return self.Value
		end

		function Slider:Destroy()
			SliderFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Slider:SetValue(Config.Default)

		Library.Options[Idx] = Slider
		return Slider
	end

	return Element
end)()
ElementsTable.Keybind = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Keybind"

	function Element:New(Idx, Config)
		assert(Config.Title, "KeyBind - Missing Title")
		assert(Config.Default, "KeyBind - Missing default value.")

		local Keybind = {
			Value = Config.Default,
			Toggled = false,
			Mode = Config.Mode or "Toggle",
			Type = "Keybind",
			Callback = Config.Callback or function(Value) end,
			ChangedCallback = Config.ChangedCallback or function(New) end,
		}

		local Picking = false

		local KeybindFrame = Components.Element(Config.Title, Config.Description, self.Container, true)

		Keybind.SetTitle = KeybindFrame.SetTitle
		Keybind.SetDesc = KeybindFrame.SetDesc
		Keybind.Visible = KeybindFrame.Visible
		Keybind.Elements = KeybindFrame

		local KeybindDisplayLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = Config.Default,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Center,
			Size = UDim2.new(0, 0, 0, 14),
			Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			AutoLocalize = false,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local KeybindDisplayFrame = New("TextButton", {
			Size = UDim2.fromOffset(0, 30),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent = KeybindFrame.Frame,
			AutomaticSize = Enum.AutomaticSize.X,
			ThemeTag = {
				BackgroundColor3 = "Keybind",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 10),
			}),
			New("UIPadding", {
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			KeybindDisplayLabel,
		})

		function Keybind:GetState()
			if UserInputService:GetFocusedTextBox() and Keybind.Mode ~= "Always" then
				return false
			end

			if Keybind.Mode == "Always" then
				return true
			elseif Keybind.Mode == "Hold" then
				if Keybind.Value == "None" then
					return false
				end

				local Key = Keybind.Value

				if Key == "MouseLeft" or Key == "MouseRight" then
					return Key == "MouseLeft" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
						or Key == "MouseRight"
						and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
				else
					return UserInputService:IsKeyDown(Enum.KeyCode[Keybind.Value])
				end
			else
				return Keybind.Toggled
			end
		end

		function Keybind:SetValue(Key, Mode)
			Key = Key or Keybind.Key
			Mode = Mode or Keybind.Mode

			KeybindDisplayLabel.Text = Key
			Keybind.Value = Key
			Keybind.Mode = Mode
		end

		function Keybind:GetValue()
			return self.Value
		end

		function Keybind:OnClick(Callback)
			Keybind.Clicked = Callback
		end

		function Keybind:OnChanged(Callback)
			Keybind.Changed = Callback
			Callback(Keybind.Value)
		end

		function Keybind:DoClick()
			Library:SafeCallback(Keybind.Callback, Keybind.Toggled)
			Library:SafeCallback(Keybind.Clicked, Keybind.Toggled)
		end

		function Keybind:Destroy()
			KeybindFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(KeybindDisplayFrame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Picking = true
				KeybindDisplayLabel.Text = "..."

				wait()

				local Event
				Event = UserInputService.InputBegan:Connect(function(Input)
					local Key

					if Input.UserInputType == Enum.UserInputType.Keyboard then
						Key = Input.KeyCode.Name
					elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Key = "MouseLeft"
					elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
						Key = "MouseRight"
					end

					local EndedEvent
					EndedEvent = UserInputService.InputEnded:Connect(function(Input)
						if
							Input.KeyCode.Name == Key
							or Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1
							or Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2
						then
							Picking = false

							KeybindDisplayLabel.Text = Key
							Keybind.Value = Key

							Library:SafeCallback(Keybind.ChangedCallback, Input.KeyCode or Input.UserInputType)
							Library:SafeCallback(Keybind.Changed, Input.KeyCode or Input.UserInputType)

							Event:Disconnect()
							EndedEvent:Disconnect()
						end
					end)
				end)
			end
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if not Picking and not UserInputService:GetFocusedTextBox() then
				if Keybind.Mode == "Toggle" then
					local Key = Keybind.Value

					if Key == "MouseLeft" or Key == "MouseRight" then
						if
							Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1
							or Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2
						then
							Keybind.Toggled = not Keybind.Toggled
							Keybind:DoClick()
						end
					elseif Input.UserInputType == Enum.UserInputType.Keyboard then
						if Input.KeyCode.Name == Key then
							Keybind.Toggled = not Keybind.Toggled
							Keybind:DoClick()
						end
					end
				end
			end
		end)

		Library.Options[Idx] = Keybind
		return Keybind
	end

	return Element
end)()
ElementsTable.Colorpicker = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Colorpicker"

	function Element:New(Idx, Config)
		assert(Config.Title, "Colorpicker - Missing Title")
		assert(Config.Default, "AddColorPicker: Missing default value.")

		local Colorpicker = {
			Value = Config.Default,
			Transparency = Config.Transparency or 0,
			Type = "Colorpicker",
			Title = type(Config.Title) == "string" and Config.Title or "Colorpicker",
			Callback = Config.Callback or function(Color) end,
		}

		function Colorpicker:SetHSVFromRGB(Color)
			local H, S, V = Color3.toHSV(Color)
			Colorpicker.Hue = H
			Colorpicker.Sat = S
			Colorpicker.Vib = V
		end

		Colorpicker:SetHSVFromRGB(Colorpicker.Value)

		local ColorpickerFrame = Components.Element(Config.Title, Config.Description, self.Container, true)

		Colorpicker.SetTitle = ColorpickerFrame.SetTitle
		Colorpicker.SetDesc = ColorpickerFrame.SetDesc
		Colorpicker.Visible = ColorpickerFrame.Visible
		Colorpicker.Elements = ColorpickerFrame

		local DisplayFrameColor = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Colorpicker.Value,
			Parent = ColorpickerFrame.Frame,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		local DisplayFrame = New("ImageLabel", {
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Parent = ColorpickerFrame.Frame,
			Image = "http://www.roblox.com/asset/?id=14204231522",
			ImageTransparency = 0.45,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromOffset(40, 40),
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			DisplayFrameColor,
		})

		local function CreateColorDialog()
			local Dialog = Components.Dialog:Create()
			Dialog.Title.Text = Colorpicker.Title
			Dialog.Root.Size = UDim2.fromOffset(430, 330)

			local Hue, Sat, Vib = Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib
			local Transparency = Colorpicker.Transparency

			local function CreateInput()
				local Box = Components.Textbox()
				Box.Frame.Parent = Dialog.Root
				Box.Frame.Size = UDim2.new(0, 90, 0, 32)

				return Box
			end

			local function CreateInputLabel(Text, Pos)
				return New("TextLabel", {
					FontFace = Font.new(
						"rbxasset://fonts/families/GothamSSm.json",
						Enum.FontWeight.Medium,
						Enum.FontStyle.Normal
					),
					Text = Text,
					TextColor3 = Color3.fromRGB(240, 240, 240),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					Size = UDim2.new(1, 0, 0, 32),
					Position = Pos,
					BackgroundTransparency = 1,
					Parent = Dialog.Root,
					AutoLocalize = false,
					ThemeTag = {
						TextColor3 = "Text",
					},
				})
			end

			local function GetRGB()
				local Value = Color3.fromHSV(Hue, Sat, Vib)
				return { R = math.floor(Value.r * 255), G = math.floor(Value.g * 255), B = math.floor(Value.b * 255) }
			end

			local SatCursor = New("ImageLabel", {
				Size = UDim2.new(0, 18, 0, 18),
				ScaleType = Enum.ScaleType.Fit,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=4805639000",
			})

			local SatVibMap = New("ImageLabel", {
				Size = UDim2.fromOffset(180, 160),
				Position = UDim2.fromOffset(20, 55),
				Image = "rbxassetid://4155801252",
				BackgroundColor3 = Colorpicker.Value,
				BackgroundTransparency = 0,
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				SatCursor,
			})

			local OldColorFrame = New("Frame", {
				BackgroundColor3 = Colorpicker.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = Colorpicker.Transparency,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})

			local OldColorFrameChecker = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(112, 220),
				Size = UDim2.fromOffset(88, 24),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				OldColorFrame,
			})

			local DialogDisplayFrame = New("Frame", {
				BackgroundColor3 = Colorpicker.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 0,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})

			local DialogDisplayFrameChecker = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(20, 220),
				Size = UDim2.fromOffset(88, 24),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				DialogDisplayFrame,
			})

			local SequenceTable = {}

			for Color = 0, 1, 0.1 do
				table.insert(SequenceTable, ColorSequenceKeypoint.new(Color, Color3.fromHSV(Color, 1, 1)))
			end

			local HueSliderGradient = New("UIGradient", {
				Color = ColorSequence.new(SequenceTable),
				Rotation = 90,
			})

			local HueDragHolder = New("Frame", {
				Size = UDim2.new(1, 0, 1, -10),
				Position = UDim2.fromOffset(0, 5),
				BackgroundTransparency = 1,
			})

			local HueDrag = New("ImageLabel", {
				Size = UDim2.fromOffset(14, 14),
				Image = "http://www.roblox.com/asset/?id=12266946128",
				Parent = HueDragHolder,
				ThemeTag = {
					ImageColor3 = "DialogInput",
				},
			})

			local HueSlider = New("Frame", {
				Size = UDim2.fromOffset(12, 190),
				Position = UDim2.fromOffset(210, 55),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
				HueSliderGradient,
				HueDragHolder,
			})

			local HexInput = CreateInput()
			HexInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 55)
			CreateInputLabel("Hex", UDim2.fromOffset(Config.Transparency and 360 or 340, 55))

			local RedInput = CreateInput()
			RedInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 95)
			CreateInputLabel("Red", UDim2.fromOffset(Config.Transparency and 360 or 340, 95))

			local GreenInput = CreateInput()
			GreenInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 135)
			CreateInputLabel("Green", UDim2.fromOffset(Config.Transparency and 360 or 340, 135))

			local BlueInput = CreateInput()
			BlueInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 175)
			CreateInputLabel("Blue", UDim2.fromOffset(Config.Transparency and 360 or 340, 175))

			local AlphaInput
			if Config.Transparency then
				AlphaInput = CreateInput()
				AlphaInput.Frame.Position = UDim2.fromOffset(260, 215)
				CreateInputLabel("Alpha", UDim2.fromOffset(360, 215))
			end

			local TransparencySlider, TransparencyDrag, TransparencyColor
			if Config.Transparency then
				local TransparencyDragHolder = New("Frame", {
					Size = UDim2.new(1, 0, 1, -10),
					Position = UDim2.fromOffset(0, 5),
					BackgroundTransparency = 1,
				})

				TransparencyDrag = New("ImageLabel", {
					Size = UDim2.fromOffset(14, 14),
					Image = "http://www.roblox.com/asset/?id=12266946128",
					Parent = TransparencyDragHolder,
					ThemeTag = {
						ImageColor3 = "DialogInput",
					},
				})

				TransparencyColor = New("Frame", {
					Size = UDim2.fromScale(1, 1),
				}, {
					New("UIGradient", {
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						}),
						Rotation = 270,
					}),
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
				})

				TransparencySlider = New("Frame", {
					Size = UDim2.fromOffset(12, 190),
					Position = UDim2.fromOffset(230, 55),
					Parent = Dialog.Root,
					BackgroundTransparency = 1,
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
					New("ImageLabel", {
						Image = "http://www.roblox.com/asset/?id=14204231522",
						ImageTransparency = 0.45,
						ScaleType = Enum.ScaleType.Tile,
						TileSize = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Parent = Dialog.Root,
					}, {
						New("UICorner", {
							CornerRadius = UDim.new(1, 0),
						}),
					}),
					TransparencyColor,
					TransparencyDragHolder,
				})
			end

			local function Display()
				SatVibMap.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
				HueDrag.Position = UDim2.new(0, -1, Hue, -6)
				SatCursor.Position = UDim2.new(Sat, 0, 1 - Vib, 0)
				DialogDisplayFrame.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)

				HexInput.Input.Text = "#" .. Color3.fromHSV(Hue, Sat, Vib):ToHex()
				RedInput.Input.Text = GetRGB()["R"]
				GreenInput.Input.Text = GetRGB()["G"]
				BlueInput.Input.Text = GetRGB()["B"]

				if Config.Transparency then
					TransparencyColor.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
					DialogDisplayFrame.BackgroundTransparency = Transparency
					TransparencyDrag.Position = UDim2.new(0, -1, 1 - Transparency, -6)
					AlphaInput.Input.Text = Library:Round((1 - Transparency) * 100, 0) .. "%"
				end
			end

			Creator.AddSignal(HexInput.Input.FocusLost, function(Enter)
				if Enter then
					local Success, Result = pcall(Color3.fromHex, HexInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						Hue, Sat, Vib = Color3.toHSV(Result)
					end
				end
				Display()
			end)

			Creator.AddSignal(RedInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result = pcall(Color3.fromRGB, RedInput.Input.Text, CurrentColor["G"], CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(RedInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(GreenInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result =
						pcall(Color3.fromRGB, CurrentColor["R"], GreenInput.Input.Text, CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(GreenInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(BlueInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result =
						pcall(Color3.fromRGB, CurrentColor["R"], CurrentColor["G"], BlueInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						if tonumber(BlueInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			if Config.Transparency then
				Creator.AddSignal(AlphaInput.Input.FocusLost, function(Enter)
					if Enter then
						pcall(function()
							local Value = tonumber(AlphaInput.Input.Text)
							if Value >= 0 and Value <= 100 then
								Transparency = 1 - Value * 0.01
							end
						end)
					end
					Display()
				end)
			end

			Creator.AddSignal(SatVibMap.InputBegan, function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinX = SatVibMap.AbsolutePosition.X
						local MaxX = MinX + SatVibMap.AbsoluteSize.X
						local MouseX = math.clamp(Mouse.X, MinX, MaxX)

						local MinY = SatVibMap.AbsolutePosition.Y
						local MaxY = MinY + SatVibMap.AbsoluteSize.Y
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

						Sat = (MouseX - MinX) / (MaxX - MinX)
						Vib = 1 - ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end)

			Creator.AddSignal(HueSlider.InputBegan, function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinY = HueSlider.AbsolutePosition.Y
						local MaxY = MinY + HueSlider.AbsoluteSize.Y
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

						Hue = ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end)

			if Config.Transparency then
				Creator.AddSignal(TransparencySlider.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
							local MinY = TransparencySlider.AbsolutePosition.Y
							local MaxY = MinY + TransparencySlider.AbsoluteSize.Y
							local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

							Transparency = 1 - ((MouseY - MinY) / (MaxY - MinY))
							Display()

							RenderStepped:Wait()
						end
					end
				end)
			end

			Display()

			Dialog:Button("Done", function()
				Colorpicker:SetValue({ Hue, Sat, Vib }, Transparency)
			end)
			Dialog:Button("Cancel")
			Dialog:Open()
		end

		function Colorpicker:Display()
			Colorpicker.Value = Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib)

			DisplayFrameColor.BackgroundColor3 = Colorpicker.Value
			DisplayFrameColor.BackgroundTransparency = Colorpicker.Transparency

			Element.Library:SafeCallback(Colorpicker.Callback, Colorpicker.Value)
			Element.Library:SafeCallback(Colorpicker.Changed, Colorpicker.Value)
		end

		function Colorpicker:SetValue(HSV, Transparency)
			local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3])

			Colorpicker.Transparency = Transparency or 0
			Colorpicker:SetHSVFromRGB(Color)
			Colorpicker:Display()
		end

		function Colorpicker:SetValueRGB(Color, Transparency)
			Colorpicker.Transparency = Transparency or 0
			Colorpicker:SetHSVFromRGB(Color)
			Colorpicker:Display()
		end

		function Colorpicker:OnChanged(Func)
			Colorpicker.Changed = Func
			Func(Colorpicker.Value)
		end

		function Colorpicker:Destroy()
			ColorpickerFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ColorpickerFrame.Frame.MouseButton1Click, function()
			CreateColorDialog()
		end)

		Colorpicker:Display()

		Library.Options[Idx] = Colorpicker
		return Colorpicker
	end

	return Element
end)()
ElementsTable.Input = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Input"

	function Element:New(Idx, Config)
		assert(Config.Title, "Input - Missing Title")
		Config.Callback = Config.Callback or function() end

		local Input = {
			Value = Config.Default or "",
			Numeric = Config.Numeric or false,
			Finished = Config.Finished or false,
			Callback = Config.Callback or function(Value) end,
			Type = "Input",
		}

		local InputFrame = Components.Element(Config.Title, Config.Description, self.Container, false)
		InputFrame.DescLabel.Size = UDim2.new(1, -170, 0, 14)

		Input.SetTitle = InputFrame.SetTitle
		Input.SetDesc = InputFrame.SetDesc
		Input.Visible = InputFrame.Visible
		Input.Elements = InputFrame

		local Textbox = Components.Textbox(InputFrame.Frame, true)
		Textbox.Frame.Position = UDim2.new(1, -10, 0.5, 0)
		Textbox.Frame.AnchorPoint = Vector2.new(1, 0.5)
		Textbox.Frame.Size = UDim2.fromOffset(160, 30)
		Textbox.Input.Text = Config.Default or ""
		Textbox.Input.PlaceholderText = Config.Placeholder or ""
		Textbox.MultiLine = Config.MultiLine or false

		local Box = Textbox.Input

		function Input:SetValue(Text)
			if Config.MaxLength and #Text > Config.MaxLength then
				Text = Text:sub(1, Config.MaxLength)
			end

			if Input.Numeric then
				local number = tonumber(Text)
				if not number and Text:len() > 0 then
					Text = Input.Value
				end
			end

			Input.Value = Text
			Box.Text = Text

			Library:SafeCallback(Input.Callback, Input.Value)
			Library:SafeCallback(Input.Changed, Input.Value)
			wait(.2)
		end

		function Input:GetValue()
			return self.Value
		end

		if Input.Finished then
			AddSignal(Box.FocusLost, function(enter)
				if not enter then
					return
				end
				Input:SetValue(Box.Text)
			end)
		else
			AddSignal(Box:GetPropertyChangedSignal("Text"), function()
				Input:SetValue(Box.Text)
			end)
		end

		function Input:OnChanged(Func)
			Input.Changed = Func
			Func(Input.Value)
		end

		function Input:Destroy()
			InputFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Library.Options[Idx] = Input

		return Input
	end

	return Element
end)()

local NotificationModule = Components.Notification
NotificationModule:Init(GUI)

local New = Creator.New

local Icons = {
	["lucide-accessibility"] = "rbxassetid://10709751939",
	["lucide-activity"] = "rbxassetid://10709752035",
	["lucide-air-vent"] = "rbxassetid://10709752131",
	["lucide-airplay"] = "rbxassetid://10709752254",
	["lucide-alarm-check"] = "rbxassetid://10709752405",
	["lucide-alarm-clock"] = "rbxassetid://10709752630",
	["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
	["lucide-alarm-minus"] = "rbxassetid://10709752732",
	["lucide-alarm-plus"] = "rbxassetid://10709752825",
	["lucide-album"] = "rbxassetid://10709752906",
	["lucide-alert-circle"] = "rbxassetid://10709752996",
	["lucide-alert-octagon"] = "rbxassetid://10709753064",
	["lucide-alert-triangle"] = "rbxassetid://10709753149",
	["lucide-align-center"] = "rbxassetid://10709753570",
	["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
	["lucide-align-center-vertical"] = "rbxassetid://10709753421",
	["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
	["lucide-align-end-vertical"] = "rbxassetid://10709753808",
	["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
	["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
	["lucide-align-justify"] = "rbxassetid://10709759610",
	["lucide-align-left"] = "rbxassetid://10709759764",
	["lucide-align-right"] = "rbxassetid://10709759895",
	["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
	["lucide-align-start-vertical"] = "rbxassetid://10709760244",
	["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
	["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
	["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
	["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
	["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
	["lucide-anchor"] = "rbxassetid://10709761530",
	["lucide-angry"] = "rbxassetid://10709761629",
	["lucide-annoyed"] = "rbxassetid://10709761722",
	["lucide-aperture"] = "rbxassetid://10709761813",
	["lucide-apple"] = "rbxassetid://10709761889",
	["lucide-archive"] = "rbxassetid://10709762233",
	["lucide-archive-restore"] = "rbxassetid://10709762058",
	["lucide-armchair"] = "rbxassetid://10709762327",
	["lucide-anvil"] = "rbxassetid://77943964625400",
	["lucide-arrow-big-down"] = "rbxassetid://10747796644",
	["lucide-arrow-big-left"] = "rbxassetid://10709762574",
	["lucide-arrow-big-right"] = "rbxassetid://10709762727",
	["lucide-arrow-big-up"] = "rbxassetid://10709762879",
	["lucide-arrow-down"] = "rbxassetid://10709767827",
	["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
	["lucide-arrow-down-left"] = "rbxassetid://10709767656",
	["lucide-arrow-down-right"] = "rbxassetid://10709767750",
	["lucide-arrow-left"] = "rbxassetid://10709768114",
	["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
	["lucide-arrow-left-right"] = "rbxassetid://10709768019",
	["lucide-arrow-right"] = "rbxassetid://10709768347",
	["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
	["lucide-arrow-up"] = "rbxassetid://10709768939",
	["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
	["lucide-arrow-up-down"] = "rbxassetid://10709768538",
	["lucide-arrow-up-left"] = "rbxassetid://10709768661",
	["lucide-arrow-up-right"] = "rbxassetid://10709768787",
	["lucide-asterisk"] = "rbxassetid://10709769095",
	["lucide-at-sign"] = "rbxassetid://10709769286",
	["lucide-award"] = "rbxassetid://10709769406",
	["lucide-axe"] = "rbxassetid://10709769508",
	["lucide-axis-3d"] = "rbxassetid://10709769598",
	["lucide-baby"] = "rbxassetid://10709769732",
	["lucide-backpack"] = "rbxassetid://10709769841",
	["lucide-baggage-claim"] = "rbxassetid://10709769935",
	["lucide-banana"] = "rbxassetid://10709770005",
	["lucide-banknote"] = "rbxassetid://10709770178",
	["lucide-bar-chart"] = "rbxassetid://10709773755",
	["lucide-bar-chart-2"] = "rbxassetid://10709770317",
	["lucide-bar-chart-3"] = "rbxassetid://10709770431",
	["lucide-bar-chart-4"] = "rbxassetid://10709770560",
	["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
	["lucide-barcode"] = "rbxassetid://10747360675",
	["lucide-baseline"] = "rbxassetid://10709773863",
	["lucide-bath"] = "rbxassetid://10709773963",
	["lucide-battery"] = "rbxassetid://10709774640",
	["lucide-battery-charging"] = "rbxassetid://10709774068",
	["lucide-battery-full"] = "rbxassetid://10709774206",
	["lucide-battery-low"] = "rbxassetid://10709774370",
	["lucide-battery-medium"] = "rbxassetid://10709774513",
	["lucide-beaker"] = "rbxassetid://10709774756",
	["lucide-bed"] = "rbxassetid://10709775036",
	["lucide-bed-double"] = "rbxassetid://10709774864",
	["lucide-bed-single"] = "rbxassetid://10709774968",
	["lucide-beer"] = "rbxassetid://10709775167",
	["lucide-bell"] = "rbxassetid://10709775704",
	["lucide-bell-minus"] = "rbxassetid://10709775241",
	["lucide-bell-off"] = "rbxassetid://10709775320",
	["lucide-bell-plus"] = "rbxassetid://10709775448",
	["lucide-bell-ring"] = "rbxassetid://10709775560",
	["lucide-bike"] = "rbxassetid://10709775894",
	["lucide-binary"] = "rbxassetid://10709776050",
	["lucide-bitcoin"] = "rbxassetid://10709776126",
	["lucide-bluetooth"] = "rbxassetid://10709776655",
	["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
	["lucide-bluetooth-off"] = "rbxassetid://10709776344",
	["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
	["lucide-bold"] = "rbxassetid://10747813908",
	["lucide-bomb"] = "rbxassetid://10709781460",
	["lucide-bone"] = "rbxassetid://10709781605",
	["lucide-book"] = "rbxassetid://10709781824",
	["lucide-book-open"] = "rbxassetid://10709781717",
	["lucide-bookmark"] = "rbxassetid://10709782154",
	["lucide-bookmark-minus"] = "rbxassetid://10709781919",
	["lucide-bookmark-plus"] = "rbxassetid://10709782044",
	["lucide-bot"] = "rbxassetid://10709782230",
	["lucide-box"] = "rbxassetid://10709782497",
	["lucide-box-select"] = "rbxassetid://10709782342",
	["lucide-boxes"] = "rbxassetid://10709782582",
	["lucide-briefcase"] = "rbxassetid://10709782662",
	["lucide-brush"] = "rbxassetid://10709782758",
	["lucide-bug"] = "rbxassetid://10709782845",
	["lucide-building"] = "rbxassetid://10709783051",
	["lucide-building-2"] = "rbxassetid://10709782939",
	["lucide-bus"] = "rbxassetid://10709783137",
	["lucide-cake"] = "rbxassetid://10709783217",
	["lucide-calculator"] = "rbxassetid://10709783311",
	["lucide-calendar"] = "rbxassetid://10709789505",
	["lucide-calendar-check"] = "rbxassetid://10709783474",
	["lucide-calendar-check-2"] = "rbxassetid://10709783392",
	["lucide-calendar-clock"] = "rbxassetid://10709783577",
	["lucide-calendar-days"] = "rbxassetid://10709783673",
	["lucide-calendar-heart"] = "rbxassetid://10709783835",
	["lucide-calendar-minus"] = "rbxassetid://10709783959",
	["lucide-calendar-off"] = "rbxassetid://10709788784",
	["lucide-calendar-plus"] = "rbxassetid://10709788937",
	["lucide-calendar-range"] = "rbxassetid://10709789053",
	["lucide-calendar-search"] = "rbxassetid://10709789200",
	["lucide-calendar-x"] = "rbxassetid://10709789407",
	["lucide-calendar-x-2"] = "rbxassetid://10709789329",
	["lucide-camera"] = "rbxassetid://10709789686",
	["lucide-camera-off"] = "rbxassetid://10747822677",
	["lucide-car"] = "rbxassetid://10709789810",
	["lucide-carrot"] = "rbxassetid://10709789960",
	["lucide-cast"] = "rbxassetid://10709790097",
	["lucide-charge"] = "rbxassetid://10709790202",
	["lucide-check"] = "rbxassetid://10709790644",
	["lucide-check-circle"] = "rbxassetid://10709790387",
	["lucide-check-circle-2"] = "rbxassetid://10709790298",
	["lucide-check-square"] = "rbxassetid://10709790537",
	["lucide-chef-hat"] = "rbxassetid://10709790757",
	["lucide-cherry"] = "rbxassetid://10709790875",
	["lucide-chevron-down"] = "rbxassetid://10709790948",
	["lucide-chevron-first"] = "rbxassetid://10709791015",
	["lucide-chevron-last"] = "rbxassetid://10709791130",
	["lucide-chevron-left"] = "rbxassetid://10709791281",
	["lucide-chevron-right"] = "rbxassetid://10709791437",
	["lucide-chevron-up"] = "rbxassetid://10709791523",
	["lucide-chevrons-down"] = "rbxassetid://10709796864",
	["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
	["lucide-chevrons-left"] = "rbxassetid://10709797151",
	["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
	["lucide-chevrons-right"] = "rbxassetid://10709797382",
	["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
	["lucide-chevrons-up"] = "rbxassetid://10709797622",
	["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
	["lucide-chrome"] = "rbxassetid://10709797725",
	["lucide-circle"] = "rbxassetid://10709798174",
	["lucide-circle-dot"] = "rbxassetid://10709797837",
	["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
	["lucide-circle-slashed"] = "rbxassetid://10709798100",
	["lucide-citrus"] = "rbxassetid://10709798276",
	["lucide-clapperboard"] = "rbxassetid://10709798350",
	["lucide-clipboard"] = "rbxassetid://10709799288",
	["lucide-clipboard-check"] = "rbxassetid://10709798443",
	["lucide-clipboard-copy"] = "rbxassetid://10709798574",
	["lucide-clipboard-edit"] = "rbxassetid://10709798682",
	["lucide-clipboard-list"] = "rbxassetid://10709798792",
	["lucide-clipboard-signature"] = "rbxassetid://10709798890",
	["lucide-clipboard-type"] = "rbxassetid://10709798999",
	["lucide-clipboard-x"] = "rbxassetid://10709799124",
	["lucide-clock"] = "rbxassetid://10709805144",
	["lucide-clock-1"] = "rbxassetid://10709799535",
	["lucide-clock-10"] = "rbxassetid://10709799718",
	["lucide-clock-11"] = "rbxassetid://10709799818",
	["lucide-clock-12"] = "rbxassetid://10709799962",
	["lucide-clock-2"] = "rbxassetid://10709803876",
	["lucide-clock-3"] = "rbxassetid://10709803989",
	["lucide-clock-4"] = "rbxassetid://10709804164",
	["lucide-clock-5"] = "rbxassetid://10709804291",
	["lucide-clock-6"] = "rbxassetid://10709804435",
	["lucide-clock-7"] = "rbxassetid://10709804599",
	["lucide-clock-8"] = "rbxassetid://10709804784",
	["lucide-clock-9"] = "rbxassetid://10709804996",
	["lucide-cloud"] = "rbxassetid://10709806740",
	["lucide-cloud-cog"] = "rbxassetid://10709805262",
	["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
	["lucide-cloud-fog"] = "rbxassetid://10709805477",
	["lucide-cloud-hail"] = "rbxassetid://10709805596",
	["lucide-cloud-lightning"] = "rbxassetid://10709805727",
	["lucide-cloud-moon"] = "rbxassetid://10709805942",
	["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
	["lucide-cloud-off"] = "rbxassetid://10709806060",
	["lucide-cloud-rain"] = "rbxassetid://10709806277",
	["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
	["lucide-cloud-snow"] = "rbxassetid://10709806374",
	["lucide-cloud-sun"] = "rbxassetid://10709806631",
	["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
	["lucide-cloudy"] = "rbxassetid://10709806859",
	["lucide-clover"] = "rbxassetid://10709806995",
	["lucide-code"] = "rbxassetid://10709810463",
	["lucide-code-2"] = "rbxassetid://10709807111",
	["lucide-codepen"] = "rbxassetid://10709810534",
	["lucide-codesandbox"] = "rbxassetid://10709810676",
	["lucide-coffee"] = "rbxassetid://10709810814",
	["lucide-cog"] = "rbxassetid://10709810948",
	["lucide-coins"] = "rbxassetid://10709811110",
	["lucide-columns"] = "rbxassetid://10709811261",
	["lucide-command"] = "rbxassetid://10709811365",
	["lucide-compass"] = "rbxassetid://10709811445",
	["lucide-component"] = "rbxassetid://10709811595",
	["lucide-concierge-bell"] = "rbxassetid://10709811706",
	["lucide-connection"] = "rbxassetid://10747361219",
	["lucide-contact"] = "rbxassetid://10709811834",
	["lucide-contrast"] = "rbxassetid://10709811939",
	["lucide-cookie"] = "rbxassetid://10709812067",
	["lucide-copy"] = "rbxassetid://10709812159",
	["lucide-copyleft"] = "rbxassetid://10709812251",
	["lucide-copyright"] = "rbxassetid://10709812311",
	["lucide-corner-down-left"] = "rbxassetid://10709812396",
	["lucide-corner-down-right"] = "rbxassetid://10709812485",
	["lucide-corner-left-down"] = "rbxassetid://10709812632",
	["lucide-corner-left-up"] = "rbxassetid://10709812784",
	["lucide-corner-right-down"] = "rbxassetid://10709812939",
	["lucide-corner-right-up"] = "rbxassetid://10709813094",
	["lucide-corner-up-left"] = "rbxassetid://10709813185",
	["lucide-corner-up-right"] = "rbxassetid://10709813281",
	["lucide-cpu"] = "rbxassetid://10709813383",
	["lucide-croissant"] = "rbxassetid://10709818125",
	["lucide-crop"] = "rbxassetid://10709818245",
	["lucide-cross"] = "rbxassetid://10709818399",
	["lucide-crosshair"] = "rbxassetid://10709818534",
	["lucide-crown"] = "rbxassetid://10709818626",
	["lucide-cup-soda"] = "rbxassetid://10709818763",
	["lucide-curly-braces"] = "rbxassetid://10709818847",
	["lucide-currency"] = "rbxassetid://10709818931",
	["lucide-container"] = "rbxassetid://17466205552",
	["lucide-database"] = "rbxassetid://10709818996",
	["lucide-delete"] = "rbxassetid://10709819059",
	["lucide-diamond"] = "rbxassetid://10709819149",
	["lucide-dice-1"] = "rbxassetid://10709819266",
	["lucide-dice-2"] = "rbxassetid://10709819361",
	["lucide-dice-3"] = "rbxassetid://10709819508",
	["lucide-dice-4"] = "rbxassetid://10709819670",
	["lucide-dice-5"] = "rbxassetid://10709819801",
	["lucide-dice-6"] = "rbxassetid://10709819896",
	["lucide-dices"] = "rbxassetid://10723343321",
	["lucide-diff"] = "rbxassetid://10723343416",
	["lucide-disc"] = "rbxassetid://10723343537",
	["lucide-divide"] = "rbxassetid://10723343805",
	["lucide-divide-circle"] = "rbxassetid://10723343636",
	["lucide-divide-square"] = "rbxassetid://10723343737",
	["lucide-dollar-sign"] = "rbxassetid://10723343958",
	["lucide-download"] = "rbxassetid://10723344270",
	["lucide-download-cloud"] = "rbxassetid://10723344088",
	["lucide-door-open"] = "rbxassetid://124179241653522",
	["lucide-droplet"] = "rbxassetid://10723344432",
	["lucide-droplets"] = "rbxassetid://10734883356",
	["lucide-drumstick"] = "rbxassetid://10723344737",
	["lucide-edit"] = "rbxassetid://10734883598",
	["lucide-edit-2"] = "rbxassetid://10723344885",
	["lucide-edit-3"] = "rbxassetid://10723345088",
	["lucide-egg"] = "rbxassetid://10723345518",
	["lucide-egg-fried"] = "rbxassetid://10723345347",
	["lucide-electricity"] = "rbxassetid://10723345749",
	["lucide-electricity-off"] = "rbxassetid://10723345643",
	["lucide-equal"] = "rbxassetid://10723345990",
	["lucide-equal-not"] = "rbxassetid://10723345866",
	["lucide-eraser"] = "rbxassetid://10723346158",
	["lucide-euro"] = "rbxassetid://10723346372",
	["lucide-expand"] = "rbxassetid://10723346553",
	["lucide-external-link"] = "rbxassetid://10723346684",
	["lucide-eye"] = "rbxassetid://10723346959",
	["lucide-eye-off"] = "rbxassetid://10723346871",
	["lucide-factory"] = "rbxassetid://10723347051",
	["lucide-fan"] = "rbxassetid://10723354359",
	["lucide-fast-forward"] = "rbxassetid://10723354521",
	["lucide-feather"] = "rbxassetid://10723354671",
	["lucide-figma"] = "rbxassetid://10723354801",
	["lucide-file"] = "rbxassetid://10723374641",
	["lucide-file-archive"] = "rbxassetid://10723354921",
	["lucide-file-audio"] = "rbxassetid://10723355148",
	["lucide-file-audio-2"] = "rbxassetid://10723355026",
	["lucide-file-axis-3d"] = "rbxassetid://10723355272",
	["lucide-file-badge"] = "rbxassetid://10723355622",
	["lucide-file-badge-2"] = "rbxassetid://10723355451",
	["lucide-file-bar-chart"] = "rbxassetid://10723355887",
	["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
	["lucide-file-box"] = "rbxassetid://10723355989",
	["lucide-file-check"] = "rbxassetid://10723356210",
	["lucide-file-check-2"] = "rbxassetid://10723356100",
	["lucide-file-clock"] = "rbxassetid://10723356329",
	["lucide-file-code"] = "rbxassetid://10723356507",
	["lucide-file-cog"] = "rbxassetid://10723356830",
	["lucide-file-cog-2"] = "rbxassetid://10723356676",
	["lucide-file-diff"] = "rbxassetid://10723357039",
	["lucide-file-digit"] = "rbxassetid://10723357151",
	["lucide-file-down"] = "rbxassetid://10723357322",
	["lucide-file-edit"] = "rbxassetid://10723357495",
	["lucide-file-heart"] = "rbxassetid://10723357637",
	["lucide-file-image"] = "rbxassetid://10723357790",
	["lucide-file-input"] = "rbxassetid://10723357933",
	["lucide-file-json"] = "rbxassetid://10723364435",
	["lucide-file-json-2"] = "rbxassetid://10723364361",
	["lucide-file-key"] = "rbxassetid://10723364605",
	["lucide-file-key-2"] = "rbxassetid://10723364515",
	["lucide-file-line-chart"] = "rbxassetid://10723364725",
	["lucide-file-lock"] = "rbxassetid://10723364957",
	["lucide-file-lock-2"] = "rbxassetid://10723364861",
	["lucide-file-minus"] = "rbxassetid://10723365254",
	["lucide-file-minus-2"] = "rbxassetid://10723365086",
	["lucide-file-output"] = "rbxassetid://10723365457",
	["lucide-file-pie-chart"] = "rbxassetid://10723365598",
	["lucide-file-plus"] = "rbxassetid://10723365877",
	["lucide-file-plus-2"] = "rbxassetid://10723365766",
	["lucide-file-question"] = "rbxassetid://10723365987",
	["lucide-file-scan"] = "rbxassetid://10723366167",
	["lucide-file-search"] = "rbxassetid://10723366550",
	["lucide-file-search-2"] = "rbxassetid://10723366340",
	["lucide-file-signature"] = "rbxassetid://10723366741",
	["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
	["lucide-file-symlink"] = "rbxassetid://10723367098",
	["lucide-file-terminal"] = "rbxassetid://10723367244",
	["lucide-file-text"] = "rbxassetid://10723367380",
	["lucide-file-type"] = "rbxassetid://10723367606",
	["lucide-file-type-2"] = "rbxassetid://10723367509",
	["lucide-file-up"] = "rbxassetid://10723367734",
	["lucide-file-video"] = "rbxassetid://10723373884",
	["lucide-file-video-2"] = "rbxassetid://10723367834",
	["lucide-file-volume"] = "rbxassetid://10723374172",
	["lucide-file-volume-2"] = "rbxassetid://10723374030",
	["lucide-file-warning"] = "rbxassetid://10723374276",
	["lucide-file-x"] = "rbxassetid://10723374544",
	["lucide-file-x-2"] = "rbxassetid://10723374378",
	["lucide-files"] = "rbxassetid://10723374759",
	["lucide-film"] = "rbxassetid://10723374981",
	["lucide-filter"] = "rbxassetid://10723375128",
	["lucide-fingerprint"] = "rbxassetid://10723375250",
	["lucide-flag"] = "rbxassetid://10723375890",
	["lucide-flag-off"] = "rbxassetid://10723375443",
	["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
	["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
	["lucide-flame"] = "rbxassetid://10723376114",
	["lucide-flashlight"] = "rbxassetid://10723376471",
	["lucide-flashlight-off"] = "rbxassetid://10723376365",
	["lucide-flask-conical"] = "rbxassetid://10734883986",
	["lucide-flask-round"] = "rbxassetid://10723376614",
	["lucide-flip-horizontal"] = "rbxassetid://10723376884",
	["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
	["lucide-flip-vertical"] = "rbxassetid://10723377138",
	["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
	["lucide-flower"] = "rbxassetid://10747830374",
	["lucide-flower-2"] = "rbxassetid://10723377305",
	["lucide-focus"] = "rbxassetid://10723377537",
	["lucide-folder"] = "rbxassetid://10723387563",
	["lucide-folder-archive"] = "rbxassetid://10723384478",
	["lucide-folder-check"] = "rbxassetid://10723384605",
	["lucide-folder-clock"] = "rbxassetid://10723384731",
	["lucide-folder-closed"] = "rbxassetid://10723384893",
	["lucide-folder-cog"] = "rbxassetid://10723385213",
	["lucide-folder-cog-2"] = "rbxassetid://10723385036",
	["lucide-folder-down"] = "rbxassetid://10723385338",
	["lucide-folder-edit"] = "rbxassetid://10723385445",
	["lucide-folder-heart"] = "rbxassetid://10723385545",
	["lucide-folder-input"] = "rbxassetid://10723385721",
	["lucide-folder-key"] = "rbxassetid://10723385848",
	["lucide-folder-lock"] = "rbxassetid://10723386005",
	["lucide-folder-minus"] = "rbxassetid://10723386127",
	["lucide-folder-open"] = "rbxassetid://10723386277",
	["lucide-folder-output"] = "rbxassetid://10723386386",
	["lucide-folder-plus"] = "rbxassetid://10723386531",
	["lucide-folder-search"] = "rbxassetid://10723386787",
	["lucide-folder-search-2"] = "rbxassetid://10723386674",
	["lucide-folder-symlink"] = "rbxassetid://10723386930",
	["lucide-folder-tree"] = "rbxassetid://10723387085",
	["lucide-folder-up"] = "rbxassetid://10723387265",
	["lucide-folder-x"] = "rbxassetid://10723387448",
	["lucide-folders"] = "rbxassetid://10723387721",
	["lucide-form-input"] = "rbxassetid://10723387841",
	["lucide-forward"] = "rbxassetid://10723388016",
	["lucide-frame"] = "rbxassetid://10723394389",
	["lucide-framer"] = "rbxassetid://10723394565",
	["lucide-frown"] = "rbxassetid://10723394681",
	["lucide-fuel"] = "rbxassetid://10723394846",
	["lucide-function-square"] = "rbxassetid://10723395041",
	["lucide-gamepad"] = "rbxassetid://10723395457",
	["lucide-gamepad-2"] = "rbxassetid://10723395215",
	["lucide-gauge"] = "rbxassetid://10723395708",
	["lucide-gavel"] = "rbxassetid://10723395896",
	["lucide-gem"] = "rbxassetid://10723396000",
	["lucide-ghost"] = "rbxassetid://10723396107",
	["lucide-gift"] = "rbxassetid://10723396402",
	["lucide-gift-card"] = "rbxassetid://10723396225",
	["lucide-git-branch"] = "rbxassetid://10723396676",
	["lucide-git-branch-plus"] = "rbxassetid://10723396542",
	["lucide-git-commit"] = "rbxassetid://10723396812",
	["lucide-git-compare"] = "rbxassetid://10723396954",
	["lucide-git-fork"] = "rbxassetid://10723397049",
	["lucide-git-merge"] = "rbxassetid://10723397165",
	["lucide-git-pull-request"] = "rbxassetid://10723397431",
	["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
	["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
	["lucide-glass"] = "rbxassetid://10723397788",
	["lucide-glass-2"] = "rbxassetid://10723397529",
	["lucide-glass-water"] = "rbxassetid://10723397678",
	["lucide-glasses"] = "rbxassetid://10723397895",
	["lucide-globe"] = "rbxassetid://10723404337",
	["lucide-globe-2"] = "rbxassetid://10723398002",
	["lucide-grab"] = "rbxassetid://10723404472",
	["lucide-graduation-cap"] = "rbxassetid://10723404691",
	["lucide-grape"] = "rbxassetid://10723404822",
	["lucide-grid"] = "rbxassetid://10723404936",
	["lucide-grip-horizontal"] = "rbxassetid://10723405089",
	["lucide-grip-vertical"] = "rbxassetid://10723405236",
	["lucide-hammer"] = "rbxassetid://10723405360",
	["lucide-hand"] = "rbxassetid://10723405649",
	["lucide-hand-metal"] = "rbxassetid://10723405508",
	["lucide-hard-drive"] = "rbxassetid://10723405749",
	["lucide-hard-hat"] = "rbxassetid://10723405859",
	["lucide-hash"] = "rbxassetid://10723405975",
	["lucide-haze"] = "rbxassetid://10723406078",
	["lucide-headphones"] = "rbxassetid://10723406165",
	["lucide-heart"] = "rbxassetid://10723406885",
	["lucide-heart-crack"] = "rbxassetid://10723406299",
	["lucide-heart-handshake"] = "rbxassetid://10723406480",
	["lucide-heart-off"] = "rbxassetid://10723406662",
	["lucide-heart-pulse"] = "rbxassetid://10723406795",
	["lucide-help-circle"] = "rbxassetid://10723406988",
	["lucide-hexagon"] = "rbxassetid://10723407092",
	["lucide-highlighter"] = "rbxassetid://10723407192",
	["lucide-history"] = "rbxassetid://10723407335",
	["lucide-home"] = "rbxassetid://10723407389",
	["lucide-hourglass"] = "rbxassetid://10723407498",
	["lucide-ice-cream"] = "rbxassetid://10723414308",
	["lucide-image"] = "rbxassetid://10723415040",
	["lucide-image-minus"] = "rbxassetid://10723414487",
	["lucide-image-off"] = "rbxassetid://10723414677",
	["lucide-image-plus"] = "rbxassetid://10723414827",
	["lucide-import"] = "rbxassetid://10723415205",
	["lucide-inbox"] = "rbxassetid://10723415335",
	["lucide-indent"] = "rbxassetid://10723415494",
	["lucide-indian-rupee"] = "rbxassetid://10723415642",
	["lucide-infinity"] = "rbxassetid://10723415766",
	["lucide-info"] = "rbxassetid://10723415903",
	["lucide-inspect"] = "rbxassetid://10723416057",
	["lucide-italic"] = "rbxassetid://10723416195",
	["lucide-japanese-yen"] = "rbxassetid://10723416363",
	["lucide-joystick"] = "rbxassetid://10723416527",
	["lucide-key"] = "rbxassetid://10723416652",
	["lucide-keyboard"] = "rbxassetid://10723416765",
	["lucide-lamp"] = "rbxassetid://10723417513",
	["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
	["lucide-lamp-desk"] = "rbxassetid://10723417016",
	["lucide-lamp-floor"] = "rbxassetid://10723417131",
	["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
	["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
	["lucide-landmark"] = "rbxassetid://10723417608",
	["lucide-languages"] = "rbxassetid://10723417703",
	["lucide-laptop"] = "rbxassetid://10723423881",
	["lucide-laptop-2"] = "rbxassetid://10723417797",
	["lucide-lasso"] = "rbxassetid://10723424235",
	["lucide-lasso-select"] = "rbxassetid://10723424058",
	["lucide-laugh"] = "rbxassetid://10723424372",
	["lucide-layers"] = "rbxassetid://10723424505",
	["lucide-layout"] = "rbxassetid://10723425376",
	["lucide-layout-dashboard"] = "rbxassetid://10723424646",
	["lucide-layout-grid"] = "rbxassetid://10723424838",
	["lucide-layout-list"] = "rbxassetid://10723424963",
	["lucide-layout-template"] = "rbxassetid://10723425187",
	["lucide-leaf"] = "rbxassetid://10723425539",
	["lucide-library"] = "rbxassetid://10723425615",
	["lucide-life-buoy"] = "rbxassetid://10723425685",
	["lucide-lightbulb"] = "rbxassetid://10723425852",
	["lucide-lightbulb-off"] = "rbxassetid://10723425762",
	["lucide-line-chart"] = "rbxassetid://10723426393",
	["lucide-link"] = "rbxassetid://10723426722",
	["lucide-link-2"] = "rbxassetid://10723426595",
	["lucide-link-2-off"] = "rbxassetid://10723426513",
	["lucide-list"] = "rbxassetid://10723433811",
	["lucide-list-checks"] = "rbxassetid://10734884548",
	["lucide-list-end"] = "rbxassetid://10723426886",
	["lucide-list-minus"] = "rbxassetid://10723426986",
	["lucide-list-music"] = "rbxassetid://10723427081",
	["lucide-list-ordered"] = "rbxassetid://10723427199",
	["lucide-list-plus"] = "rbxassetid://10723427334",
	["lucide-list-start"] = "rbxassetid://10723427494",
	["lucide-list-video"] = "rbxassetid://10723427619",
	["lucide-list-todo"] = "rbxassetid://17376008003",
	["lucide-list-x"] = "rbxassetid://10723433655",
	["lucide-loader"] = "rbxassetid://10723434070",
	["lucide-loader-2"] = "rbxassetid://10723433935",
	["lucide-locate"] = "rbxassetid://10723434557",
	["lucide-locate-fixed"] = "rbxassetid://10723434236",
	["lucide-locate-off"] = "rbxassetid://10723434379",
	["lucide-lock"] = "rbxassetid://10723434711",
	["lucide-log-in"] = "rbxassetid://10723434830",
	["lucide-log-out"] = "rbxassetid://10723434906",
	["lucide-luggage"] = "rbxassetid://10723434993",
	["lucide-magnet"] = "rbxassetid://10723435069",
	["lucide-mail"] = "rbxassetid://10734885430",
	["lucide-mail-check"] = "rbxassetid://10723435182",
	["lucide-mail-minus"] = "rbxassetid://10723435261",
	["lucide-mail-open"] = "rbxassetid://10723435342",
	["lucide-mail-plus"] = "rbxassetid://10723435443",
	["lucide-mail-question"] = "rbxassetid://10723435515",
	["lucide-mail-search"] = "rbxassetid://10734884739",
	["lucide-mail-warning"] = "rbxassetid://10734885015",
	["lucide-mail-x"] = "rbxassetid://10734885247",
	["lucide-mails"] = "rbxassetid://10734885614",
	["lucide-map"] = "rbxassetid://10734886202",
	["lucide-map-pin"] = "rbxassetid://10734886004",
	["lucide-map-pin-off"] = "rbxassetid://10734885803",
	["lucide-maximize"] = "rbxassetid://10734886735",
	["lucide-maximize-2"] = "rbxassetid://10734886496",
	["lucide-medal"] = "rbxassetid://10734887072",
	["lucide-megaphone"] = "rbxassetid://10734887454",
	["lucide-megaphone-off"] = "rbxassetid://10734887311",
	["lucide-meh"] = "rbxassetid://10734887603",
	["lucide-menu"] = "rbxassetid://10734887784",
	["lucide-message-circle"] = "rbxassetid://10734888000",
	["lucide-message-square"] = "rbxassetid://10734888228",
	["lucide-mic"] = "rbxassetid://10734888864",
	["lucide-mic-2"] = "rbxassetid://10734888430",
	["lucide-mic-off"] = "rbxassetid://10734888646",
	["lucide-microscope"] = "rbxassetid://10734889106",
	["lucide-microwave"] = "rbxassetid://10734895076",
	["lucide-milestone"] = "rbxassetid://10734895310",
	["lucide-minimize"] = "rbxassetid://10734895698",
	["lucide-minimize-2"] = "rbxassetid://10734895530",
	["lucide-minus"] = "rbxassetid://10734896206",
	["lucide-minus-circle"] = "rbxassetid://10734895856",
	["lucide-minus-square"] = "rbxassetid://10734896029",
	["lucide-monitor"] = "rbxassetid://10734896881",
	["lucide-monitor-off"] = "rbxassetid://10734896360",
	["lucide-monitor-speaker"] = "rbxassetid://10734896512",
	["lucide-moon"] = "rbxassetid://10734897102",
	["lucide-more-horizontal"] = "rbxassetid://10734897250",
	["lucide-more-vertical"] = "rbxassetid://10734897387",
	["lucide-mountain"] = "rbxassetid://10734897956",
	["lucide-mountain-snow"] = "rbxassetid://10734897665",
	["lucide-mouse"] = "rbxassetid://10734898592",
	["lucide-mouse-pointer"] = "rbxassetid://10734898476",
	["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
	["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
	["lucide-move"] = "rbxassetid://10734900011",
	["lucide-move-3d"] = "rbxassetid://10734898756",
	["lucide-move-diagonal"] = "rbxassetid://10734899164",
	["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
	["lucide-move-horizontal"] = "rbxassetid://10734899414",
	["lucide-move-vertical"] = "rbxassetid://10734899821",
	["lucide-music"] = "rbxassetid://10734905958",
	["lucide-music-2"] = "rbxassetid://10734900215",
	["lucide-music-3"] = "rbxassetid://10734905665",
	["lucide-music-4"] = "rbxassetid://10734905823",
	["lucide-navigation"] = "rbxassetid://10734906744",
	["lucide-navigation-2"] = "rbxassetid://10734906332",
	["lucide-navigation-2-off"] = "rbxassetid://10734906144",
	["lucide-navigation-off"] = "rbxassetid://10734906580",
	["lucide-network"] = "rbxassetid://10734906975",
	["lucide-newspaper"] = "rbxassetid://10734907168",
	["lucide-octagon"] = "rbxassetid://10734907361",
	["lucide-option"] = "rbxassetid://10734907649",
	["lucide-outdent"] = "rbxassetid://10734907933",
	["lucide-package"] = "rbxassetid://10734909540",
	["lucide-package-2"] = "rbxassetid://10734908151",
	["lucide-package-check"] = "rbxassetid://10734908384",
	["lucide-package-minus"] = "rbxassetid://10734908626",
	["lucide-package-open"] = "rbxassetid://10734908793",
	["lucide-package-plus"] = "rbxassetid://10734909016",
	["lucide-package-search"] = "rbxassetid://10734909196",
	["lucide-package-x"] = "rbxassetid://10734909375",
	["lucide-paint-bucket"] = "rbxassetid://10734909847",
	["lucide-paintbrush"] = "rbxassetid://10734910187",
	["lucide-paintbrush-2"] = "rbxassetid://10734910030",
	["lucide-palette"] = "rbxassetid://10734910430",
	["lucide-palmtree"] = "rbxassetid://10734910680",
	["lucide-paperclip"] = "rbxassetid://10734910927",
	["lucide-party-popper"] = "rbxassetid://10734918735",
	["lucide-pause"] = "rbxassetid://10734919336",
	["lucide-pause-circle"] = "rbxassetid://10735024209",
	["lucide-pause-octagon"] = "rbxassetid://10734919143",
	["lucide-pen-tool"] = "rbxassetid://10734919503",
	["lucide-pencil"] = "rbxassetid://10734919691",
	["lucide-percent"] = "rbxassetid://10734919919",
	["lucide-person-standing"] = "rbxassetid://10734920149",
	["lucide-phone"] = "rbxassetid://10734921524",
	["lucide-phone-call"] = "rbxassetid://10734920305",
	["lucide-phone-forwarded"] = "rbxassetid://10734920508",
	["lucide-phone-incoming"] = "rbxassetid://10734920694",
	["lucide-phone-missed"] = "rbxassetid://10734920845",
	["lucide-phone-off"] = "rbxassetid://10734921077",
	["lucide-phone-outgoing"] = "rbxassetid://10734921288",
	["lucide-pie-chart"] = "rbxassetid://10734921727",
	["lucide-piggy-bank"] = "rbxassetid://10734921935",
	["lucide-pin"] = "rbxassetid://10734922324",
	["lucide-pin-off"] = "rbxassetid://10734922180",
	["lucide-pipette"] = "rbxassetid://10734922497",
	["lucide-pizza"] = "rbxassetid://10734922774",
	["lucide-plane"] = "rbxassetid://10734922971",
	["lucide-plane-landing"] = "rbxassetid://17376029914",
	["lucide-play"] = "rbxassetid://10734923549",
	["lucide-play-circle"] = "rbxassetid://10734923214",
	["lucide-plus"] = "rbxassetid://10734924532",
	["lucide-plus-circle"] = "rbxassetid://10734923868",
	["lucide-plus-square"] = "rbxassetid://10734924219",
	["lucide-podcast"] = "rbxassetid://10734929553",
	["lucide-pointer"] = "rbxassetid://10734929723",
	["lucide-pound-sterling"] = "rbxassetid://10734929981",
	["lucide-power"] = "rbxassetid://10734930466",
	["lucide-power-off"] = "rbxassetid://10734930257",
	["lucide-printer"] = "rbxassetid://10734930632",
	["lucide-puzzle"] = "rbxassetid://10734930886",
	["lucide-quote"] = "rbxassetid://10734931234",
	["lucide-radio"] = "rbxassetid://10734931596",
	["lucide-radio-receiver"] = "rbxassetid://10734931402",
	["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
	["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
	["lucide-recycle"] = "rbxassetid://10734932295",
	["lucide-redo"] = "rbxassetid://10734932822",
	["lucide-redo-2"] = "rbxassetid://10734932586",
	["lucide-refresh-ccw"] = "rbxassetid://10734933056",
	["lucide-refresh-cw"] = "rbxassetid://10734933222",
	["lucide-refrigerator"] = "rbxassetid://10734933465",
	["lucide-regex"] = "rbxassetid://10734933655",
	["lucide-repeat"] = "rbxassetid://10734933966",
	["lucide-repeat-1"] = "rbxassetid://10734933826",
	["lucide-reply"] = "rbxassetid://10734934252",
	["lucide-reply-all"] = "rbxassetid://10734934132",
	["lucide-rewind"] = "rbxassetid://10734934347",
	["lucide-rocket"] = "rbxassetid://10734934585",
	["lucide-rocking-chair"] = "rbxassetid://10734939942",
	["lucide-rotate-3d"] = "rbxassetid://10734940107",
	["lucide-rotate-ccw"] = "rbxassetid://10734940376",
	["lucide-rotate-cw"] = "rbxassetid://10734940654",
	["lucide-rss"] = "rbxassetid://10734940825",
	["lucide-ruler"] = "rbxassetid://10734941018",
	["lucide-russian-ruble"] = "rbxassetid://10734941199",
	["lucide-sailboat"] = "rbxassetid://10734941354",
	["lucide-save"] = "rbxassetid://10734941499",
	["lucide-scale"] = "rbxassetid://10734941912",
	["lucide-scale-3d"] = "rbxassetid://10734941739",
	["lucide-scaling"] = "rbxassetid://10734942072",
	["lucide-scan"] = "rbxassetid://10734942565",
	["lucide-scan-face"] = "rbxassetid://10734942198",
	["lucide-scan-line"] = "rbxassetid://10734942351",
	["lucide-scissors"] = "rbxassetid://10734942778",
	["lucide-screen-share"] = "rbxassetid://10734943193",
	["lucide-screen-share-off"] = "rbxassetid://10734942967",
	["lucide-shell"] = "rbxassetid://83825045910816",
	["lucide-scroll"] = "rbxassetid://10734943448",
	["lucide-search"] = "rbxassetid://10734943674",
	["lucide-send"] = "rbxassetid://10734943902",
	["lucide-separator-horizontal"] = "rbxassetid://10734944115",
	["lucide-separator-vertical"] = "rbxassetid://10734944326",
	["lucide-server"] = "rbxassetid://10734949856",
	["lucide-server-cog"] = "rbxassetid://10734944444",
	["lucide-server-crash"] = "rbxassetid://10734944554",
	["lucide-server-off"] = "rbxassetid://10734944668",
	["lucide-settings"] = "rbxassetid://10734950309",
	["lucide-settings-2"] = "rbxassetid://10734950020",
	["lucide-share"] = "rbxassetid://10734950813",
	["lucide-share-2"] = "rbxassetid://10734950553",
	["lucide-sheet"] = "rbxassetid://10734951038",
	["lucide-shield"] = "rbxassetid://10734951847",
	["lucide-shield-alert"] = "rbxassetid://10734951173",
	["lucide-shield-check"] = "rbxassetid://10734951367",
	["lucide-shield-close"] = "rbxassetid://10734951535",
	["lucide-shield-off"] = "rbxassetid://10734951684",
	["lucide-shirt"] = "rbxassetid://10734952036",
	["lucide-shopping-bag"] = "rbxassetid://10734952273",
	["lucide-shopping-cart"] = "rbxassetid://10734952479",
	["lucide-shovel"] = "rbxassetid://10734952773",
	["lucide-shower-head"] = "rbxassetid://10734952942",
	["lucide-shrink"] = "rbxassetid://10734953073",
	["lucide-shrub"] = "rbxassetid://10734953241",
	["lucide-shuffle"] = "rbxassetid://10734953451",
	["lucide-sidebar"] = "rbxassetid://10734954301",
	["lucide-sidebar-close"] = "rbxassetid://10734953715",
	["lucide-sidebar-open"] = "rbxassetid://10734954000",
	["lucide-sigma"] = "rbxassetid://10734954538",
	["lucide-signal"] = "rbxassetid://10734961133",
	["lucide-signal-high"] = "rbxassetid://10734954807",
	["lucide-signal-low"] = "rbxassetid://10734955080",
	["lucide-signal-medium"] = "rbxassetid://10734955336",
	["lucide-signal-zero"] = "rbxassetid://10734960878",
	["lucide-siren"] = "rbxassetid://10734961284",
	["lucide-skip-back"] = "rbxassetid://10734961526",
	["lucide-skip-forward"] = "rbxassetid://10734961809",
	["lucide-skull"] = "rbxassetid://10734962068",
	["lucide-slack"] = "rbxassetid://10734962339",
	["lucide-slash"] = "rbxassetid://10734962600",
	["lucide-slice"] = "rbxassetid://10734963024",
	["lucide-sliders"] = "rbxassetid://10734963400",
	["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
	["lucide-smartphone"] = "rbxassetid://10734963940",
	["lucide-smartphone-charging"] = "rbxassetid://10734963671",
	["lucide-smile"] = "rbxassetid://10734964441",
	["lucide-smile-plus"] = "rbxassetid://10734964188",
	["lucide-snowflake"] = "rbxassetid://10734964600",
	["lucide-sofa"] = "rbxassetid://10734964852",
	["lucide-sort-asc"] = "rbxassetid://10734965115",
	["lucide-sort-desc"] = "rbxassetid://10734965287",
	["lucide-speaker"] = "rbxassetid://10734965419",
	["lucide-sprout"] = "rbxassetid://10734965572",
	["lucide-square"] = "rbxassetid://10734965702",
	["lucide-star"] = "rbxassetid://10734966248",
	["lucide-star-half"] = "rbxassetid://10734965897",
	["lucide-star-off"] = "rbxassetid://10734966097",
	["lucide-stethoscope"] = "rbxassetid://10734966384",
	["lucide-sticker"] = "rbxassetid://10734972234",
	["lucide-sticky-note"] = "rbxassetid://10734972463",
	["lucide-stop-circle"] = "rbxassetid://10734972621",
	["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
	["lucide-stretch-vertical"] = "rbxassetid://10734973130",
	["lucide-strikethrough"] = "rbxassetid://10734973290",
	["lucide-subscript"] = "rbxassetid://10734973457",
	["lucide-sun"] = "rbxassetid://10734974297",
	["lucide-sun-dim"] = "rbxassetid://10734973645",
	["lucide-sun-medium"] = "rbxassetid://10734973778",
	["lucide-sun-moon"] = "rbxassetid://10734973999",
	["lucide-sun-snow"] = "rbxassetid://10734974130",
	["lucide-sunrise"] = "rbxassetid://10734974522",
	["lucide-sunset"] = "rbxassetid://10734974689",
	["lucide-superscript"] = "rbxassetid://10734974850",
	["lucide-swiss-franc"] = "rbxassetid://10734975024",
	["lucide-switch-camera"] = "rbxassetid://10734975214",
	["lucide-sword"] = "rbxassetid://10734975486",
	["lucide-swords"] = "rbxassetid://10734975692",
	["lucide-syringe"] = "rbxassetid://10734975932",
	["lucide-table"] = "rbxassetid://10734976230",
	["lucide-table-2"] = "rbxassetid://10734976097",
	["lucide-tablet"] = "rbxassetid://10734976394",
	["lucide-tag"] = "rbxassetid://10734976528",
	["lucide-tags"] = "rbxassetid://10734976739",
	["lucide-target"] = "rbxassetid://10734977012",
	["lucide-tent"] = "rbxassetid://10734981750",
	["lucide-terminal"] = "rbxassetid://10734982144",
	["lucide-terminal-square"] = "rbxassetid://10734981995",
	["lucide-text-cursor"] = "rbxassetid://10734982395",
	["lucide-text-cursor-input"] = "rbxassetid://10734982297",
	["lucide-thermometer"] = "rbxassetid://10734983134",
	["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
	["lucide-thermometer-sun"] = "rbxassetid://10734982771",
	["lucide-thumbs-down"] = "rbxassetid://10734983359",
	["lucide-thumbs-up"] = "rbxassetid://10734983629",
	["lucide-ticket"] = "rbxassetid://10734983868",
	["lucide-timer"] = "rbxassetid://10734984606",
	["lucide-timer-off"] = "rbxassetid://10734984138",
	["lucide-timer-reset"] = "rbxassetid://10734984355",
	["lucide-toggle-left"] = "rbxassetid://10734984834",
	["lucide-toggle-right"] = "rbxassetid://10734985040",
	["lucide-tornado"] = "rbxassetid://10734985247",
	["lucide-toy-brick"] = "rbxassetid://10747361919",
	["lucide-train"] = "rbxassetid://10747362105",
	["lucide-trash"] = "rbxassetid://10747362393",
	["lucide-trash-2"] = "rbxassetid://10747362241",
	["lucide-tree-deciduous"] = "rbxassetid://10747362534",
	["lucide-tree-pine"] = "rbxassetid://10747362748",
	["lucide-trees"] = "rbxassetid://10747363016",
	["lucide-trending-down"] = "rbxassetid://10747363205",
	["lucide-trending-up"] = "rbxassetid://10747363465",
	["lucide-triangle"] = "rbxassetid://10747363621",
	["lucide-trophy"] = "rbxassetid://10747363809",
	["lucide-truck"] = "rbxassetid://10747364031",
	["lucide-tv"] = "rbxassetid://10747364593",
	["lucide-tv-2"] = "rbxassetid://10747364302",
	["lucide-type"] = "rbxassetid://10747364761",
	["lucide-umbrella"] = "rbxassetid://10747364971",
	["lucide-underline"] = "rbxassetid://10747365191",
	["lucide-undo"] = "rbxassetid://10747365484",
	["lucide-undo-2"] = "rbxassetid://10747365359",
	["lucide-unlink"] = "rbxassetid://10747365771",
	["lucide-unlink-2"] = "rbxassetid://10747397871",
	["lucide-unlock"] = "rbxassetid://10747366027",
	["lucide-upload"] = "rbxassetid://10747366434",
	["lucide-upload-cloud"] = "rbxassetid://10747366266",
	["lucide-usb"] = "rbxassetid://10747366606",
	["lucide-user"] = "rbxassetid://10747373176",
	["lucide-user-check"] = "rbxassetid://10747371901",
	["lucide-user-cog"] = "rbxassetid://10747372167",
	["lucide-user-minus"] = "rbxassetid://10747372346",
	["lucide-user-plus"] = "rbxassetid://10747372702",
	["lucide-user-x"] = "rbxassetid://10747372992",
	["lucide-users"] = "rbxassetid://10747373426",
	["lucide-utensils"] = "rbxassetid://10747373821",
	["lucide-utensils-crossed"] = "rbxassetid://10747373629",
	["lucide-venetian-mask"] = "rbxassetid://10747374003",
	["lucide-verified"] = "rbxassetid://10747374131",
	["lucide-vibrate"] = "rbxassetid://10747374489",
	["lucide-vibrate-off"] = "rbxassetid://10747374269",
	["lucide-video"] = "rbxassetid://10747374938",
	["lucide-video-off"] = "rbxassetid://10747374721",
	["lucide-view"] = "rbxassetid://10747375132",
	["lucide-voicemail"] = "rbxassetid://10747375281",
	["lucide-volume"] = "rbxassetid://10747376008",
	["lucide-volume-1"] = "rbxassetid://10747375450",
	["lucide-volume-2"] = "rbxassetid://10747375679",
	["lucide-volume-x"] = "rbxassetid://10747375880",
	["lucide-wheat"] = "rbxassetid://80877624162595",
	["lucide-wallet"] = "rbxassetid://10747376205",
	["lucide-wand"] = "rbxassetid://10747376565",
	["lucide-wand-2"] = "rbxassetid://10747376349",
	["lucide-watch"] = "rbxassetid://10747376722",
	["lucide-waves"] = "rbxassetid://10747376931",
	["lucide-webcam"] = "rbxassetid://10747381992",
	["lucide-wifi"] = "rbxassetid://10747382504",
	["lucide-wifi-off"] = "rbxassetid://10747382268",
	["lucide-wind"] = "rbxassetid://10747382750",
	["lucide-wrap-text"] = "rbxassetid://10747383065",
	["lucide-wrench"] = "rbxassetid://10747383470",
	["lucide-x"] = "rbxassetid://10747384394",
	["lucide-x-circle"] = "rbxassetid://10747383819",
	["lucide-x-octagon"] = "rbxassetid://10747384037",
	["lucide-x-square"] = "rbxassetid://10747384217",
	["lucide-zoom-in"] = "rbxassetid://10747384552",
	["lucide-zoom-out"] = "rbxassetid://10747384679",
	["lucide-cat"] = "rbxassetid://16935650691",
	["lucide-message-circle-question"] = "rbxassetid://16970049192",
	["lucide-webhook"] = "rbxassetid://17320556264",
	["lucide-dumbbell"] = "rbxassetid://18273453053"
}

function Library:GetIcon(Name)
	if Name ~= nil and Icons["lucide-" .. Name] then
		return Icons["lucide-" .. Name]
	end
	return nil
end

local Elements = {}
Elements.__index = Elements
Elements.__namecall = function(Table, Key, ...)
	return Elements[Key](...)
end

for _, ElementComponent in pairs(ElementsTable) do
	Elements["Add" .. ElementComponent.__type] = function(self, Idx, Config)
		ElementComponent.Container = self.Container
		ElementComponent.Type = self.Type
		ElementComponent.ScrollFrame = self.ScrollFrame
		ElementComponent.Library = Library

		return ElementComponent:New(Idx, Config)
	end
end

Library.Elements = Elements

if RunService:IsStudio() then
	makefolder = function(...) return ... end;
	makefile = function(...) return ... end;
	isfile = function(...) return ... end;
	isfolder = function(...) return ... end;
	readfile = function(...) return ... end;
	writefile = function(...) return ... end;
	listfiles = function (...) return {...} end;
end

local SaveManager = {} do
	SaveManager.Folder = "FluentSettings"
	SaveManager.Ignore = {}
	SaveManager.Parser = {
		Toggle = {
			Save = function(idx, object) 
				return { type = "Toggle", idx = idx, value = object.Value } 
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Slider = {
			Save = function(idx, object)
				return { type = "Slider", idx = idx, value = tostring(object.Value) }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Dropdown = {
			Save = function(idx, object)
				return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(idx, object)
				return { type = "Colorpicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(idx, object)
				return { type = "Keybind", idx = idx, mode = object.Mode, key = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.key, data.mode)
				end
			end,
		},

		Input = {
			Save = function(idx, object)
				return { type = "Input", idx = idx, text = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] and type(data.text) == "string" then
					SaveManager.Options[idx]:SetValue(data.text)
				end
			end,
		},
	}

	function SaveManager:SetIgnoreIndexes(list)
		for _, key in next, list do
			self.Ignore[key] = true
		end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	function SaveManager:Save(name)
		if (not name) then
			return false, "no config file is selected"
		end

		local fullPath = self.Folder .. "/" .. name .. ".json"

		local data = {
			objects = {}
		}

		for idx, option in next, SaveManager.Options do
			if not self.Parser[option.Type] then continue end
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		end	

		local success, encoded = pcall(httpService.JSONEncode, httpService, data)
		if not success then
			return false, "failed to encode data"
		end

		writefile(fullPath, encoded)
		return true
	end

	function SaveManager:Load(name)
		if (not name) then
			return false, "no config file is selected"
		end

		local file = self.Folder .. "/" .. name .. ".json"
		if not isfile(file) then return false, "Create Config Save File" end

		local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
		if not success then return false, "decode error" end

		for _, option in next, decoded.objects do
			if self.Parser[option.type] and not self.Ignore[option.idx] then
				task.spawn(function() self.Parser[option.type].Load(option.idx, option) end) -- task.spawn() so the config loading wont get stuck.
			end
		end

		Fluent.SettingLoaded = true

		return true, decoded
	end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"InterfaceTheme", "AcrylicToggle", "TransparentToggle", "MenuKeybind"
		})
	end

	function SaveManager:BuildFolderTree()
		local paths = {
			self.Folder,
			self.Folder .. "/"
		}

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function SaveManager:RefreshConfigList()
		local list = listfiles(self.Folder .. "/")

		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == ".json" then
				local pos = file:find(".json", 1, true)
				local start = pos

				local char = file:sub(pos, pos)
				while char ~= "/" and char ~= "\\" and char ~= "" do
					pos = pos - 1
					char = file:sub(pos, pos)
				end

				if char == "/" or char == "\\" then
					local name = file:sub(pos + 1, start - 1)
					if name ~= "options" then
						table.insert(out, name)
					end
				end
			end
		end

		return out
	end

	function SaveManager:SetLibrary(library)
		self.Library = library
		self.Options = library.Options
	end

	function SaveManager:LoadAutoloadConfig()
		if isfile(self.Folder .. "/autoload.txt") then
			local name = readfile(self.Folder .. "/autoload.txt")

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = "Failed to load autoload config: " .. err,
					Duration = 7
				})
			end

			self.Library:Notify({
				Title = "Interface",
				Content = "Config loader",
				SubContent = string.format("Auto loaded config %q", name),
				Duration = 7
			})
		end
	end

	function SaveManager:BuildConfigSection(tab)
		assert(self.Library, "Must set SaveManager.Library")

		local section = tab:AddSection("Configuration")

		section:AddInput("SaveManager_ConfigName",    { Title = "Config name" })
		section:AddDropdown(" ", { Title = "Config list", Values = self:RefreshConfigList(), AllowNull = true })

		section:AddButton({
			Title = "Create config",
			Callback = function()
				local name = SaveManager.Options.SaveManager_ConfigName.Value

				if name:gsub(" ", "") == "" then 
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "Invalid config name (empty)",
						Duration = 7
					})
				end

				local success, err = self:Save(name)
				if not success then
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "Failed to save config: " .. err,
						Duration = 7
					})
				end

				self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = string.format("Created config %q", name),
					Duration = 7
				})

				SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
				SaveManager.Options.SaveManager_ConfigList:SetValue(nil)
			end
		})

		section:AddButton({Title = "Load config", Callback = function()
			local name = SaveManager.Options.SaveManager_ConfigList.Value

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = "Failed to load config: " .. err,
					Duration = 7
				})
			end

			self.Library:Notify({
				Title = "Interface",
				Content = "Config loader",
				SubContent = string.format("Loaded config %q", name),
				Duration = 7
			})
		end})

		section:AddButton({Title = "Save config", Callback = function()
			local name = SaveManager.Options.SaveManager_ConfigList.Value

			local success, err = self:Save(name)
			if not success then
				return self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = "Failed to overwrite config: " .. err,
					Duration = 7
				})
			end

			self.Library:Notify({
				Title = "Interface",
				Content = "Config loader",
				SubContent = string.format("Overwrote config %q", name),
				Duration = 7
			})
		end})

		section:AddButton({Title = "Refresh list", Callback = function()
			SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			SaveManager.Options.SaveManager_ConfigList:SetValue(nil)
		end})

		local AutoloadButton
		AutoloadButton = section:AddButton({Title = "Set as autoload", Description = "Current autoload config: none", Callback = function()
			local name = SaveManager.Options.SaveManager_ConfigList.Value
			writefile(self.Folder .. "/autoload.txt", name)
			AutoloadButton:SetDesc("Current autoload config: " .. name)
			self.Library:Notify({
				Title = "Interface",
				Content = "Config loader",
				SubContent = string.format("Set %q to auto load", name),
				Duration = 7
			})
		end})

		if isfile(self.Folder .. "/autoload.txt") then
			local name = readfile(self.Folder .. "/autoload.txt")
			AutoloadButton:SetDesc("Current autoload config: " .. name)
		end

		SaveManager:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
	end

	-- SaveManager:BuildFolderTree()
end

local InterfaceManager = {} do
	InterfaceManager.Folder = "FluentSettings"
	InterfaceManager.Settings = {
		Acrylic = true,
		Transparency = true,
		MenuKeybind = "M"
	}

	function InterfaceManager:SetTheme(name)
		InterfaceManager.Settings.Theme = name
	end

	function InterfaceManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	function InterfaceManager:SetLibrary(library)
		self.Library = library
	end

	function InterfaceManager:BuildFolderTree()
		local paths = {}

		local parts = self.Folder:split("/")
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, "/", 1, idx)
		end

		table.insert(paths, self.Folder)
		table.insert(paths, self.Folder .. "/")

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function InterfaceManager:SaveSettings()
		writefile(self.Folder .. "/options.json", httpService:JSONEncode(InterfaceManager.Settings))
	end

	function InterfaceManager:LoadSettings()
		local path = self.Folder .. "/options.json"
		if isfile(path) then
			local data = readfile(path)
			local success, decoded = pcall(httpService.JSONDecode, httpService, data)

			if success then
				for i, v in next, decoded do
					InterfaceManager.Settings[i] = v
				end
			end
		end
	end

	function InterfaceManager:BuildInterfaceSection(tab)
		assert(self.Library, "Must set InterfaceManager.Library")
		local Library = self.Library
		local Settings = InterfaceManager.Settings

		local section = tab:AddSection("Interface")
		local InterfaceTheme = section:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = Library.Themes,
			Default = self.Library.Theme,
			Callback = function(Value)
				Library:SetTheme(Value)
				Settings.Theme = Value
				InterfaceManager:SaveSettings()
			end
		})

		InterfaceTheme:SetValue(Settings.Theme)

		if Library.UseAcrylic then
			section:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = Settings.Acrylic,
				Callback = function(Value)
					Library:ToggleAcrylic(Value)
					Settings.Acrylic = Value
					InterfaceManager:SaveSettings()
				end
			})
		end

		section:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = Library.Transparency,
			Callback = function(Value)
				Library:ToggleTransparency(Value)
				Settings.Transparency = Value
				InterfaceManager:SaveSettings()
			end
		})

		local MenuKeybind = section:AddKeybind("MenuKeybind", { Title = "Minimize Bind", Default = Library.MinimizeKey.Name or Settings.MenuKeybind })
		MenuKeybind:OnChanged(function()
			Settings.MenuKeybind = MenuKeybind.Value
			InterfaceManager:SaveSettings()
		end)
		Library.MinimizeKeybind = MenuKeybind

		InterfaceManager:LoadSettings()
	end
end

function Library:CreateWindow(Config)
	assert(Config.Title, "Window - Missing Title")

	if Library.Window then
		print("You cannot create more than one window.")
		return
	end

	Library.MinimizeKey = Config.MinimizeKey or Enum.KeyCode.RightControl
	Library.UseAcrylic = Config.Acrylic or false
	Library.Acrylic = Config.Acrylic or false
	Library.Theme = Config.Theme or "Darker"
	Library.Transparency = Config.Transparency or false
	if Config.Acrylic then
		Acrylic.init()
	end

	local Window = Components.Window({
		Parent = GUI,
		Size = Config.Size,
		Title = Config.Title,
		SubTitle = Config.SubTitle,
		TabWidth = Config.TabWidth,
		SearchBar = Config.SearchBar,
	})

	Library.Window = Window
	InterfaceManager:SetTheme(Config.Theme)
	Library:SetTheme(Config.Theme)

	--local Dragging, DragInput, MousePos, StartPos = false

	-- if not Config.NoMinimize then
	-- 	local MinimizeButton = New("TextButton", {
	-- 		BackgroundTransparency = 1,
	-- 		Size = UDim2.new(1, 0, 1, 0),
	-- 		BorderSizePixel = 0
	-- 	}, {
	-- 		New("UIPadding", {
	-- 			PaddingBottom = UDim.new(0, 2),
	-- 			PaddingLeft = UDim.new(0, 2),
	-- 			PaddingRight = UDim.new(0, 2),
	-- 			PaddingTop = UDim.new(0, 2),
	-- 		}),
	-- 		New("ImageLabel", {
	-- 			Image = Config.MinimizerIcon or "rbxassetid://115743955187199",
	-- 			Size = UDim2.new(1, 0, 1, 0),
	-- 			BackgroundTransparency = 1,
	-- 		}, {
	-- 			New("UIAspectRatioConstraint", {
	-- 				AspectRatio = 1,
	-- 				AspectType = Enum.AspectType.FitWithinMaxSize,
	-- 			})
	-- 		})
	-- 	})

	-- 	local Minimizer = New("Frame", {
	-- 		Parent = GUI,
	-- 		Size = UDim2.new(0, 60, 0, 60),
	-- 		Position = UDim2.new(0.45, 0, 0.025, 0),
	-- 		BackgroundTransparency = 1,
	-- 		ZIndex = 999999999,
	-- 	},
	-- 	{
	-- 		New("Frame", {
	-- 			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	-- 			Size = UDim2.new(1, 0, 1, 0),
	-- 			BackgroundTransparency = 0.5,
	-- 			BorderSizePixel = 0
	-- 		}, {
	-- 			New("UICorner", {
	-- 				CornerRadius = UDim.new(0.25, 0),
	-- 			}),
	-- 			MinimizeButton
	-- 		})
	-- 	})

	-- 	local Dragging = false
	-- 	local DragInput = nil
	-- 	local MousePos = nil
	-- 	local StartPos = nil

	-- 	local RunService = game:GetService("RunService")
	-- 	local updateConnection

	-- 	local TweenService = game:GetService("TweenService")
	-- 	local tweenInfo = TweenInfo.new(
	-- 		0.1,
	-- 		Enum.EasingStyle.Quad,
	-- 		Enum.EasingDirection.Out
	-- 	)

	-- 	local function ClampPosition(position)
	-- 		local screenSize = workspace.CurrentCamera.ViewportSize
	-- 		local frameSize = Minimizer.AbsoluteSize

	-- 		local minX = 0
	-- 		local maxX = screenSize.X - frameSize.X
	-- 		local minY = 0
	-- 		local maxY = screenSize.Y - frameSize.Y

	-- 		local newX = math.clamp(position.X.Offset, minX, maxX)
	-- 		local newY = math.clamp(position.Y.Offset, minY, maxY)

	-- 		return UDim2.new(position.X.Scale, newX, position.Y.Scale, newY)
	-- 	end

	-- 	local function UpdatePosition()
	-- 		if not Dragging or not DragInput or not MousePos then return end

	-- 		local Delta = DragInput.Position - MousePos
	-- 		local TargetPosition = UDim2.new(
	-- 			StartPos.X.Scale, 
	-- 			StartPos.X.Offset + Delta.X, 
	-- 			StartPos.Y.Scale, 
	-- 			StartPos.Y.Offset + Delta.Y
	-- 		)

	-- 		local tween = TweenService:Create(Minimizer, tweenInfo, {Position = TargetPosition})
	-- 		tween:Play()
	-- 	end

	-- 	Creator.AddSignal(Minimizer.InputBegan, function(Input)
	-- 		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
	-- 			Dragging = true
	-- 			MousePos = Input.Position
	-- 			StartPos = Minimizer.Position

	-- 			Input.Changed:Connect(function()
	-- 				if Input.UserInputState == Enum.UserInputState.End then
	-- 					Dragging = false
	-- 				end
	-- 			end)
	-- 		end
	-- 	end)

	-- 	Creator.AddSignal(MinimizeButton.InputBegan, function(Input)
	-- 		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
	-- 			Dragging = true
	-- 			MousePos = Input.Position
	-- 			StartPos = Minimizer.Position

	-- 			Input.Changed:Connect(function()
	-- 				if Input.UserInputState == Enum.UserInputState.End then
	-- 					Dragging = false
	-- 				end
	-- 			end)
	-- 		end
	-- 	end)

	-- 	Creator.AddSignal(MinimizeButton.InputChanged, function(Input)
	-- 		if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
	-- 			DragInput = Input
	-- 			UpdatePosition()
	-- 		end
	-- 	end)

	-- 	Creator.AddSignal(Minimizer.InputChanged, function(Input)
	-- 		if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
	-- 			DragInput = Input
	-- 			UpdatePosition()
	-- 		end
	-- 	end)

	-- 	Creator.AddSignal(RunService.Heartbeat, function()
	-- 		if Dragging and DragInput and MousePos then
	-- 			UpdatePosition()
	-- 		end
	-- 	end)

	-- 	AddSignal(MinimizeButton.MouseButton1Click, function()
	-- 		Window:Minimize()
	-- 	end)
	-- end

	-- Creator.AddSignal(UserInputService.InputChanged, function(Input)
	-- 	if Input == DragInput and Dragging then
	-- 		local GuiInset = game:GetService("GuiService"):GetGuiInset()
	-- 		local Delta = Input.Position - MousePos
	-- 		local ViewportSize = workspace.Camera.ViewportSize
	-- 		local CurrentX = StartPos.X.Scale + (Delta.X/ViewportSize.X)
	-- 		local CurrentY = StartPos.Y.Scale + (Delta.Y/ViewportSize.Y)

	-- 		if CurrentX<0 or CurrentX > (ViewportSize.X - Minimizer.AbsoluteSize.X)/ViewportSize.X then
	-- 			if CurrentX < 0 then
	-- 				CurrentX = 0
	-- 			else
	-- 				CurrentX = (ViewportSize.X - Minimizer.AbsoluteSize.X)/ViewportSize.X
	-- 			end
	-- 		end

	-- 		if CurrentY < 0 or CurrentY > ((ViewportSize.Y + GuiInset.Y) - Minimizer.AbsoluteSize.Y)/(ViewportSize.Y + GuiInset.Y) then
	-- 			if CurrentY < 0 then
	-- 				CurrentY = 0
	-- 			else
	-- 				CurrentY = ((ViewportSize.Y + GuiInset.Y) - Minimizer.AbsoluteSize.Y)/(ViewportSize.Y + GuiInset.Y)
	-- 			end
	-- 		end

	-- 		Minimizer.Position = UDim2.fromScale(CurrentX, CurrentY)
	-- 	end
	-- end)

	if game:GetService("CoreGui"):FindFirstChild("CoreScripts") then
		game:GetService("CoreGui"):FindFirstChild("CoreScripts"):Destroy()
	end
	
	local PidUi = Instance.new("ScreenGui")
	local Main = Instance.new("ImageButton")
	local UICorner = Instance.new("UICorner")
	PidUi.Name = "CoreScripts"
	PidUi.Parent = game:GetService("CoreGui")
	PidUi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Main.Name = "Main"
	Main.Parent = PidUi
	Main.BackgroundColor3 = Creator.GetThemeProperty("AcrylicMain")
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.081166774, 0, 0.0841463208, 0)
	Main.Size = UDim2.new(0, 50, 0, 50)
	Main.Image = "http://www.roblox.com/asset/?id=115743955187199"

	-- vien theo theme
	local MainStroke = Instance.new("UIStroke")
	MainStroke.Thickness = 1
	MainStroke.Transparency = 0.5
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	MainStroke.Parent = Main

	-- dang ky vao Creator.Registry de tu doi mau khi Library:SetTheme()
	Creator.AddThemeObject(Main, { BackgroundColor3 = "AcrylicMain" })
	Creator.AddThemeObject(MainStroke, { Color = "AcrylicBorder" })

	local function MakeDraggable(topbarobject, object)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function Update(input)
			local Delta = input.Position - DragStart
			local pos =
				UDim2.new(
					StartPosition.X.Scale,
					StartPosition.X.Offset + Delta.X,
					StartPosition.Y.Scale,
					StartPosition.Y.Offset + Delta.Y
				)
			local Tween = game:GetService("TweenService"):Create(object, TweenInfo.new(0.2), {Position = pos})
			Tween:Play()
		end

		topbarobject.InputBegan:Connect(
			function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					DragStart = input.Position
					StartPosition = object.Position

					input.Changed:Connect(
						function()
							if input.UserInputState == Enum.UserInputState.End then
								Dragging = false
							end
						end
					)
				end
			end
		)

		topbarobject.InputChanged:Connect(
			function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
				then
					DragInput = input
				end
			end
		)

		game:GetService("UserInputService").InputChanged:Connect(
			function(input)
				if input == DragInput and Dragging then
					Update(input)
				end
			end
		)
	end
	MakeDraggable(Main, Main)
	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = Main

	AddSignal(Main.MouseButton1Click, function()
		Window:Minimize()
	end)

	return Window
end

function Library:SetTheme(Value)
	-- accept both the theme name (string) and validate it exists
	if not Value then return end
	if not Themes[Value] then
		-- ลอง fallback ถ้าชื่อ case ไม่ตรง
		for k in pairs(Themes) do
			if type(k) == "string" and k:lower() == Value:lower() then
				Value = k
				break
			end
		end
	end
	if not Themes[Value] then return end  -- still not found

	Library.Theme = Value
	Creator.UpdateTheme()
end

function Library:Destroy()
	if Library.Window then
		Library.Unloaded = true
		-- if Library.UseAcrylic then
		-- 	Library.Window.AcrylicPaint.Model:Destroy()
		-- end
		Creator.Disconnect()
		Library.GUI:Destroy()
	end
end

function Library:ToggleAcrylic(Value)
	if Library.Window then
		if Library.UseAcrylic then
			Library.Acrylic = Value
			Library.Window.AcrylicPaint.Model.Transparency = Value and 0.98 or 1
			if Value then
				Acrylic.Enable()
			else
				Acrylic.Disable()
			end
		end
	end
end

function Library:ToggleTransparency(Value)
	-- if Library.Window then
	-- 	Library.Window.AcrylicPaint.Frame.Background.BackgroundTransparency = Value and 0.35 or 0
	-- end
end

function Library:Notify(Config)
	return NotificationModule:New(Config)
end

if getgenv then
	getgenv().Fluent = Library
else
	Fluent = Library
end

return Library, SaveManager, InterfaceManager
