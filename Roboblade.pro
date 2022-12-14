QT += quick
QT += widgets
QT += charts
QT += xml
QT += svg

CONFIG += c++11
CONFIG += console

RC_ICONS = appico.ico

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        socket.cpp \
        sockethou.cpp \
        socketmodbustcp.cpp \
        socketrdt.cpp \
        socketrsi.cpp

RESOURCES += qml.qrc \
    fonts.qrc \
    icons.qrc \
    modules.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/Modules

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    logger.h \
    socket.h \
    sockethou.h \
    socketmodbustcp.h \
    socketrdt.h \
    socketrsi.h
