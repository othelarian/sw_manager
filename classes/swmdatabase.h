#ifndef SWMDATABASE_H
#define SWMDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QUrl>
#include <QSqlQuery>
#include <QSqlRecord>

//#include <QSqlError>

#include "diceroller.h"

struct gameInfos {
    QString title;
    //
};

class SWMDatabase : public QObject
{
    Q_OBJECT
public:
    static SWMDatabase* getInstance();
    Q_INVOKABLE void openDatabase(QString path,bool create);
    Q_INVOKABLE void closeDatabase();
    Q_INVOKABLE QString getInfos();
    Q_INVOKABLE void setInfos(QString info,QString value);
    Q_INVOKABLE void setInfos(QString info,int value);
    Q_INVOKABLE QString getDiceroller();
    Q_INVOKABLE QString rollDice();
    Q_INVOKABLE void setDiceroller(QString label,int value);
private:
    SWMDatabase();
    static SWMDatabase* m_instance;
    QSqlDatabase m_db;
    struct gameInfos m_infos;
    DiceRoller m_diceroller;
    //
    // TODO : add deck class
    //
};

#endif // SWMDATABASE_H
