#import "../substrate.h"
#import <UIKit/UIKit.h>
#import <mach-o/dyld.h>
#import <initializer_list>
#import <vector>
#import <map>
#import <mach-o/dyld.h>
#import <string>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <initializer_list>
#import <vector>
#import <mach-o/dyld.h>
#import <UIKit/UIKit.h>
#import <iostream>
#import <stdio.h>
#include <sstream>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
#include <algorithm>
#include <fstream>
#include <ifaddrs.h>
#include <stdint.h>

struct Block
{
	void** vtable;
	int blockId;
};
static Block** Block$mBlocks;

uintptr_t* guiData = NULL;

int cnt = 0;

void (*GuiData_displayClientMessage)(uintptr_t*, const std::string&);
void _GuiData_displayClientMessage(const std::string&);


void (*GuiData_tick)(uintptr_t*);
void _GuiData_tick(uintptr_t* _guiData) {
	guiData = _guiData;

	GuiData_tick(_guiData);
}

void _GuiData_displayClientMessage(const std::string& msg) {
	if(guiData != NULL) {
		GuiData_displayClientMessage(guiData, msg);
	}
}

void (*GameMode_tick)(uintptr_t* self);
void _GameMode_tick(uintptr_t* self) {
	GameMode_tick(self);
	
	cnt++;
	
	if(cnt == 100) {
		// If this prints 4 then we're in the clear
		std::string myStr = std::string(Block$mBlocks[4]->blockId);
		GuiData_displayClientMessage(guiData, myStr);
	}
}

static std::string (*I18n_get)(const std::string&);
static std::string _I18n_get(const std::string& key) {
	if(key == "menu.copyright") {
		return std::string{"©DarkShuper-iOSTestMod"};
	}
	if(key == "v0.16.2") {
		return std::string{"§eMods+0.16.2"};
	}

	return I18n_get(key);
}

%ctor {
	MSHookFunction((void*)(0x100107fc4 + _dyld_get_image_vmaddr_slide(0)), (void*)&_GuiData_tick, (void**)&GuiData_tick);
	MSHookFunction((void*)(0x100108794 + _dyld_get_image_vmaddr_slide(0)), (void*)&_GuiData_displayClientMessage, (void**)&GuiData_displayClientMessage);
	MSHookFunction((void*)(0x10049816c + _dyld_get_image_vmaddr_slide(0)), (void*)&_I18n_get, (void**)&I18n_get);
	MSHookFunction((void*)(0x10072192c + _dyld_get_image_vmaddr_slide(0)), (void*)&_GameMode_tick, (void**)&GameMode_tick);
	
	Block$mBlocks = (Block**)(0x1012d2060 + _dyld_get_image_vmaddr_slide(0));
}
