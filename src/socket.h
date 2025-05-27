#ifndef SOCKET_H
#define SOCKET_H

#include <QUdpSocket>
#include <QHostAddress>
#include <QDateTime>
#include <QAbstractTableModel>
#include <QtQml/qqmlregistration.h>

#include "logger.h"

#define LOCAL_ADDRESS "192.168.1.1"

struct ParameterConstData{
  QString  name;
  QString  type;
  QString  unit;
  double   min = 0.0;
  double   max = 0.0;
};

struct Parameter{
  ParameterConstData constData;
  QVariant value = 0;
  bool isSelected = false;
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
  Q_PROPERTY(QString id READ id CONSTANT)

public:
  enum DisplayRoleName{ NAME = 0, TYPE = 1, UNIT = 2, MIN = 3, MAX = 4, LAST = 5, VALUE = 6 };
  // enum UserRoleName{ SELECTED = 5, VALUE = 6 };

  typedef QHash<int, QVariant> ParameterData;
  typedef QList<ParameterData> Parameters;

  ParametersTableModel(QObject* parent = nullptr) : QAbstractTableModel(parent) {}

  void setID(const QString& id){ m_id = id; }
  Q_INVOKABLE QString id() const { return m_id; }

  void appendParameter(const QString& name, const QString& type, const QString& unit, double min = 0.0, double max = 0.0){
    ParameterData parmData;
    parmData[NAME] = name;
    parmData[TYPE] = type;
    parmData[UNIT] = unit;
    parmData[MIN] = min;
    parmData[MAX] = max;
    parmData[VALUE] = 0;

    int row = m_parms.count();
    beginInsertRows(QModelIndex(), row, row);
    m_parms.append(parmData);
    endInsertRows();
  }

  int rowCount(const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent);
    return m_parms.size();
  }
  int columnCount(const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent);
    return LAST;
  }
  QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override{
    if (!index.isValid() || index.row() > m_parms.count())
      return QVariant();

    switch(role) {
      case Qt::DisplayRole:
          return m_parms[index.row()][index.column()];
//      case Qt::UserRole:
//          return m_parms[index.row()][index.column()];
      default:
        break;
    }

    return QVariant();
  }

  QModelIndex index(int row, int column, const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent)
    return createIndex(row,column);
  }

  QHash<int, QByteArray> roleNames() const override{
    return { {Qt::DisplayRole, "display"} };
    return { {Qt::UserRole, "user"} };
  }

//  Q_INVOKABLE QHash<int, QByteArray> roleNames() const override{
//    QHash<int, QByteArray> roles = {
//      { NAME, "Name" },
//      { TYPE, "Type" },
//      { MIN,  "Min"  },
//      { MAX,  "Max"  },
//      { UNIT, "Unit" },
//    };
//    return roles;
//  }

  Q_INVOKABLE QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override {
    Q_UNUSED(orientation)
    Q_UNUSED(role)
    switch(section){
      case 0:  return "Name";
      case 1:  return "Type";
      case 2:  return "Min";
      case 3:  return "Max";
      case 4:  return "Unit";
      default: return QVariant();
    }
    return QVariant();
  }

private:
  QString m_id;
  Parameters m_parms; // QList<QHash<RoleName, QVariant>>
};

// ----------------------------------------------------------------------------------------------------

class Socket : public QUdpSocket
{

  Q_OBJECT
  Q_PROPERTY(ParametersTableModel* parmsModel READ parmsModel CONSTANT)
//  Q_PROPERTY(QString localAddress MEMBER m_localAddress NOTIFY localAddressChanged)
//  Q_PROPERTY(int localPort READ localPort WRITE setLocalPort NOTIFY localPortChanged)
//  Q_PROPERTY(QString peerAddress READ peerAddress WRITE setPeerAddress NOTIFY peerAddressChanged)
//  Q_PROPERTY(int peerPort READ peerPort WRITE setPeerPort NOTIFY peerPortChanged)

public:
  explicit Socket(const QString& hostName, QObject* parent = nullptr);

  ~Socket(){ delete m_parmsModel; }

  QString hostName(){ return m_hostName; }
  void setHostName(const QString& hostName){ m_hostName = hostName; }

  QString protocolName(){ return m_protocolName; }
  void setProtocolName(const QString& protocolName){ m_protocolName = protocolName; }

  ParametersTableModel* parmsModel() { return m_parmsModel; }
  void setParmsModel(ParametersTableModel* parmModel) { m_parmsModel = parmModel; }

  int id(){ return m_id; }
  void setID(int id){ m_id = id; }

  QString openModeToString(QIODevice::OpenMode openMode);

  // Q_INVOKABLES
  Q_INVOKABLE QString stateToString();

private:
  QString m_hostName;
  QString m_protocolName;
  ParametersTableModel* m_parmsModel;
  int m_id;

signals:
  void localAddressChanged();
  void localPortChanged();
  void peerAddressChanged();
  void peerPortChanged();

  void sendSocketInfo(
     int id,
     const QString& hostName,
     const QString& localAddress,
     int localPort,
     const QString& peerAddress,
     int peerPort,
     const QString& protocol,
     bool isOpen,
     QIODeviceBase::OpenMode openModeFlag
  );

  void stateChangedMessage(const QString& message);
  void errorOccuredMessage(const QString& message);

public slots:
  void slotRequestSocketInfo();

  void slotLocalAddressChanged(const QString& localAddress){ setLocalAddress(QHostAddress(localAddress)); qDebug() << this->localAddress(); }
  void slotLocalPortChanged(int localPort){ setLocalPort(localPort); qDebug() << this->localPort(); }
  void slotPeerAddressChanged(const QString& peerAddress){ setPeerAddress(QHostAddress(peerAddress)); qDebug() << this->peerAddress(); }
  void slotPeerPortChanged(int peerPort){ setPeerPort(peerPort); qDebug() << this->peerPort(); }

private slots:
  void stateChangeToMessage(QAbstractSocket::SocketState socketState);
  void errorOccurrenceToMessage(QAbstractSocket::SocketError socketError);
  void slotBindAndOpenPort();
};

#endif // SOCKET_H
