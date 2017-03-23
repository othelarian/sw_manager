#ifndef SWMDATABASE_H
#define SWMDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QUrl>
#include <QSqlQuery>

//#include <QSqlError>

class SWMDatabase : public QObject
{
    Q_OBJECT
public:
    static SWMDatabase* getInstance();
    Q_INVOKABLE void openDatabase(QString path,bool create);
    Q_INVOKABLE void closeDatabase();
private:
    SWMDatabase();
    static SWMDatabase* m_instance;
    QSqlDatabase m_db;
};

#endif // SWMDATABASE_H
