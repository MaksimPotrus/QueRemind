#ifndef DATABASECONTROLLER_H
#define DATABASECONTROLLER_H

#include <QObject>

#include "databasemodule.h"

class DatabaseController : public QObject
{
    Q_OBJECT

    DatabaseModule db;
public:
    explicit DatabaseController(QObject *parent = nullptr);

signals:
    void connectionSuccessful();
    void connectionError(QString messageError);
    void registrationSuccessful();
    void registrationError(QString messageError);
    void error(QString messageError);
    void tasksToday(QVector <int> id, QVector <QString> name, QVector <QString> information, QVector <QTime> timeStart, QVector <QTime> timeEnd, QVector <QString> status, QVector <QTime> remind);
    void taskAddedSuccessful();

public slots:
    void slotConnect(QString login, QString password);
    void slotRegistration(QString login, QString mail, QString password);
    void slotAddTask(QString name, QString information, QDate dateStart, QDate dateEnd, QTime timeStart, QTime timeEnd, QString status, QTime remind);
    void slotTasksToday();
};

#endif // DATABASECONTROLLER_H
