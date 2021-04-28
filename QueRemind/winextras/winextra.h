#ifndef WINEXTRA_H
#define WINEXTRA_H

#include <QObject>
#include <QQuickWindow>
#include <QQmlEngine>

class WinExtra : public QObject
{
    Q_OBJECT
public:
    explicit WinExtra(QObject *parent = nullptr);
    ~WinExtra();

    Q_INVOKABLE static void initBlur(QQuickWindow *window);
};

static inline QObject *winExtraProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(scriptEngine)
    WinExtra *instance = new WinExtra(engine);
    return instance;
}

#endif // WINEXTRA_H
