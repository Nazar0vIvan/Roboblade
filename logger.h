#ifndef LOGGER_H
#define LOGGER_H

#include <QObject>
#include <QDebug>
#include <QContiguousCache>

#define CACHE_SIZE 500

// Singleton
class Logger : public QObject
{
    Q_OBJECT

public:
    static Logger* instance() {
       static Logger inst;
       return &inst;
    }

private:
    Logger(QObject *parent = nullptr) : QObject(parent) {}

    QContiguousCache<QString> m_buffer{CACHE_SIZE};

signals:
    void logAdded(const QString& message);

public slots:
    void push(const QString& message){
        m_buffer.prepend(message);
        emit logAdded(message);
    }

};

#endif // LOGGER_H
