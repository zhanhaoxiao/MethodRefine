( define ( problem probname )
	( :domain satellite )
	( :requirements :strips :typing :equality )
	( :objects
		sate1 - satellite
		sate2 - satellite
		sate3 - satellite
		direc1 - direction
		direc2 - direction
		direc3 - direction
		direc4 - direction
		direc5 - direction
		mode1 - mode
		mode2 - mode
		mode3 - mode
		inst11 - instrument
		inst12 - instrument
		inst13 - instrument
		inst21 - instrument
		inst22 - instrument
		inst23 - instrument
		inst24 - instrument
		inst25 - instrument
		inst31 - instrument
		inst32 - instrument
		inst33 - instrument
	)
	( :init
		( pointing sate1 direc5 )
		( pointing sate2 direc2 )
		( pointing sate3 direc3 )
		( power_avail sate1 )
		( on_board inst11 sate1 )
		( on_board inst12 sate1 )
		( on_board inst13 sate1 )
		( power_avail sate2 )
		( on_board inst21 sate2 )
		( on_board inst22 sate2 )
		( on_board inst23 sate2 )
		( on_board inst24 sate2 )
		( on_board inst25 sate2 )
		( power_avail sate3 )
		( on_board inst31 sate3 )
		( on_board inst32 sate3 )
		( on_board inst33 sate3 )
		( supports inst11 mode1 )
		( calibration_target inst11 direc3 )
		( not_calibrated inst11 )
		( supports inst12 mode3 )
		( calibration_target inst12 direc4 )
		( not_calibrated inst12 )
		( supports inst13 mode2 )
		( calibration_target inst13 direc3 )
		( not_calibrated inst13 )
		( supports inst21 mode1 )
		( calibration_target inst21 direc4 )
		( not_calibrated inst21 )
		( supports inst22 mode1 )
		( calibration_target inst22 direc5 )
		( not_calibrated inst22 )
		( supports inst23 mode2 )
		( calibration_target inst23 direc5 )
		( not_calibrated inst23 )
		( supports inst24 mode1 )
		( calibration_target inst24 direc3 )
		( not_calibrated inst24 )
		( supports inst25 mode1 )
		( calibration_target inst25 direc2 )
		( not_calibrated inst25 )
		( supports inst31 mode3 )
		( calibration_target inst31 direc2 )
		( not_calibrated inst31 )
		( supports inst32 mode3 )
		( calibration_target inst32 direc1 )
		( not_calibrated inst32 )
		( supports inst33 mode1 )
		( calibration_target inst33 direc2 )
		( not_calibrated inst33 )
	)
	( :goal
		( and
			( have_image direc2 mode3 )
			( have_image direc2 mode2 )
			( have_image direc5 mode2 )
			( have_image direc2 mode3 )
		)
	)
)