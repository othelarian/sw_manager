#include "diceroller.h"

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

DiceRoller::DiceRoller() { }

DiceRoller* DiceRoller::getInstance()
{
    if (m_instance == nullptr) m_instance = new DiceRoller();
    return m_instance;
}

int DiceRoller::genRollDice(int nb,int bonus,int selector,bool ace)
{
    int types[] = {2,3,4,6,8,10,12,20,100};
    int tmp = 0;
    int res = 0;
    for (int i = 0;i<nb;i++) {
        tmp = qFloor(qrand()%types[selector])+1;
        res += tmp;
        while (ace && tmp == types[selector]) {
            tmp = qFloor(qrand()%types[selector])+1;
            res += tmp;
        }
    }
    res += bonus;
    return res;
}

void DiceRoller::clearOutput(bool deep) {
    if (deep) { SWMDatabase::getInstance()->clearOutput("basicdice"); }
    m_order = 0;
    m_outputs.clear();
    outputsChanged();
}

void DiceRoller::removeOutput(int index,int outorder)
{
    m_outputs.removeAt(index);
    SWMDatabase::getInstance()->removeOutput("basicdice",outorder);
    outputsChanged();
}

void DiceRoller::rollDice()
{
    int types[] = {2,3,4,6,8,10,12,20,100};
    QString res = QString::number(m_nb) + "d" + QString::number(types[m_selector]);
    res += (m_bonus > 0)? "+" : "";
    res += QString::number(m_bonus) + ": ";
    res += QString::number(genRollDice(m_nb,m_bonus,m_selector,m_ace));
    res += (m_ace)? " (ace)" : "";
    m_order++;
    m_outputs.append(new DiceOutput(m_order,res));
    SWMDatabase::getInstance()->setOutput("basicdice",m_order,res);
    outputsChanged();
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

void DiceRoller::addOutput(int outorder, QString value)
{
    m_outputs.append(new DiceOutput(outorder,value));
    m_order = outorder;
    outputsChanged();
}

QQmlListProperty<DiceOutput> DiceRoller::getOutputs()
{
    return QQmlListProperty<DiceOutput>(this,m_outputs);
}
