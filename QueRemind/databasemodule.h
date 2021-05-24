#ifndef DATABASEMODULE_H
#define DATABASEMODULE_H

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QVariant>
#include <QDebug>
#include <QSqlError>

#include "objectsdatabase.h"

struct resultQuery
{
    bool flag;
    QString message;
};

class DatabaseModule
{
    QSqlDatabase    db;
    USER            connectedUser;
    resultQuery     lastError;

public:
    DatabaseModule();

    resultQuery getLastError();
    resultQuery connect(USER userToConnect);

    resultQuery     addTask(TASK_INFORMATION taskToAdd);
    resultQuery     deleteTask(int idTaskToDelete);
    resultQuery     setTask(TASK_INFORMATION taskToSet);
    resultQuery     setPassword(QString newPassword);

    TASK_INFORMATION    getTaskById(int taskId);
    QList <TASK_INFORMATION>    getAllTask();
    QList <TASK_INFORMATION>    getTaskByDate(QDate dateStart, QDate dateEnd);
};

#endif // DATABASEMODULE_H
