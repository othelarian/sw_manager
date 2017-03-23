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
    m_db.setDatabaseName(QUrl(path).toLocalFile());
    m_db.open();
    QSqlQuery query;
    // populate the database if it's a creation
    if (create) {
        query.exec("CREATE TABLE parameters (name TEXT,value TEXT);");
        query.exec("CREATE TABLE outputs (type TEXT,value TEXT,outorder INT);");
        query.exec("CREATE TABLE decks (name TEXT,cardorder INT,value INT);");
        QStringList values;
        values << "('title','')";
        //
        query.exec("INSERT INTO parameters VALUES"+values.join(",")+";");
    }
    //
    //query.prepare();
    //
    //query.exec("SELECT * FROM parameters;");
    //
    //
}

void SWMDatabase::closeDatabase() {
    //
    // TODO : optimize the database
    //
    //QSqlQuery query("REINDEX;");
    //
    m_db.close();
}
