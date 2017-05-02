#ifndef SWMDATABASE_H
#define SWMDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QUrl>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QVariant>

//#include <QSqlError>

#include "diceroller.h"
#include "deck.h"

class Deck;

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
    Q_INVOKABLE void setInfos(const QString info,const QString value);
    Q_INVOKABLE void setInfos(const QString info,int value);
    void saveParameter(QString name,QString value);
    //
    void setOutput(QString type,int outorder,QString value);
    void removeOutput(QString type,int outorder);
    void clearOutput(QString type);
    //
private:
    SWMDatabase();
    static SWMDatabase* m_instance;
    QSqlDatabase m_db;
    struct gameInfos m_infos;
    //
    Deck m_basicdeck;
    //
    // TODO : add deck class
    //
signals:
    //
    //void infosChanged();
    //
};

#endif // SWMDATABASE_H
