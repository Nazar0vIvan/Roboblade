#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QDir>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QString appDir = QGuiApplication::applicationDirPath();
    QString qmlImportPath = QDir(appDir).filePath("../qml");
    QString componentsImportPath = QDir(appDir).filePath("../qml/Modules/Components");

    engine.addImportPath(qmlImportPath);
    engine.addImportPath(componentsImportPath);

    for(const auto& path : engine.importPathList()) {
        qDebug() << path;
    }

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(QUrl(QStringLiteral("../qml/Main.qml")));

    return app.exec();
}
