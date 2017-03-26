#include "diceroller.h"

DiceRoller::DiceRoller()
{
}

//static void rollDice()

QString DiceRoller::rollDice()
{
    //
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
