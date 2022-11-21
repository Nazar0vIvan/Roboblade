#ifndef SOCKET_H
#define SOCKET_H

#include <QUdpSocket>
#include <QHostAddress>
#include <QDateTime>
#include <QAbstractTableModel>
#include <QtQml/qqmlregistration.h>

#include "logger.h"

struct Parameter{
  QString  name;
  QString  type;
  QString  unit;
  double   min = 0.0;
  double   max = 0.0;
  QVariant value = 0.0;
};

/*
    Q_OBJECT

    Q_PROPERTY(QString  name  READ name  CONSTANT )
    Q_PROPERTY(QString  dim   READ dim   CONSTANT )
    Q_PROPERTY(QString  unit  READ unit  CONSTANT )
    Q_PROPERTY(double   min   READ min   CONSTANT )
    Q_PROPERTY(double   max   READ max   CONSTANT )
    Q_PROPERTY(QVariant value READ value NOTIFY valueChanged)

public:
    Parameter(const QString& name, const QString& dim, const QString& unit, const double min, const double max) :
        m_name(name), m_dim(dim), m_unit(unit), m_min(min), m_max(max){}

    QString name()   const { return m_name;  }
    QString dim()    const { return m_dim;   }
    QString unit()   const { return m_unit;  }
    double min()     const { return m_min;   }
    double max()     const { return m_max;   }
    QVariant value() const { return m_value; }

signals:
    void valueChanged();

private:
    QString  m_name;
    QString  m_dim;
    QString  m_unit;
    double   m_min = 0.0;
    double   m_max = 0.0;
    QVariant m_value;
*/

// ----------------------------------------------------------------------------------------------------
class ParametersTableModel : public QAbstractTableModel{

  Q_OBJECT
  QML_ELEMENT
  Q_PROPERTY(QString id READ id CONSTANT)

public:
  enum RoleName{ NAME = 0, TYPE = 1, UNIT = 2, MIN = 3, MAX = 4 };

  ParametersTableModel(const QString& id, const QList<Parameter>& parms = QList<Parameter>(), QObject* parent = nullptr)
    : QAbstractTableModel(parent), m_id(id), m_parms(parms){}

  void setParameters(const QList<Parameter>& parms) { m_parms = parms; }

  // Q_INVOKABLES
protected:
  Q_INVOKABLE int rowCount(const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent);
    return m_parms.size();
  }
  Q_INVOKABLE int columnCount(const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent);
    return roleNames().size();
  }
  Q_INVOKABLE QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override{
    int row = index.row();
    switch(role){
      case NAME: return m_parms.at(row).name; break;
      case TYPE: return m_parms.at(row).type; break;
      case UNIT: return m_parms.at(row).unit; break;
      case MIN:  return m_parms.at(row).min == 0.0 ? "-" : QString::number(m_parms.at(row).min);  break;
      case MAX:  return m_parms.at(row).max == 0.0 ? "-" : QString::number(m_parms.at(row).max);  break;
    }
    return QVariant();
  }
  Q_INVOKABLE QModelIndex index(int row, int column, const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent)
    return createIndex(row,column);
  }
  Q_INVOKABLE QHash<int, QByteArray> roleNames() const override{
    return m_roles;
  }
  Q_INVOKABLE QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override {
    Q_UNUSED(orientation)
    Q_UNUSED(role)
    switch(section){
      case NAME: return "Name";
      case TYPE: return "Type";
      case MIN:  return "Min";
      case MAX:  return "Max";
      case UNIT: return "Unit";
      default:   return QVariant();
    }
  }
  Q_INVOKABLE QString id() const { return m_id; }

private:
  QString m_id;
  QList<Parameter> m_parms;
  QHash<int, QByteArray> m_roles = {
    { NAME, "Name" },
    { TYPE, "Type" },
    { MIN,  "Min"  },
    { MAX,  "Max"  },
    { UNIT, "Unit" },
  };
};

// ----------------------------------------------------------------------------------------------------
class Socket : public QUdpSocket
{

  Q_OBJECT
  Q_PROPERTY(int localPort MEMBER m_localPort NOTIFY localPortChanged)
  Q_PROPERTY(ParametersTableModel* parmsModel READ parmsModel CONSTANT)
  QML_ELEMENT

public:
  explicit Socket(const QString& name, QAbstractSocket::OpenMode openMode = QAbstractSocket::ReadWrite, QObject* parent = nullptr)
    : QUdpSocket(parent), m_name(name), m_localPort(0)
  {
    connect(this, &Socket::stateChanged, this, &Socket::stateChangeToMessage);
    connect(this, &Socket::errorOccurred, this, &Socket::errorOccurrenceToMessage);

    connect(this, &Socket::stateChangedMessage, Logger::instance(), &Logger::push);
    connect(this, &Socket::errorOccuredMessage, Logger::instance(), &Logger::push);

    m_parmsTableModel = new ParametersTableModel(m_name);

    setOpenMode(openMode);
  }

  ~Socket(){ delete m_parmsTableModel; }

