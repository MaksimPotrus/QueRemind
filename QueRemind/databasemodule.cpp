#include "databasemodule.h"

DatabaseModule::DatabaseModule()
{
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("185.224.138.217");
    db.setPort(3306);
    db.setDatabaseName("u377782896");
    db.setUserName("u377782896_root");
    db.setPassword("19832002121Whoami???");

    if(db.open())
        lastError.flag = false;
    else
    {
        lastError.flag = true;
        lastError.message = "Error connection! Server lost!";
    }
}

resultQuery DatabaseModule::connect(USER userToConnect)
{
    resultQuery result;

    QSqlQuery qu;
    qu.prepare("SELECT id FROM user_information WHERE user_name = :login");
    qu.bindValue(":login", userToConnect.userName);
    qu.exec();

    if(qu.size() != 0)
    {
        qu.prepare("SELECT * FROM user_information WHERE user_name = :login AND password = :password");
        qu.bindValue(":login", userToConnect.userName);
        qu.bindValue(":password", userToConnect.password);
        qu.exec();

        if(qu.size() != 0)
        {
            connectedUser.id = qu.value(0).toInt();
            connectedUser.userName = qu.value(1).toString();
            connectedUser.password = qu.value(2).toString();

            result.flag = true;
            result.message = "User connected!";
        }
        else
        {
            result.flag = false;
            result.message = "Uncorrect password";
            lastError.flag = true;
            lastError.message = "Connection error! " + result.message;
        }
    }
    else
    {
        result.flag = false;
        result.message = "User don`t found!";
        lastError.flag = true;
        lastError.message = "Connection error! " + result.message;
    }

    return result;
}

resultQuery DatabaseModule::addTask(TASK_INFORMATION taskToAdd)
{
    resultQuery result;

    QSqlQuery qu;
    qu.prepare("INSERT INTO task_information (task_name, task_information, task_date_start, task_date_end, task_time_start, task_time_end, task_status, task_remind) VALUES(:name, :information, :dateStart, :dateEnd, :timeStart, :timeEnd, :status, :remind)");
    qu.bindValue(":name", taskToAdd.name);
    qu.bindValue(":information", taskToAdd.information);
    qu.bindValue(":dateStart", taskToAdd.dateStart);
    qu.bindValue(":dateEnd", taskToAdd.dateEnd);
    qu.bindValue(":timeStart", taskToAdd.timeStart);
    qu.bindValue(":timeEnd", taskToAdd.timeEnd);
    qu.bindValue(":status", taskToAdd.status);
    qu.bindValue(":remind", taskToAdd.remind);

    qu.exec();

    if(qu.lastError().type() == qu.lastError().NoError)
    {
        qu.prepare("INSERT INTO find (user_id, task_id) VALUES(:userId, :taskId)");
        qu.bindValue(":userId", connectedUser.id);
        qu.bindValue(":taskId", taskToAdd.id);
        qu.exec();

        if(qu.lastError().type() == qu.lastError().NoError)
        {
            result.flag = true;
            result.message = "Task added!";
        }
        else
        {
            result.flag = false;
            result.message = "Task don`t added!";
            lastError.flag = true;
            lastError.message = "Connection error! " + result.message;
        }
    }
    else
    {
        result.flag = false;
        result.message = "Task don`t added!";
        lastError.flag = true;
        lastError.message = "Connection error! " + result.message;
    }

    return result;
}

resultQuery DatabaseModule::deleteTask(int idTaskToDelete)
{
    resultQuery result;

    QSqlQuery qu;
    qu.prepare("DELETE FROM find WHERE task_id = :id");
    qu.bindValue(":id", idTaskToDelete);
    qu.exec();

    qu.prepare("DELETE FROM task_information WHERE task_id = :id");
    qu.bindValue(":id", idTaskToDelete);
    qu.exec();

    result.flag = true;
    result.message = "Task delete!";

    return result;
}

resultQuery DatabaseModule::setTask(TASK_INFORMATION taskToSet)
{
    resultQuery result;

    QSqlQuery qu;
    qu.prepare("UPDATE task_information SET task_name = :name, task_information = :information, task_date_start = :dateStart, task_date_end = :dateEnd, task_time_start = :timeStart, task_time_end = :timeEnd, task_status = :status, task_remind = :remind WHERE task_id = :id");
    qu.bindValue(":id", taskToSet.id);
    qu.bindValue(":name", taskToSet.name);
    qu.bindValue(":information", taskToSet.information);
    qu.bindValue(":dateStart", taskToSet.dateStart);
    qu.bindValue(":dateEnd", taskToSet.dateEnd);
    qu.bindValue(":timeStart", taskToSet.timeStart);
    qu.bindValue(":timeEnd", taskToSet.timeEnd);
    qu.bindValue(":status", taskToSet.status);
    qu.bindValue(":remind", taskToSet.remind);

    qu.exec();

    result.flag = true;
    result.message = "Task updated!";
    return result;
}

