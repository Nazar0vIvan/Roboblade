#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QDir>
#include <cstdlib>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    // QObject::connect(
    //     &engine,
    //     &QQmlApplicationEngine::objectCreationFailed,
    //     &app,
    //     []() { QCoreApplication::exit(-1); },
    //     Qt::QueuedConnection);

    // QDir binaryDir = QDir(BINARY_PATH);
    // engine.addImportPath(binaryDir.filePath("qml"));

    // for(const auto& path: engine.importPathList()) {
    //     qDebug() << path;
    // }

    engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));

    return app.exec();
}
