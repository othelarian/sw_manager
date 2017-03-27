#include "diceroller.h"

#include <QDebug>

DiceRoller::DiceRoller()
{
}

QString DiceRoller::genRollDice(int nb,int bonus,int selector,bool ace)
{
    int types[] = {2,3,4,6,8,10,12,20,100};
    QString res = "";
    //
    int tmp = 0;
    //
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
    qInfo() << "selector: " << QString::number(m_selector);
    //
    //
    qInfo() << "type: " << QString::number(types[m_selector]);
    //
    QString res = "";
    //
    //int tmp = qrand()%(types[m_selector])+1;
    //
    qInfo() << tmp;
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

void DiceRoller::setParameter(QString name, int value)
{
    if (name == "nb") m_nb = value;
    else if (name == "bonus") m_bonus = value;
    else if (name == "selector") m_selector = value;
    else if (name == "ace") m_ace = (value == 0)? false : true;
}
