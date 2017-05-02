#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QDebug>

#include "classes/swmdatabase.h"
#include "classes/diceroller.h"
#include "classes/deck.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    // set new qml types
    qmlRegisterType<DiceOutput>("SWManager",1,0,"DiceOutput");
    // load the root elements
    SWMDatabase* swmdb = SWMDatabase::getInstance();
    DiceRoller* diceMgr = DiceRoller::getInstance();
    //
    // set the engine
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("swmdb",swmdb);
    engine.rootContext()->setContextProperty("diceMgr",diceMgr);
    //
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    // launch the app
    return app.exec();
}
