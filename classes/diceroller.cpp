#include "diceroller.h"

#include <QDebug>

// DICE OUTPUT ######################

DiceOutput::DiceOutput(QObject *parent) : QObject(parent) {}

DiceOutput::DiceOutput(int outorder, const QString &value, QObject *parent) : QObject(parent)
{
    m_outorder = outorder;
    m_value = value;
}

int DiceOutput::outorder() { return m_outorder; }

QString DiceOutput::value() { return m_value; }

// DICEROLLER #######################

DiceRoller* DiceRoller::m_instance = nullptr;

DiceRoller::DiceRoller()
{
    //
    // TEST
    m_outputs.append(new DiceOutput(0,"test 0"));
    m_outputs.append(new DiceOutput(1,"test 1"));
    m_outputs.append(new DiceOutput(2,"test 2"));
    // TEST
    //
}

DiceRoller* DiceRoller::getInstance()
{
    if (m_instance == nullptr) m_instance = new DiceRoller();
    return m_instance;
}

QString DiceRoller::genRollDice(int nb,int bonus,int selector,bool ace)
{
    int types[] = {2,3,4,6,8,10,12,20,100};
    QString res = "";
    //
    qInfo() << "type: " << types[selector];
    //
    int tmp = qrand()%types[selector]+1;
    //
    qInfo() << "res = " << tmp;
    //
    return "";
    //
}

QString DiceRoller::rollDice()
{
    //
    // m_nb , m_bonus , m_ace
    //
    // TODO : determine type of dice
    //
    qInfo() << "selector: " << m_selector;
    //
    //
    //
    QString res = "";
    //
    //int tmp = qrand()%(types[m_selector])+1;
    //
    //qInfo() << tmp;
    //
    genRollDice(m_nb,m_bonus,m_selector,m_ace);
    //
    // TODO : add to the input
    //
    return "";
}

QString DiceRoller::getParameters()
{
    QStringList params;
    params << QVariant(m_nb).toString() << QVariant(m_bonus).toString();
    params << QVariant(m_selector).toString() << QVariant(m_ace).toString();
    return params.join(",");
}

void DiceRoller::setParameter(QString name, int value, bool save)
{
    if (name == "nb") m_nb = value;
    else if (name == "bonus") m_bonus = value;
    else if (name == "selector") m_selector = value;
    else if (name == "ace") m_ace = (value == 0)? false : true;
    if (save) SWMDatabase::getInstance()->saveParameter(name+"dice",QString::number(value));
}

QQmlListProperty<DiceOutput> DiceRoller::getOutputs()
{
    return QQmlListProperty<DiceOutput>(this,m_outputs);
}
