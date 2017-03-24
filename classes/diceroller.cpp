#include "diceroller.h"

DiceRoller::DiceRoller()
{
}

//static void rollDice()

void DiceRoller::setParameter(QString name, int value)
{
    if (name == "nb") m_nbdice = value;
    else if (name == "bonus") m_bonusdice = value;
    else if (name == "selector") m_selectordice = value;
    else if (name == "ace") m_acedice = (value == 0)? false : true;
    //
}
