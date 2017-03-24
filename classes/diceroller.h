#ifndef DICEROLLER_H
#define DICEROLLER_H

#include <QObject>

class DiceRoller
{
public:
    DiceRoller();
    //static void rollDice();
    void setParameter(QString name,int value);
private:
    int m_nbdice;
    int m_bonusdice;
    int m_selectordice;
    bool m_acedice;
};

#endif // DICEROLLER_H
