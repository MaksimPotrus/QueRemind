QT += quick winextras

CONFIG += c++11

SOURCES += \
        main.cpp \
        winextras/winextra.cpp

HEADERS += \
    winextras/winextra.h \
    winextras/winstructs.h

RESOURCES += qml.qrc \
    fonts.qrc \
    icons.qrc \
    images.qrc

QML_IMPORT_PATH =
QML_DESIGNER_IMPORT_PATH =

LIBS += -lGdi32 -lDwmapi

DISTFILES +=
