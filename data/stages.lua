-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 100,
		multiplier = 200,
	},
	{
		minlevel = 101,
		maxlevel = 300,
		multiplier = 100,
	},
	{
		minlevel = 301,
		maxlevel = 500,
		multiplier = 60,
	},
	{
		minlevel = 501,
		maxlevel = 700,
		multiplier = 45,
	},
	{
		minlevel = 701,
		multiplier = 30,
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 60,
		multiplier = 15,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 12,
	},
	{
		minlevel = 81,
		maxlevel = 100,
		multiplier = 9,
	},
	{
		minlevel = 101,
		maxlevel = 110,
		multiplier = 7,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 6,
	},
	{
		minlevel = 126,
		multiplier = 5,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 10,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 8,
	},
	{
		minlevel = 81,
		maxlevel = 100,
		multiplier = 6,
	},
	{
		minlevel = 101,
		maxlevel = 110,
		multiplier = 5,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 4,
	},
	{
		minlevel = 126,
		multiplier = 3,
	},
}
