#ifndef SOCKET_H
#define SOCKET_H

#include <QUdpSocket>
#include <QHostAddress>
#include <QDateTime>
#include <QAbstractTableModel>
#include <QtQml/qqmlregistration.h>

#include "logger.h"

#define LOCAL_ADDRESS "192.168.1.1"

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
  Q_PROPERTY(ParametersTableModel* parmsModel READ parmsModel CONSTANT)
  Q_PROPERTY(QString localAddress MEMBER m_localAddress NOTIFY localAddressChanged)
  Q_PROPERTY(int localPort READ localPort WRITE setLocalPort NOTIFY localPortChanged)
  Q_PROPERTY(QString peerAddress READ peerAddress WRITE setPeerAddress NOTIFY peerAddressChanged)
  Q_PROPERTY(int peerPort READ peerPort WRITE setPeerPort NOTIFY peerPortChanged)

public:
  explicit Socket(const QString& name, QObject* parent = nullptr);

  ~Socket(){ delete m_parmsModel; }

  ParametersTableModel* parmsModel() const { return m_parmsModel; }
  void setParmsModel(ParametersTableModel* parmModel) { m_parmsModel = parmModel; }

  QString openModeToString(QIODevice::OpenMode openMode);

  QString localAddress() const { return m_localAddress; }
  void setLocalAddress(const QString& localAddress){ m_localAddress = localAddress; }

  int localPort() const { return m_localPort; }
  void setLocalPort(int localPort){ m_localPort = localPort; }

  QString peerAddress() const { return m_peerAddress; }
  void setPeerAddress(const QString& peerAddress){ m_peerAddress = peerAddress; }

  int peerPort() const { return m_peerPort; }
  void setPeerPort(int peerPort){ m_peerPort = peerPort; }

  // Q_INVOKABLES
  Q_INVOKABLE QString stateToString();

private:
  QString m_name;
  ParametersTableModel* m_parmsModel;
  QString m_localAddress;
  int m_localPort;
  QString m_peerAddress;
  int m_peerPort;


signals:
 void localAddressChanged();
 void localPortChanged();
 void peerAddressChanged();
 void peerPortChanged();

 void stateChangedMessage(const QString& message);
 void errorOccuredMessage(const QString& message);

private slots:
  void stateChangeToMessage(QAbstractSocket::SocketState socketState);
  void errorOccurrenceToMessage(QAbstractSocket::SocketError socketError);
  void slotBindAndOpenPort();
};

Q_DECLARE_METATYPE(ParametersTableModel)

#endif // SOCKET_H
