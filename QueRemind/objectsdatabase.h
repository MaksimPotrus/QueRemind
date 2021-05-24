#ifndef OBJECTSDATABASE_H
#define OBJECTSDATABASE_H

#include <QString>
#include <QDate>
#include <QTime>

struct TASK_INFORMATION
{
    int id = 0;
    QString     name;
    QString     information;
    QDate       dateStart;
    QDate       dateEnd;
    QTime       timeStart;
    QTime       timeEnd;
    QString     status;
    QTime       remind;
};

struct USER
{
    int id = 0;
    QString userName;
    QString password;
    QVector <TASK_INFORMATION> listTasks;
};

#endif // OBJECTSDATABASE_H
