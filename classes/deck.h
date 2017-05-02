#ifndef DECK_H
#define DECK_H

#include <QObject>
#include <QVariant>
#include <QList>
#include <QQmlListProperty>

//#include "swmdatabase.h"

class DeckOutput : public QObject
{
    Q_OBJECT
    //
public:
    DeckOutput(QObject *parent = 0);
    //
    //
private:
    //
    //
};

class Deck : public QObject
{
    Q_OBJECT
    //
public:
    Deck();
    //static Deck* getInstance();
    //
    Q_INVOKABLE QString getParameters();
    Q_INVOKABLE void setParameter(QString name,int value, bool save);
    //
private:
    //Deck();
    //static Deck* m_instance;
    int m_idx;
    //
    //int m_cards[54];
    QList<int> m_cards;
    //
    //
    QList<DeckOutput*> m_outputs;
};

#endif // DECK_H
