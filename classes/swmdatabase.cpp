#include "swmdatabase.h"

#include <QDebug>

SWMDatabase* SWMDatabase::m_instance = nullptr;

SWMDatabase::SWMDatabase()
{
    m_db = QSqlDatabase::addDatabase("QSQLITE");
}

SWMDatabase* SWMDatabase::getInstance()
{
    if (m_instance == nullptr) m_instance = new SWMDatabase();
    return m_instance;
}

void SWMDatabase::openDatabase(QString path,bool create)
{
    //
    qInfo("try to open database...");
    //
    qInfo() << path;
    //
    //m_db.setDatabaseName(path);
    //QSqlQuery query;
    //query.prepare();
    //
    //
}

void SWMDatabase::closeDatabase() { m_db.close(); }
