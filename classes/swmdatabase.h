#ifndef SWMDATABASE_H
#define SWMDATABASE_H

#include <QObject>

class SWMDatabase : public QObject
{
    Q_OBJECT
public:
    static SWMDatabase* getInstance();
    void openDatabase(QString path);
private:
    SWMDatabase();
    static SWMDatabase* m_instance;
};

#endif // SWMDATABASE_H
