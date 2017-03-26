#ifndef DICEROLLER_H
#define DICEROLLER_H

#include <QObject>
#include <QVariant>

class DiceRoller
{
public:
    DiceRoller();
    //static void rollDice();
    QString rollDice();
    QString getParameters();
    void setParameter(QString name,int value);
private:
    int m_nb;
    int m_bonus;
    int m_selector;
    bool m_ace;
};

#endif // DICEROLLER_H
