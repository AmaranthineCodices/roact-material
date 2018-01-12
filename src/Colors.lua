-- Color dictionary automatically generated with the following code:
--[[
-- json is a json file containing all the material colors
local parsed = game:GetService("HttpService"):JSONDecode(json)
local output = { "{\n" }

for key, hex in pairs(parsed) do
	local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)")
	local formattedKey = key:gsub("-(%l)", string.upper):gsub("^%l", string.upper):gsub("-", "")
	table.insert(output, "\t[")
	table.insert(output, ("%q"):format(formattedKey))
	table.insert(output, "] = Color3.fromRGB(")
	table.insert(output, math.floor(tonumber(r, 16)))
	table.insert(output, ", ")
	table.insert(output, math.floor(tonumber(g, 16)))
	table.insert(output, ", ")
	table.insert(output, math.floor(tonumber(b, 16)))
	table.insert(output, ");\n")
end

table.insert(output, "}")
print(table.concat(output, ""))
]]

local function Lookupify(array)
	local result = {}

	for index, key in pairs(array) do
		result[key] = index
	end

	return result
end

local colorSteps = { 50, 100, 200, 300, 400, 500, 600, 700, 800, 900 }
local accentSteps = { 100, 200, 400, 700 }
local colorIndices = Lookupify(colorSteps)
local accentIndices = Lookupify(accentSteps)

local function IsAccent(colorName)
	return colorName:match("A%d+$") ~= nil
end

