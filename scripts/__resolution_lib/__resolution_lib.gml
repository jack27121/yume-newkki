//taken from https://github.com/JujuAdams/ResolutionLibrary/blob/main/resLib.gml
enum RES_LIB
{
    //Desktop and console
    
    //1920x1080 - The most common resolution in the Steam hardware survey, as of 2023-01-04
    DESKTOP_COMMON,
    
	DESKTOP_4_3_320_X_240,
	DESKTOP_4_3_480_X_360,
	DESKTOP_4_3_960_X_720,
	
    DESKTOP_16_9_1280_X_720,
    DESKTOP_16_9_1366_X_768,
    DESKTOP_16_9_1920_X_1080,
    DESKTOP_16_9_2560_X_1440,
    DESKTOP_16_9_3840_X_2160,
    
    DESKTOP_16_10_1280_X_800,
    DESKTOP_16_10_1920_X_1200,
    DESKTOP_16_10_2560_X_1600,
    DESKTOP_16_10_3840_X_2400,
	TOTAL
}

global.resLib = [];

//Desktop and console
global.resLib[@ RES_LIB.DESKTOP_COMMON] = { width: 1920, height: 1080 };

global.resLib[@ RES_LIB.DESKTOP_4_3_320_X_240 ] = { width: 320, height:  240 };
global.resLib[@ RES_LIB.DESKTOP_4_3_480_X_360 ] = { width: 480, height:  360 };
global.resLib[@ RES_LIB.DESKTOP_4_3_960_X_720 ] = { width: 960, height:  720 };

global.resLib[@ RES_LIB.DESKTOP_16_9_1280_X_720 ] = { width: 1280, height:  720 };
global.resLib[@ RES_LIB.DESKTOP_16_9_1366_X_768 ] = { width: 1366, height:  768 };
global.resLib[@ RES_LIB.DESKTOP_16_9_1920_X_1080] = { width: 1920, height: 1080 };
global.resLib[@ RES_LIB.DESKTOP_16_9_2560_X_1440] = { width: 2560, height: 1440 };
global.resLib[@ RES_LIB.DESKTOP_16_9_3840_X_2160] = { width: 3840, height: 2160 };

global.resLib[@ RES_LIB.DESKTOP_16_10_1280_X_800 ] = { width: 1280, height:  800 };
global.resLib[@ RES_LIB.DESKTOP_16_10_1920_X_1200] = { width: 1920, height: 1200 };
global.resLib[@ RES_LIB.DESKTOP_16_10_2560_X_1600] = { width: 2560, height: 1600 };
global.resLib[@ RES_LIB.DESKTOP_16_10_3840_X_2400] = { width: 3840, height: 2400 };

//global.resLib[@ RES_LIB.STEAM_DECK     ] = { width: 1280, height: 800 };
//global.resLib[@ RES_LIB.SWITCH_HANDHELD] = { width: 1280, height: 720 };