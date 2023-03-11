// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"
#include "framework.h"

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}

#include <cstdio>
#include <Windows.h>
#include <iostream>

extern "C"
{
    __declspec (dllexport) void __stdcall Java_InputHandler_leftClickDown()
    {
        INPUT mouseInput;
        ZeroMemory(&mouseInput, sizeof(mouseInput));

        mouseInput.type = INPUT_MOUSE;
        mouseInput.mi.dwFlags = MOUSEEVENTF_LEFTDOWN;

        UINT uSent = SendInput(1, &mouseInput, sizeof(INPUT));
        if (uSent != 1)
        {
            std::cout << "Input failed!";
        }
    }

    __declspec (dllexport) void __stdcall Java_InputHandler_leftClickUp()
    {
        INPUT mouseInput;
        ZeroMemory(&mouseInput, sizeof(mouseInput));

        mouseInput.type = INPUT_MOUSE;
        mouseInput.mi.dwFlags = MOUSEEVENTF_LEFTUP;

        UINT uSent = SendInput(1, &mouseInput, sizeof(INPUT));
        if (uSent != 1)
        {
            std::cout << "Input failed!";
        }
    }

    __declspec (dllexport) void __stdcall Java_InputHandler_rightClickDown()
    {
        INPUT mouseInput;
        ZeroMemory(&mouseInput, sizeof(mouseInput));

        mouseInput.type = INPUT_MOUSE;
        mouseInput.mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;

        UINT uSent = SendInput(1, &mouseInput, sizeof(INPUT));
        if (uSent != 1)
        {
            std::cout << "Input failed!";
        }
    }

    __declspec (dllexport) void __stdcall Java_InputHandler_rightClickUp()
    {
        INPUT mouseInput;
        ZeroMemory(&mouseInput, sizeof(mouseInput));

        mouseInput.type = INPUT_MOUSE;
        mouseInput.mi.dwFlags = MOUSEEVENTF_RIGHTUP;

        UINT uSent = SendInput(1, &mouseInput, sizeof(INPUT));
        if (uSent != 1)
        {
            std::cout << "Input failed!";
        }
    }

    __declspec (dllexport) void __stdcall Java_InputHandler_middleClickDown()
    {
        INPUT mouseInput;
        ZeroMemory(&mouseInput, sizeof(mouseInput));

        mouseInput.type = INPUT_MOUSE;
        mouseInput.mi.dwFlags = MOUSEEVENTF_MIDDLEDOWN;

        UINT uSent = SendInput(1, &mouseInput, sizeof(INPUT));
        if (uSent != 1)
        {
            std::cout << "Input failed!";
        }
    }

    __declspec (dllexport) void __stdcall Java_InputHandler_middleClickUp()
    {
        INPUT mouseInput;
        ZeroMemory(&mouseInput, sizeof(mouseInput));

        mouseInput.type = INPUT_MOUSE;
        mouseInput.mi.dwFlags = MOUSEEVENTF_MIDDLEUP;

        UINT uSent = SendInput(1, &mouseInput, sizeof(INPUT));
        if (uSent != 1)
        {
            std::cout << "Input failed!";
        }
    }

    __declspec (dllexport) void __stdcall Java_InputHandler_toggleOSK()
    {
        INPUT OSKToggleInputs[6] = {};
        ZeroMemory(&OSKToggleInputs, sizeof(OSKToggleInputs));

        OSKToggleInputs[0].type = INPUT_KEYBOARD;
        OSKToggleInputs[0].ki.wVk = VK_LWIN;

        OSKToggleInputs[1].type = INPUT_KEYBOARD;
        OSKToggleInputs[1].ki.wVk = VK_LCONTROL;

        OSKToggleInputs[2].type = INPUT_KEYBOARD;
        OSKToggleInputs[2].ki.wVk = 0x4F;       // 0x4F - "o"

        OSKToggleInputs[3].type = INPUT_KEYBOARD;
        OSKToggleInputs[3].ki.wVk = 0x4F;
        OSKToggleInputs[3].ki.dwFlags = KEYEVENTF_KEYUP;

        OSKToggleInputs[4].type = INPUT_KEYBOARD;
        OSKToggleInputs[4].ki.wVk = VK_LCONTROL;
        OSKToggleInputs[4].ki.dwFlags = KEYEVENTF_KEYUP;

        OSKToggleInputs[5].type = INPUT_KEYBOARD;
        OSKToggleInputs[5].ki.wVk = VK_LWIN;
        OSKToggleInputs[5].ki.dwFlags = KEYEVENTF_KEYUP;

        UINT uSent = SendInput((sizeof(OSKToggleInputs) / sizeof(INPUT)), OSKToggleInputs, sizeof(INPUT));
        if (uSent != (sizeof(OSKToggleInputs) / sizeof(INPUT)))
        {
            std::cout << "Input failed!";
        }
    }

    __declspec (dllexport) void __stdcall Java_InputHandler_scrollUp()
    {
        INPUT mouseInput;
        ZeroMemory(&mouseInput, sizeof(mouseInput));
        POINT pos;
        GetCursorPos(&pos);

        mouseInput.type = INPUT_MOUSE;
        mouseInput.mi.dwFlags = MOUSEEVENTF_WHEEL;
        mouseInput.mi.time = NULL;
        mouseInput.mi.mouseData = (DWORD)50;
        mouseInput.mi.dx = pos.x;
        mouseInput.mi.dy = pos.y;

        UINT uSent = SendInput(1, &mouseInput, sizeof(INPUT));
        if (uSent != 1)
        {
            std::cout << "Input failed!";
        }
    }

    __declspec (dllexport) void __stdcall Java_InputHandler_scrollDown()
    {
        INPUT mouseInput;
        ZeroMemory(&mouseInput, sizeof(mouseInput));
        POINT pos;
        GetCursorPos(&pos);

        mouseInput.type = INPUT_MOUSE;
        mouseInput.mi.dwFlags = MOUSEEVENTF_WHEEL;
        mouseInput.mi.time = NULL;
        mouseInput.mi.mouseData = (DWORD)(-50);
        mouseInput.mi.dx = pos.x;
        mouseInput.mi.dy = pos.y;

        UINT uSent = SendInput(1, &mouseInput, sizeof(INPUT));
        if (uSent != 1)
        {
            std::cout << "Input failed!";
        }
    }

}