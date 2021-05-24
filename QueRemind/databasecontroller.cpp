#include "databasecontroller.h"

DatabaseController::DatabaseController(QObject *parent) : QObject(parent)
{

}

void DatabaseController::slotConnect(QString login, QString password)
{
    USER tmp_user;
    tmp_user.userName = login;
    tmp_user.password = password;

    resultQuery result = db.connect(tmp_user);

    if(result.flag)
        emit connectionSuccessful();
    else
        emit connectionError(result.message);
}

void DatabaseController::slotRegistration(QString login, QString mail, QString password)
{
    USER tmp_user;
    tmp_user.userName = login;
    tmp_user.password = password;

    resultQuery result = db.addUser(tmp_user);

    if(result.flag)
        emit registrationSuccessful();
    else
        emit registrationError(result.message);
}

void DatabaseController::slotAddTask(QString name, QString information, QDate dateStart, QDate dateEnd, QTime timeStart, QTime timeEnd, QString status, QTime remind)
{
    TASK_INFORMATION tmp_task;
    tmp_task.name = name;
    tmp_task.information = information;
    tmp_task.dateStart = dateStart;
    tmp_task.dateEnd = dateEnd;
    tmp_task.timeStart = timeStart;
    tmp_task.timeEnd = timeEnd;
    tmp_task.status = status;
    tmp_task.remind = remind;

    resultQuery result = db.addTask(tmp_task);

    if(result.flag)
        emit taskAddedSuccessful();
    else
        emit error(result.message);
}

void DatabaseController::slotTasksToday()
{
    QList <TASK_INFORMATION> listTasks = db.getTaskByDate(QDate::currentDate(), QDate::currentDate());

    QVector <int> id;
    QVector <QString> name;
    QVector <QString> information;
//    QVector <QDate> dateStart, dateEnd;
    QVector <QTime> timeStart, timeEnd;
    QVector <QString> status;
    QVector <QTime> remind;

    for(int i = 0; i < listTasks.size(); i++)
    {
        id.push_back(listTasks[i].id);
        name.push_back(listTasks[i].name);
        information.push_back(listTasks[i].information);
//        dateStart.push_back(listTasks[i].dateStart);
//        dateEnd.push_back(listTasks[i].dateEnd);
        timeStart.push_back(listTasks[i].timeStart);
        timeEnd.push_back(listTasks[i].timeEnd);
        status.push_back(listTasks[i].status);
        remind.push_back(listTasks[i].remind);
    }

    emit tasksToday(id, name, information, timeStart, timeEnd, status, remind);
}
