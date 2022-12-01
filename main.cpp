#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSurfaceFormat>
#include <QFontDatabase>
#include <QDebug>
#include <iostream>

#include "logger.h"
#include "socketrdt.h"
#include "socketrsi.h"
#include "sockethou.h"
#include "socketmodbustcp.h"

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);

    QFontDatabase::addApplicationFont("://main/OpenSans-Bold.ttf");
    QFontDatabase::addApplicationFont("://main/OpenSans-Italic.ttf");
    QFontDatabase::addApplicationFont("://main/OpenSans-Regular.ttf");
    QFontDatabase::addApplicationFont("://main/Roboto-Bold.ttf");
    QFontDatabase::addApplicationFont("://main/Roboto-Medium.ttf");
    QFontDatabase::addApplicationFont("://main/Roboto-Regular.ttf");
    QFontDatabase::addApplicationFont("://main/Nasalization-Regular.ttf");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    engine.addImportPath("D:/Qt/QtProjects/Roboblade");
    engine.addImportPath("C:/Qt/QtProjects/Roboblade");
    engine.addImportPath(":/Modules");

    QQmlContext* rootContext = engine.rootContext();

    rootContext->setContextProperty("applicationDirPath", QString(QApplication::applicationDirPath()));

    rootContext->setContextProperty("logger", Logger::instance());

    SocketRSI socketRSI("KR C4");
    rootContext->setContextProperty("socketRSI", &socketRSI);

    SocketRDT socketRDT("F/T Sensor");
    rootContext->setContextProperty("socketRDT", &socketRDT);

    SocketHou socketHou("Houdini");
    rootContext->setContextProperty("socketHou", &socketHou);

    SocketModbusTCP socketVFDA65("VFD/A65");
    rootContext->setContextProperty("socketVFDA65", &socketVFDA65);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl){if (!obj && url == objUrl) QCoreApplication::exit(-1);}, Qt::QueuedConnection);

    qmlRegisterSingletonType(QUrl("qrc:/AppStyle.qml"), "AppStyle", 1, 0, "AppStyle" );

    engine.load(url);

    // timer
    QTimer timer;
    timer.setInterval(1000);
    rootContext->setContextProperty("timer", &timer);

    QObject::connect(&timer, &QTimer::timeout, &socketRDT, &Socket::readyRead);

    return app.exec();
}
