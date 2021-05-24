QT += quick winextras sql

CONFIG += c++11

SOURCES += \
        databasecontroller.cpp \
        databasemodule.cpp \
        main.cpp \
        winextras/winextra.cpp

HEADERS += \
    databasecontroller.h \
    databasemodule.h \
    objectsdatabase.h \
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
