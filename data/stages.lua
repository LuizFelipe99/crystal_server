-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 200,
		multiplier = 200,
	},
	{
		minlevel = 201,
		maxlevel = 400,
		multiplier = 150,
	},
	{
		minlevel = 401,
		maxlevel = 600,
		multiplier = 100,
	},
	{
		minlevel = 601,
		multiplier = 50,
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
