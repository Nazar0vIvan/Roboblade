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
  QVariant value = NULL;
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
  enum RoleName{ NAME = 0, TYPE = 1, UNIT = 2, MIN = 3, MAX = 4, VALUE = 5, SELECTED = 6 };

  typedef QHash<RoleName, QVariant> ParameterData;
  typedef QList<ParameterData> Parameters;

  ParametersTableModel(QObject* parent = nullptr) : QAbstractTableModel(parent) {}

protected:
  void appendParameter(const QString& name, const QString& type, const QString& unit, double min, double max){
    ParameterData parmData;
    parmData[NAME] = name;
    parmData[TYPE] = type;
    parmData[UNIT] = unit;
    parmData[MIN] = min;
    parmData[MAX] = max;
    parmData[VALUE] = NULL;
    parmData[SELECTED] = false;

    int row = m_parms.count();
    beginInsertRows(QModelIndex(), row, row);
    m_parms.append(parmData);
    endInsertRows();
  }

  // Q_INVOKABLES
  Q_INVOKABLE int rowCount(const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent);
    return m_parms.size();
  }
  Q_INVOKABLE int columnCount(const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent);
    return roleNames().size();
  }
  Q_INVOKABLE QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override{
    if (!index.isValid() || index.row() > m_parms.count() || role != Qt::DisplayRole)
      return QVariant();

    return m_parms[index.row()][RoleName(index.column())];

//    if(role == Qt::DisplayRole){
//      switch(index.column()){
//        case /*NAME*/ 0: return m_parms.at(index.row()).name; break;
//        case /*TYPE*/ 1: return m_parms.at(index.row()).type; break;
//        case /*MIN*/  2: return m_parms.at(index.row()).min ? QString::number(m_parms.at(index.row()).min) : "-";  break;
//        case /*MAX*/  3: return m_parms.at(index.row()).max ? QString::number(m_parms.at(index.row()).max) : "-";  break;
//        case /*UNIT*/ 4: return m_parms.at(index.row()).unit; break;
//          // case SELECTED: return m_parms.at(row).isSelected; break;
//      }
//    }

  }

  Q_INVOKABLE QModelIndex index(int row, int column, const QModelIndex& parent = QModelIndex()) const override {
    Q_UNUSED(parent)
    return createIndex(row,column);
  }

  Q_INVOKABLE QHash<int, QByteArray> roleNames() const override{
    QHash<int, QByteArray> roles = {
      { NAME, "Name" },
      { TYPE, "Type" },
      { MIN,  "Min"  },
      { MAX,  "Max"  },
      { UNIT, "Unit" },
      { SELECTED, "Selected" },
    };
    return roles;
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
  Parameters m_parms;
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

  ParametersTableModel* parmsModel() const { return m_parmsModel; }
  void setParmsModel(ParametersTableModel* parmModel) { m_parmsModel = parmModel; }

  QString hostName(){ return m_hostName; }

  QString openModeToString(QIODevice::OpenMode openMode);

  // Q_INVOKABLES
  Q_INVOKABLE QString stateToString();

protected:
  QString m_protocol;
  int m_id;

private:
  QString m_hostName;
  ParametersTableModel* m_parmsModel;

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
