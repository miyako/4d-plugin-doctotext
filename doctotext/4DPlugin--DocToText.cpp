﻿/* --------------------------------------------------------------------------------
 #
 #  4DPlugin--DocToText.cpp
 #	source generated by 4D Plugin Wizard
 #	Project :  DocToText
 #	author : miyako
 #	2021/12/02
 #  
 # --------------------------------------------------------------------------------*/

#include "4DPlugin--DocToText.h"

#pragma mark -

void PluginMain(PA_long32 selector, PA_PluginParameters params) {
    
	try
	{
        switch(selector)
        {
			// ---  DocToText
            
			case 1 :
				DocToText(params);
				break;

        }

	}
	catch(...)
	{

	}
}

#pragma mark -

void DocToText(PA_PluginParameters params) {

}

