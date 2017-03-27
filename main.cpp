#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "classes/swmdatabase.h"

int main(int argc, char *argv[])
{
    // load the root elements
    QGuiApplication app(argc, argv);
    SWMDatabase* swmdb = SWMDatabase::getInstance();
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("swmdb",swmdb);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    // launch the app
    return app.exec();
}
