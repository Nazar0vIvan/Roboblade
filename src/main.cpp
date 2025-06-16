#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QDir>
#include <cstdlib>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.addImportPath("qrc:/qt/qml/roboblade/");

    // QObject::connect(
    //     &engine,
    //     &QQmlApplicationEngine::objectCreationFailed,
    //     &app,
    //     []() { QCoreApplication::exit(-1); },
    //     Qt::QueuedConnection);

    // QDir binaryDir = QDir(BINARY_PATH);
    // engine.addImportPath(binaryDir.filePath("qml/Modules/Styles"));

    for(const auto& path: engine.importPathList()) {
         qDebug() << path;
    }

    engine.loadFromModule("roboblade", "Main");

    return app.exec();
}