  QString openModeToString(QIODevice::OpenMode openMode){
    switch(openMode){
      case QIODevice::NotOpen:   { return "Not Open";  }
      case QIODevice::ReadOnly:  { return "ReadOnly";  }
      case QIODevice::WriteOnly: { return "WriteOnly"; }
      case QIODevice::ReadWrite: { return "ReadWrite"; }
    }
    return "ReadWrite";
  }

  ParametersTableModel* parmsModel() const { return m_parmsTableModel; }

  // Q_INVOKABLES
  Q_INVOKABLE bool callBindMethod(int port){
    return bind(port);
  }
  Q_INVOKABLE bool callOpenMethod(){
    if(open(openMode())){
      setSocketState(QAbstractSocket::ListeningState);
      emit stateChanged(QAbstractSocket::ListeningState);
      return true;
    }
    return false;
  }
  Q_INVOKABLE QString stateToString(){
    switch (state()) {
      case QAbstractSocket::UnconnectedState: { return QString("UnconnectedState"); }
      case QAbstractSocket::HostLookupState:  { return QString("HostLookupState");  }
      case QAbstractSocket::ConnectingState:  { return QString("ConnectingState");  }
      case QAbstractSocket::ConnectedState:   { return QString("ConnectedState");   }
      case QAbstractSocket::BoundState:       { return QString("BoundState");       }
      case QAbstractSocket::ClosingState:     { return QString("ClosingStat");      }
      case QAbstractSocket::ListeningState:   { return QString("ListeningState");   }
    }
  }
  Q_INVOKABLE QHostAddress stringToHostAddress(const QString& str) const{ return QHostAddress(str); }

  ParametersTableModel* m_parmsTableModel;

private:
  QString m_name;
  int m_localPort;

signals:
 void localPortChanged(int port);
 void parametersChanged();
 void stateChangedMessage(const QString& message);
 void errorOccuredMessage(const QString& message);

private slots:
  void stateChangeToMessage(QAbstractSocket::SocketState socketState);
  void errorOccurrenceToMessage(QAbstractSocket::SocketError socketError);
};

inline void Socket::stateChangeToMessage(QAbstractSocket::SocketState socketState)
{
  QString message;
  message.append(QDateTime::currentDateTime().toString("[yyyy-MM-dd hh:mm:ss] "));
  message.append(m_name + ": ");
  switch(socketState){
    /*0*/case QAbstractSocket::UnconnectedState: { message.append("socket is unconnected"); break;}
    /*1*/case QAbstractSocket::HostLookupState:  { message.append("socket is looking up for a host"); break;}
    /*2*/case QAbstractSocket::ConnectingState:  { message.append("socket has started establishing a connection"); break;}
    /*3*/case QAbstractSocket::ConnectedState:   { message.append("socket has established connection"); break;}
    /*4*/case QAbstractSocket::BoundState:       { message.append("socket is bound to port " + QString::number(m_localPort)); break;}
    /*5*/case QAbstractSocket::ClosingState:     { message.append("The socket is about to close"); break;}
    /*6*/case QAbstractSocket::ListeningState:   { message.append("socket is opened | Mode: " + openModeToString(openMode())); break;}
  }
  qDebug() << state();

  emit stateChangedMessage(message);
}

inline void Socket::errorOccurrenceToMessage(QAbstractSocket::SocketError socketError)
{
  QString message;
  switch(socketError){
    case QAbstractSocket::ConnectionRefusedError:{ break; }
    case QAbstractSocket::RemoteHostClosedError:{ break; }
    case QAbstractSocket::HostNotFoundError:{ break; }
    case QAbstractSocket::SocketAccessError:{ break; }
    case QAbstractSocket::SocketResourceError:{ break; }
    case QAbstractSocket::SocketTimeoutError:{ break; }
    case QAbstractSocket::DatagramTooLargeError:{ break; }
    case QAbstractSocket::NetworkError:{ break; }
    case QAbstractSocket::AddressInUseError:{ break; }
    case QAbstractSocket::SocketAddressNotAvailableError:{ break; }
    case QAbstractSocket::UnsupportedSocketOperationError:{ break; }
    case QAbstractSocket::ProxyAuthenticationRequiredError:{ break; }
    case QAbstractSocket::SslHandshakeFailedError:{ break; }
    case QAbstractSocket::UnfinishedSocketOperationError:{ break; }
    case QAbstractSocket::ProxyConnectionRefusedError:{ break; }
    case QAbstractSocket::ProxyConnectionClosedError:{ break; }
    case QAbstractSocket::ProxyConnectionTimeoutError:{ break; }
    case QAbstractSocket::ProxyNotFoundError:{ break; }
    case QAbstractSocket::ProxyProtocolError:{ break; }
    case QAbstractSocket::OperationError:{ break; }
    case QAbstractSocket::SslInternalError:{ break; }
    case QAbstractSocket::SslInvalidUserDataError:{ break; }
    case QAbstractSocket::TemporaryError:{ break; }
    case QAbstractSocket::UnknownSocketError:{ break; }
  }
  emit errorOccuredMessage(message);
}

Q_DECLARE_METATYPE(ParametersTableModel)
Q_DECLARE_METATYPE(QHostAddress)

#endif // SOCKET_H
