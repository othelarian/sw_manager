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
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    // enable database singleton
    engine.rootContext()->setContextProperty("swmdb",swmdb);
    // launch the app
    return app.exec();
}