resultQuery DatabaseModule::setPassword(QString newPassword)
{
    resultQuery result;

    connectedUser.password = newPassword;

    QSqlQuery qu;
    qu.prepare("UPDATE user_information SET password = :password WHERE user_id = :id");
    qu.bindValue(":id", connectedUser.id);
    qu.bindValue(":password", connectedUser.password);
    qu.exec();

    result.flag = true;
    result.message = "Password update!";
    return result;
}

TASK_INFORMATION DatabaseModule::getTaskById(int taskId)
{
    TASK_INFORMATION tmp;

    QSqlQuery qu;
    qu.prepare("SELECT * FROM task_information WHERE task_id = :id");
    qu.bindValue(":id", taskId);

    qu.exec();

    if(qu.next())
    {
        tmp.id = qu.value(0).toInt();
        tmp.name = qu.value(1).toString();
        tmp.information = qu.value(2).toString();
        tmp.dateStart = qu.value(3).toDate();
        tmp.dateEnd = qu.value(4).toDate();
        tmp.timeStart = qu.value(5).toTime();
        tmp.timeEnd = qu.value(6).toTime();
        tmp.status = qu.value(7).toString();
        tmp.remind = qu.value(8).toTime();
    }
    else
        tmp.id = -1;

    return tmp;
}

QList <TASK_INFORMATION> DatabaseModule::getTaskByDate(QDate dateStart, QDate dateEnd)
{
    QList <TASK_INFORMATION> listTasks;
    TASK_INFORMATION tmp;

    QSqlQuery qu;
    qu.prepare("SELECT * FROM task_information WHERE task_date_start >= :dateStart AND task_date_start <= :dateEnd");
    qu.bindValue(":dateStart", dateStart);
    qu.bindValue(":dateEnd", dateEnd);

    qu.exec();

    while(qu.next())
    {
        tmp.id = qu.value(0).toInt();
        tmp.name = qu.value(1).toString();
        tmp.information = qu.value(2).toString();
        tmp.dateStart = qu.value(3).toDate();
        tmp.dateEnd = qu.value(4).toDate();
        tmp.timeStart = qu.value(5).toTime();
        tmp.timeEnd = qu.value(6).toTime();
        tmp.status = qu.value(7).toString();
        tmp.remind = qu.value(8).toTime();

        listTasks.push_back(tmp);
    }

    return listTasks;
}

QList <TASK_INFORMATION> DatabaseModule::getAllTask()
{
    QList <TASK_INFORMATION> listTasks;
    TASK_INFORMATION tmp;

    QSqlQuery qu;
    qu.prepare("SELECT * FROM task_information");

    qu.exec();

    while(qu.next())
    {
        tmp.id = qu.value(0).toInt();
        tmp.name = qu.value(1).toString();
        tmp.information = qu.value(2).toString();
        tmp.dateStart = qu.value(3).toDate();
        tmp.dateEnd = qu.value(4).toDate();
        tmp.timeStart = qu.value(5).toTime();
        tmp.timeEnd = qu.value(6).toTime();
        tmp.status = qu.value(7).toString();
        tmp.remind = qu.value(8).toTime();

        listTasks.push_back(tmp);
    }

    return listTasks;
}

resultQuery DatabaseModule::getLastError()
{
    return lastError;
}

resultQuery DatabaseModule::addUser(USER userToAdd)
{
    resultQuery result;

    QSqlQuery qu;
    qu.prepare("SELECT id FROM user_information WHERE user_name = :login");
    qu.bindValue(":login", userToAdd.userName);

    qu.exec();

    if(qu.size() == 0)
    {
        qu.prepare("INSERT INTO user_information (user_name, password) VALUES (:login, :password)");
        qu.exec();

        if(qu.lastError().type() == qu.lastError().NoError)
            result.flag = true;
        else
        {
            result.flag = false;
            result.message = "Failed Registration! " + qu.lastError().text();
        }
    }
    else
    {
        result.flag = false;
        result.message = "Failed Registration! A user with this login already exists.";
    }

    return result;
}
