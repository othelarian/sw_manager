#include "deck.h"

#include <QDebug>

// DECK OUTPUT ######################

DeckOutput::DeckOutput(QObject *parent) : QObject(parent) {}

// DECK #############################

//Deck* Deck::m_instance = nullptr;

Deck::Deck() {
    //
    //
}

/*
Deck* Deck::getInstance()
{
    if (m_instance == nullptr) m_instance = new Deck();
    return m_instance;
}
*/

QString Deck::getParameters()
{
    //
    QStringList params;
    //
    //params << ;
    //
}

void Deck::setParameter(QString name, int value, bool save)
{
    //
    //
}
