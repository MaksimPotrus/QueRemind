#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QDirIterator>
#include <QQuickWindow>

#ifdef Q_OS_WIN
#include "winextras/winextra.h"
#endif

void registerFonts()
{
    QDirIterator it(":/assets/fonts/", QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString fontPath = it.next();
        QFontDatabase::addApplicationFont(fontPath);
    }

    QFont applicationFont("Catamaran");
    applicationFont.setPointSize(11);
    QGuiApplication::setFont(applicationFont);
}

void registerHelpers()
{
    qmlRegisterSingletonType<WinExtra>("WinExtra", 1, 0, "WinExtra", winExtraProvider);
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QLocale::setDefault(QLocale::English);

    registerFonts();
    registerHelpers();

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
