#include "winextra.h"

#include <QGuiApplication>
#include <QDebug>
#include <QStyleHints>

#ifdef Q_OS_WIN
#include "winstructs.h"
#include <WinUser.h>
#include <uxtheme.h>
#include <dwmapi.h>
#endif

WinExtra::WinExtra(QObject *parent)
    : QObject(parent)
{

}

WinExtra::~WinExtra()
{

}

void WinExtra::initBlur(QQuickWindow *window)
{
#ifdef Q_OS_WIN
    HWND hwnd = (HWND) window->winId();
    HMODULE hUser = GetModuleHandle(L"user32.dll");
    if (hUser) {
        pfnSetWindowCompositionAttribute setWindowCompositionAttribute = (pfnSetWindowCompositionAttribute)
                GetProcAddress(hUser, "SetWindowCompositionAttribute");
        if (setWindowCompositionAttribute) {
            ACCENT_POLICY accent = { ACCENT_ENABLE_BLURBEHIND, 0, 0, 0 };
            WINDOWCOMPOSITIONATTRIBDATA data;
            data.Attrib = WCA_ACCENT_POLICY;
            data.pvData = &accent;
            data.cbData = sizeof(accent);
            setWindowCompositionAttribute(hwnd, &data);
        }
    }
#endif
}

