#ifndef DICEROLLER_H
#define DICEROLLER_H

#include <QObject>
#include <QVariant>

class DiceRoller
{
public:
    DiceRoller();
    static QString genRollDice(int nb,int bonus,int selector,bool ace);
    QString rollDice();
    QString getParameters();
    void setParameter(QString name,int value);
private:
    int m_nb;
    int m_bonus;
    int m_selector;
    bool m_ace;
    //
    QStringList output;
    //
};

#endif // DICEROLLER_H
