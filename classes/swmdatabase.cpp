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
    DiceRoller* diceroller = DiceRoller::getInstance();
    m_db.setDatabaseName(QUrl(path).toLocalFile());
    m_db.open();
    QSqlQuery query;
    // populate the database if it's a creation
    if (create) {
        query.exec("CREATE TABLE parameters (name TEXT,value TEXT);");
        query.exec("CREATE TABLE outputs (type TEXT,value TEXT,outorder INT);");
        query.exec("CREATE TABLE decks (name TEXT,cardorder TEXT,curridx INT);");
        QStringList values;
        values << "('title','Untitled')";
        values << "('nbdice','1')" << "('bonusdice','0')";
        values << "('selectordice','0')" << "('acedice','0')";
        //
        query.exec("INSERT INTO parameters VALUES"+values.join(",")+";");
        //
        values.clear();
        for (int i = 0;i<54;i++) { values.append(QString::number(i)); }
        //
        query.exec("INSERT INTO decks VALUES('basicdeck','"+values.join(",")+"',-1);");
    }
    // initialize the parameters
    query.exec("SELECT * FROM parameters;");
    int nameNo = query.record().indexOf("name");
    int valueNo = query.record().indexOf("value");
    while (query.next()) {
        if (query.value(nameNo).toString() == "title") m_infos.title = query.value(valueNo).toString();
        else if (query.value(nameNo).toString().endsWith("dice")) {
            QString label = query.value(nameNo).toString(); label.chop(4);
            diceroller->setParameter(label,query.value(valueNo).toInt(),false);
        }
        //
        // TODO : get the others paramaters
        //
    }
    // initialize outputs
    diceroller->clearOutput();
    query.exec("SELECT * FROM outputs WHERE type='basicdice' ORDER BY outorder;");
    int outorderNo = query.record().indexOf("outorder");
    int outvalueNo = query.record().indexOf("value");
    while (query.next()) {
        diceroller->addOutput(query.value(outorderNo).toInt(),query.value(outvalueNo).toString());
    }
    //
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

// OUTPUTS GETTERS / SETTERS #######

void SWMDatabase::setOutput(QString type,int outorder,QString value)
{
    QSqlQuery query;
    query.prepare("INSERT INTO outputs VALUES(:type,:value,:outorder);");
    query.bindValue(":type",type);
    query.bindValue(":value",value);
    query.bindValue(":outorder",outorder);
    query.exec();
}

void SWMDatabase::removeOutput(QString type, int outorder)
{
    QSqlQuery query;
    query.prepare("DELETE FROM outputs WHERE type=:type AND outorder=:outorder;");
    query.bindValue(":type",type);
    query.bindValue(":outorder",outorder);
    query.exec();
}

void SWMDatabase::clearOutput(QString type)
{
    QSqlQuery query;
    query.prepare("DELETE FROM outputs WHERE type=:type;");
    query.bindValue(":type",type);
    query.exec();
}

// PARAMETERS METHODS ##############

void SWMDatabase::saveParameter(QString name, QString value)
{
    QSqlQuery query;
    query.prepare("UPDATE parameters SET value=:value WHERE name=:name;");
    query.bindValue(":value",value);
    query.bindValue(":name",name);
    query.exec();
}
