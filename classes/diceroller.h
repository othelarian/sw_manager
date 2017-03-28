#ifndef DICEROLLER_H
#define DICEROLLER_H

#include <QObject>
#include <QVariant>
#include <QList>
#include <QQmlListProperty>

#include "swmdatabase.h"

class DiceOutput : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int outorder READ outorder NOTIFY outorderChanged)
    Q_PROPERTY(QString value READ value NOTIFY valueChanged)
public:
    DiceOutput(QObject *parent = 0);
    DiceOutput(int outorder, const QString &value, QObject *parent = 0);
    int outorder();
    QString value();
private:
    int m_outorder;
    QString m_value;
signals:
    //
    void outorderChanged();
    void valueChanged();
    //
};

class DiceRoller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<DiceOutput> outputs READ getOutputs NOTIFY outputsChanged)
public:
    static DiceRoller* getInstance();
    static QString genRollDice(int nb,int bonus,int selector,bool ace);
    Q_INVOKABLE QString rollDice();
    Q_INVOKABLE QString getParameters();
    Q_INVOKABLE void setParameter(QString name,int value,bool save = true);
    //
    Q_INVOKABLE QQmlListProperty<DiceOutput> getOutputs();
    //
private:
    DiceRoller();
    static DiceRoller* m_instance;
    int m_nb;
    int m_bonus;
    int m_selector;
    bool m_ace;
    //
    QList<DiceOutput*> m_outputs;
    //
signals:
    //
    void outputsChanged();
    //
};

#endif // DICEROLLER_H
