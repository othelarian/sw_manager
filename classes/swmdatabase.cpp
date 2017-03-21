#include "swmdatabase.h"

SWMDatabase* SWMDatabase::m_instance = nullptr;

SWMDatabase::SWMDatabase()
{
}

SWMDatabase* SWMDatabase::getInstance()
{
    if (m_instance == nullptr) m_instance = new SWMDatabase();
    return m_instance;
}

void SWMDatabase::openDatabase(QString path)
{
    //
    qInfo("try to open database...");
    //
}