local Colors = {
	["Amber100"] = Color3.fromRGB(255, 236, 179);
	["Amber200"] = Color3.fromRGB(255, 224, 130);
	["Amber300"] = Color3.fromRGB(255, 213, 79);
	["Amber400"] = Color3.fromRGB(255, 202, 40);
	["Amber50"] = Color3.fromRGB(255, 248, 225);
	["Amber500"] = Color3.fromRGB(255, 193, 7);
	["Amber600"] = Color3.fromRGB(255, 179, 0);
	["Amber700"] = Color3.fromRGB(255, 160, 0);
	["Amber800"] = Color3.fromRGB(255, 143, 0);
	["Amber900"] = Color3.fromRGB(255, 111, 0);
	["AmberA100"] = Color3.fromRGB(255, 229, 127);
	["AmberA200"] = Color3.fromRGB(255, 215, 64);
	["AmberA400"] = Color3.fromRGB(255, 196, 0);
	["AmberA700"] = Color3.fromRGB(255, 171, 0);
	["Black"] = Color3.fromRGB(0, 0, 0);
	["Blue100"] = Color3.fromRGB(187, 222, 251);
	["Blue200"] = Color3.fromRGB(144, 202, 249);
	["Blue300"] = Color3.fromRGB(100, 181, 246);
	["Blue400"] = Color3.fromRGB(66, 165, 245);
	["Blue50"] = Color3.fromRGB(227, 242, 253);
	["Blue500"] = Color3.fromRGB(33, 150, 243);
	["Blue600"] = Color3.fromRGB(30, 136, 229);
	["Blue700"] = Color3.fromRGB(25, 118, 210);
	["Blue800"] = Color3.fromRGB(21, 101, 192);
	["Blue900"] = Color3.fromRGB(13, 71, 161);
	["BlueA100"] = Color3.fromRGB(130, 177, 255);
	["BlueA200"] = Color3.fromRGB(68, 138, 255);
	["BlueA400"] = Color3.fromRGB(41, 121, 255);
	["BlueA700"] = Color3.fromRGB(41, 98, 255);
	["BlueGrey100"] = Color3.fromRGB(207, 216, 220);
	["BlueGrey200"] = Color3.fromRGB(176, 190, 197);
	["BlueGrey300"] = Color3.fromRGB(144, 164, 174);
	["BlueGrey400"] = Color3.fromRGB(120, 144, 156);
	["BlueGrey50"] = Color3.fromRGB(236, 239, 241);
	["BlueGrey500"] = Color3.fromRGB(96, 125, 139);
	["BlueGrey600"] = Color3.fromRGB(84, 110, 122);
	["BlueGrey700"] = Color3.fromRGB(69, 90, 100);
	["BlueGrey800"] = Color3.fromRGB(55, 71, 79);
	["BlueGrey900"] = Color3.fromRGB(38, 50, 56);
	["Brown100"] = Color3.fromRGB(215, 204, 200);
	["Brown200"] = Color3.fromRGB(188, 170, 164);
	["Brown300"] = Color3.fromRGB(161, 136, 127);
	["Brown400"] = Color3.fromRGB(141, 110, 99);
	["Brown50"] = Color3.fromRGB(239, 235, 233);
	["Brown500"] = Color3.fromRGB(121, 85, 72);
	["Brown600"] = Color3.fromRGB(109, 76, 65);
	["Brown700"] = Color3.fromRGB(93, 64, 55);
	["Brown800"] = Color3.fromRGB(78, 52, 46);
	["Brown900"] = Color3.fromRGB(62, 39, 35);
	["Cyan100"] = Color3.fromRGB(178, 235, 242);
	["Cyan200"] = Color3.fromRGB(128, 222, 234);
	["Cyan300"] = Color3.fromRGB(77, 208, 225);
	["Cyan400"] = Color3.fromRGB(38, 198, 218);
	["Cyan50"] = Color3.fromRGB(224, 247, 250);
	["Cyan500"] = Color3.fromRGB(0, 188, 212);
	["Cyan600"] = Color3.fromRGB(0, 172, 193);
	["Cyan700"] = Color3.fromRGB(0, 151, 167);
	["Cyan800"] = Color3.fromRGB(0, 131, 143);
	["Cyan900"] = Color3.fromRGB(0, 96, 100);
	["CyanA100"] = Color3.fromRGB(132, 255, 255);
	["CyanA200"] = Color3.fromRGB(24, 255, 255);
	["CyanA400"] = Color3.fromRGB(0, 229, 255);
	["CyanA700"] = Color3.fromRGB(0, 184, 212);
	["DeepOrange100"] = Color3.fromRGB(255, 204, 188);
	["DeepOrange200"] = Color3.fromRGB(255, 171, 145);
	["DeepOrange300"] = Color3.fromRGB(255, 138, 101);
	["DeepOrange400"] = Color3.fromRGB(255, 112, 67);
	["DeepOrange50"] = Color3.fromRGB(251, 233, 231);
	["DeepOrange500"] = Color3.fromRGB(255, 87, 34);
	["DeepOrange600"] = Color3.fromRGB(244, 81, 30);
	["DeepOrange700"] = Color3.fromRGB(230, 74, 25);
	["DeepOrange800"] = Color3.fromRGB(216, 67, 21);
	["DeepOrange900"] = Color3.fromRGB(191, 54, 12);
	["DeepOrangeA100"] = Color3.fromRGB(255, 158, 128);
	["DeepOrangeA200"] = Color3.fromRGB(255, 110, 64);
	["DeepOrangeA400"] = Color3.fromRGB(255, 61, 0);
	["DeepOrangeA700"] = Color3.fromRGB(221, 44, 0);
	["DeepPurple100"] = Color3.fromRGB(209, 196, 233);
	["DeepPurple200"] = Color3.fromRGB(179, 157, 219);
	["DeepPurple300"] = Color3.fromRGB(149, 117, 205);
	["DeepPurple400"] = Color3.fromRGB(126, 87, 194);
	["DeepPurple50"] = Color3.fromRGB(237, 231, 246);
	["DeepPurple500"] = Color3.fromRGB(103, 58, 183);
	["DeepPurple600"] = Color3.fromRGB(94, 53, 177);
	["DeepPurple700"] = Color3.fromRGB(81, 45, 168);
	["DeepPurple800"] = Color3.fromRGB(69, 39, 160);
	["DeepPurple900"] = Color3.fromRGB(49, 27, 146);
	["DeepPurpleA100"] = Color3.fromRGB(179, 136, 255);
	["DeepPurpleA200"] = Color3.fromRGB(124, 77, 255);
	["DeepPurpleA400"] = Color3.fromRGB(101, 31, 255);
	["DeepPurpleA700"] = Color3.fromRGB(98, 0, 234);
	["Green100"] = Color3.fromRGB(200, 230, 201);
	["Green200"] = Color3.fromRGB(165, 214, 167);
	["Green300"] = Color3.fromRGB(129, 199, 132);
	["Green400"] = Color3.fromRGB(102, 187, 106);
	["Green50"] = Color3.fromRGB(232, 245, 233);
	["Green500"] = Color3.fromRGB(76, 175, 80);
	["Green600"] = Color3.fromRGB(67, 160, 71);
	["Green700"] = Color3.fromRGB(56, 142, 60);
	["Green800"] = Color3.fromRGB(46, 125, 50);
	["Green900"] = Color3.fromRGB(27, 94, 32);
	["GreenA100"] = Color3.fromRGB(185, 246, 202);
	["GreenA200"] = Color3.fromRGB(105, 240, 174);
	["GreenA400"] = Color3.fromRGB(0, 230, 118);
	["GreenA700"] = Color3.fromRGB(0, 200, 83);
	["Grey100"] = Color3.fromRGB(245, 245, 245);
	["Grey200"] = Color3.fromRGB(238, 238, 238);
	["Grey300"] = Color3.fromRGB(224, 224, 224);
	["Grey400"] = Color3.fromRGB(189, 189, 189);
	["Grey50"] = Color3.fromRGB(250, 250, 250);
	["Grey500"] = Color3.fromRGB(158, 158, 158);
	["Grey600"] = Color3.fromRGB(117, 117, 117);
	["Grey700"] = Color3.fromRGB(97, 97, 97);
	["Grey800"] = Color3.fromRGB(66, 66, 66);
	["Grey900"] = Color3.fromRGB(33, 33, 33);
	["Indigo100"] = Color3.fromRGB(197, 202, 233);
	["Indigo200"] = Color3.fromRGB(159, 168, 218);
	["Indigo300"] = Color3.fromRGB(121, 134, 203);
	["Indigo400"] = Color3.fromRGB(92, 107, 192);
	["Indigo50"] = Color3.fromRGB(232, 234, 246);
	["Indigo500"] = Color3.fromRGB(63, 81, 181);
	["Indigo600"] = Color3.fromRGB(57, 73, 171);
	["Indigo700"] = Color3.fromRGB(48, 63, 159);
	["Indigo800"] = Color3.fromRGB(40, 53, 147);
	["Indigo900"] = Color3.fromRGB(26, 35, 126);
	["IndigoA100"] = Color3.fromRGB(140, 158, 255);
	["IndigoA200"] = Color3.fromRGB(83, 109, 254);
	["IndigoA400"] = Color3.fromRGB(61, 90, 254);
	["IndigoA700"] = Color3.fromRGB(48, 79, 254);
	["LightBlue100"] = Color3.fromRGB(179, 229, 252);
	["LightBlue200"] = Color3.fromRGB(129, 212, 250);
	["LightBlue300"] = Color3.fromRGB(79, 195, 247);
	["LightBlue400"] = Color3.fromRGB(41, 182, 246);
	["LightBlue50"] = Color3.fromRGB(225, 245, 254);
	["LightBlue500"] = Color3.fromRGB(3, 169, 244);
	["LightBlue600"] = Color3.fromRGB(3, 155, 229);
	["LightBlue700"] = Color3.fromRGB(2, 136, 209);
	["LightBlue800"] = Color3.fromRGB(2, 119, 189);
	["LightBlue900"] = Color3.fromRGB(1, 87, 155);
	["LightBlueA100"] = Color3.fromRGB(128, 216, 255);
	["LightBlueA200"] = Color3.fromRGB(64, 196, 255);
	["LightBlueA400"] = Color3.fromRGB(0, 176, 255);
	["LightBlueA700"] = Color3.fromRGB(0, 145, 234);
	["LightGreen100"] = Color3.fromRGB(220, 237, 200);
	["LightGreen200"] = Color3.fromRGB(197, 225, 165);
	["LightGreen300"] = Color3.fromRGB(174, 213, 129);
	["LightGreen400"] = Color3.fromRGB(156, 204, 101);
	["LightGreen50"] = Color3.fromRGB(241, 248, 233);
	["LightGreen500"] = Color3.fromRGB(139, 195, 74);
	["LightGreen600"] = Color3.fromRGB(124, 179, 66);
	["LightGreen700"] = Color3.fromRGB(104, 159, 56);
	["LightGreen800"] = Color3.fromRGB(85, 139, 47);
	["LightGreen900"] = Color3.fromRGB(51, 105, 30);
	["LightGreenA100"] = Color3.fromRGB(204, 255, 144);
	["LightGreenA200"] = Color3.fromRGB(178, 255, 89);
	["LightGreenA400"] = Color3.fromRGB(118, 255, 3);
	["LightGreenA700"] = Color3.fromRGB(100, 221, 23);
	["Lime100"] = Color3.fromRGB(240, 244, 195);
	["Lime200"] = Color3.fromRGB(230, 238, 156);
	["Lime300"] = Color3.fromRGB(220, 231, 117);
	["Lime400"] = Color3.fromRGB(212, 225, 87);
	["Lime50"] = Color3.fromRGB(249, 251, 231);
	["Lime500"] = Color3.fromRGB(205, 220, 57);
	["Lime600"] = Color3.fromRGB(192, 202, 51);
	["Lime700"] = Color3.fromRGB(175, 180, 43);
	["Lime800"] = Color3.fromRGB(158, 157, 36);
	["Lime900"] = Color3.fromRGB(130, 119, 23);
	["LimeA100"] = Color3.fromRGB(244, 255, 129);
	["LimeA200"] = Color3.fromRGB(238, 255, 65);
	["LimeA400"] = Color3.fromRGB(198, 255, 0);
	["LimeA700"] = Color3.fromRGB(174, 234, 0);
	["Orange100"] = Color3.fromRGB(255, 224, 178);
	["Orange200"] = Color3.fromRGB(255, 204, 128);
	["Orange300"] = Color3.fromRGB(255, 183, 77);
	["Orange400"] = Color3.fromRGB(255, 167, 38);
	["Orange50"] = Color3.fromRGB(255, 243, 224);
	["Orange500"] = Color3.fromRGB(255, 152, 0);
	["Orange600"] = Color3.fromRGB(251, 140, 0);
	["Orange700"] = Color3.fromRGB(245, 124, 0);
	["Orange800"] = Color3.fromRGB(239, 108, 0);
	["Orange900"] = Color3.fromRGB(230, 81, 0);
	["OrangeA100"] = Color3.fromRGB(255, 209, 128);
	["OrangeA200"] = Color3.fromRGB(255, 171, 64);
	["OrangeA400"] = Color3.fromRGB(255, 145, 0);
	["OrangeA700"] = Color3.fromRGB(255, 109, 0);
	["Pink100"] = Color3.fromRGB(248, 187, 208);
	["Pink200"] = Color3.fromRGB(244, 143, 177);
	["Pink300"] = Color3.fromRGB(240, 98, 146);
	["Pink400"] = Color3.fromRGB(236, 64, 122);
	["Pink50"] = Color3.fromRGB(252, 228, 236);
	["Pink500"] = Color3.fromRGB(233, 30, 99);
	["Pink600"] = Color3.fromRGB(216, 27, 96);
	["Pink700"] = Color3.fromRGB(194, 24, 91);
	["Pink800"] = Color3.fromRGB(173, 20, 87);
	["Pink900"] = Color3.fromRGB(136, 14, 79);
	["PinkA100"] = Color3.fromRGB(255, 128, 171);
	["PinkA200"] = Color3.fromRGB(255, 64, 129);
	["PinkA400"] = Color3.fromRGB(245, 0, 87);
	["PinkA700"] = Color3.fromRGB(197, 17, 98);
	["Purple100"] = Color3.fromRGB(225, 190, 231);
	["Purple200"] = Color3.fromRGB(206, 147, 216);
	["Purple300"] = Color3.fromRGB(186, 104, 200);
	["Purple400"] = Color3.fromRGB(171, 71, 188);
	["Purple50"] = Color3.fromRGB(243, 229, 245);
	["Purple500"] = Color3.fromRGB(156, 39, 176);
	["Purple600"] = Color3.fromRGB(142, 36, 170);
	["Purple700"] = Color3.fromRGB(123, 31, 162);
	["Purple800"] = Color3.fromRGB(106, 27, 154);
	["Purple900"] = Color3.fromRGB(74, 20, 140);
	["PurpleA100"] = Color3.fromRGB(234, 128, 252);
	["PurpleA200"] = Color3.fromRGB(224, 64, 251);
	["PurpleA400"] = Color3.fromRGB(213, 0, 249);
	["PurpleA700"] = Color3.fromRGB(170, 0, 255);
	["Red100"] = Color3.fromRGB(255, 205, 210);
	["Red200"] = Color3.fromRGB(239, 154, 154);
	["Red300"] = Color3.fromRGB(229, 115, 115);
	["Red400"] = Color3.fromRGB(239, 83, 80);
	["Red50"] = Color3.fromRGB(255, 235, 238);
	["Red500"] = Color3.fromRGB(244, 67, 54);
	["Red600"] = Color3.fromRGB(229, 57, 53);
	["Red700"] = Color3.fromRGB(211, 47, 47);
	["Red800"] = Color3.fromRGB(198, 40, 40);
	["Red900"] = Color3.fromRGB(183, 28, 28);
	["RedA100"] = Color3.fromRGB(255, 138, 128);
	["RedA200"] = Color3.fromRGB(255, 82, 82);
	["RedA400"] = Color3.fromRGB(255, 23, 68);
	["RedA700"] = Color3.fromRGB(213, 0, 0);
	["Teal100"] = Color3.fromRGB(178, 223, 219);
	["Teal200"] = Color3.fromRGB(128, 203, 196);
	["Teal300"] = Color3.fromRGB(77, 182, 172);
	["Teal400"] = Color3.fromRGB(38, 166, 154);
	["Teal50"] = Color3.fromRGB(224, 242, 241);
	["Teal500"] = Color3.fromRGB(0, 150, 136);
	["Teal600"] = Color3.fromRGB(0, 137, 123);
	["Teal700"] = Color3.fromRGB(0, 121, 107);
	["Teal800"] = Color3.fromRGB(0, 105, 92);
	["Teal900"] = Color3.fromRGB(0, 77, 64);
	["TealA100"] = Color3.fromRGB(167, 255, 235);
	["TealA200"] = Color3.fromRGB(100, 255, 218);
	["TealA400"] = Color3.fromRGB(29, 233, 182);
	["TealA700"] = Color3.fromRGB(0, 191, 165);
	["White"] = Color3.fromRGB(255, 255, 255);
	["Yellow100"] = Color3.fromRGB(255, 249, 196);
	["Yellow200"] = Color3.fromRGB(255, 245, 157);
	["Yellow300"] = Color3.fromRGB(255, 241, 118);
	["Yellow400"] = Color3.fromRGB(255, 238, 88);
	["Yellow50"] = Color3.fromRGB(255, 253, 231);
	["Yellow500"] = Color3.fromRGB(255, 235, 59);
	["Yellow600"] = Color3.fromRGB(253, 216, 53);
	["Yellow700"] = Color3.fromRGB(251, 192, 45);
	["Yellow800"] = Color3.fromRGB(249, 168, 37);
	["Yellow900"] = Color3.fromRGB(245, 127, 23);
	["YellowA100"] = Color3.fromRGB(255, 255, 141);
	["YellowA200"] = Color3.fromRGB(255, 255, 0);
	["YellowA400"] = Color3.fromRGB(255, 234, 0);
	["YellowA700"] = Color3.fromRGB(255, 214, 0);
}

function Colors.Get(name, level)
	return Colors[name..tostring(level)]
end

function Colors.Offset(color, steps)
	local level = tonumber(color:match("(%d+)$"))
	local name = color:match("^(%a+)")
	local isAccent = IsAccent(color)

	local newLevel

	if isAccent then
		local accentIndex = accentIndices[level]
		local newIndex = math.clamp(accentIndex + steps, 1, #accentSteps)
		newLevel = accentSteps[newIndex]
	else
		local colorIndex = colorIndices[level]
		local newIndex = math.clamp(colorIndex + steps, 1, #colorSteps)
		newLevel = colorSteps[newIndex]
	end

	return Colors[name..newLevel]
end

function Colors.Lighten(color, steps)
	return Colors.Offset(color, -steps)
end

function Colors.Darken(color, steps)
	return Colors.Offset(color, steps)
end

return Colors
