#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.addImportPath("E:/Qt/QtProjects/Roboblade/build/Desktop_Qt_6_6_3_MinGW_64_bit-Debug");
    engine.addImportPath("E:/Qt/QtProjects/Roboblade/build/Desktop_Qt_6_6_3_MinGW_64_bit-Debug/frontend");
    engine.addImportPath(":/");

    for(const auto& path : engine.importPathList()) {
        qDebug() << path;
    }

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("frontend", "Main");

    return app.exec();
}
