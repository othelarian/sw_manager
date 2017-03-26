#include "swmdatabase.h"

#include <QDebug>

SWMDatabase* SWMDatabase::m_instance = nullptr;

// DATABASE INSTANCE ###############

SWMDatabase::SWMDatabase() { m_db = QSqlDatabase::addDatabase("QSQLITE"); }

SWMDatabase* SWMDatabase::getInstance()
{
    if (m_instance == nullptr) m_instance = new SWMDatabase();
    return m_instance;
}

// CONNEXION DATABASE ##############

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
        values << "('title','Untitled')";
        values << "('nbdice','1')" << "('bonusdice','0')";
        values << "('selectordice','0')" << "('acedice','0')";
        //
        query.exec("INSERT INTO parameters VALUES"+values.join(",")+";");
    }
    // initialize the parameters
    query.exec("SELECT * FROM parameters;");
    int nameNo = query.record().indexOf("name");
    int valueNo = query.record().indexOf("value");
    while (query.next()) {
        if (query.value(nameNo).toString() == "title") m_infos.title = query.value(valueNo).toString();
        else if (query.value(nameNo).toString().endsWith("dice")) {
            QString label = query.value(nameNo).toString(); label.chop(4);
            m_diceroller.setParameter(label,query.value(valueNo).toInt());
        }
        //
        // TODO : get the others paramaters
        //
    }
    //
    // TODO : get the outputs
    //
}

void SWMDatabase::closeDatabase()
{
    //
    // TODO : optimize the database
    //
    //QSqlQuery query("REINDEX;");
    //
    m_db.close();
}

// INFOS GETTER / SETTERS ##########

QString SWMDatabase::getInfos()
{
    //
    // TODO : manage answer for the infos
    //
    return m_infos.title;
}

void SWMDatabase::setInfos(QString info, QString value)
{
    QSqlQuery query;
    query.prepare("UPDATE parameters SET value=:value WHERE name=:info;");
    query.bindValue(":value",value);
    query.bindValue(":info",info);
    query.exec();
    if (info == "title") m_infos.title = value;
    //
    // TODO : add other infos
    //
}

void SWMDatabase::setInfos(QString info, int value)
{
    //
    qInfo("int setinfos");
    //
}

// DICEROLLERS METHODS #############

QString SWMDatabase::getDiceroller() { return m_diceroller.getParameters(); }

QString SWMDatabase::rollDice()
{
    //
    //
    return "dice result";
    //
}

void SWMDatabase::setDiceroller(QString label, int value)
{
    //
    // TODO : really change value
    //
    qInfo() << "label: " << label << " - value: " << value;
    //
}
