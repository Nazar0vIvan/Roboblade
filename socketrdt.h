#ifndef SOCKETRDT_H
#define SOCKETRDT_H

#include <QUdpSocket>
#include <QNetworkDatagram>
#include <QDebug>
#include <QVector>
#include <QByteArray>
#include <QtEndian>
#include <QTimer>

#include "socket.h"

/*
  LOCAL PORT:    59152
  LOCAL ADDRESS: 192.168.1.1
  PEER PORT:     49152
  PEER ADDRESS:  192.168.1.3
*/

#define PEER_PORT 49152
#define RDT_REQUEST_LENGTH 8
#define RDT_RESPONSE_LENGTH 36

struct RDTRequest
{
  uint16_t header;
  uint16_t command;
  uint32_t sampleCount;
};

struct RDTResponse
{
  uint32_t rdt_sequence;
  uint32_t ft_sequence;
  uint32_t status;
  int32_t Fx;
  int32_t Fy;
  int32_t Fz;
  int32_t Tx;
  int32_t Ty;
  int32_t Tz;
};

class SocketRDT : public Socket
{

  Q_OBJECT
  Q_PROPERTY(QHostAddress peerAddress MEMBER m_peerAddress NOTIFY peerAddressChanged)

public:
  SocketRDT(const QString& name, QAbstractSocket::OpenMode openMode, QObject* parent = nullptr);

  QNetworkDatagram RDTRequest2QNetworkDatagram(const RDTRequest& request);
  RDTResponse QNetworkDatagram2RDTResponse(const QNetworkDatagram& networkDatagram);

  Q_INVOKABLE QString peerHostAddressString() const { return m_peerAddress.toString(); }

private:
  int m_peerPort;
  QHostAddress m_peerAddress;

signals:
  void responceChanged(const RDTResponse& responce);
  void peerAddressChanged(const QHostAddress& address);

public slots:
  void slotStartStreaming();
  void slotStopStreaming();

private slots:
  void slotReadData();
};

#endif // SOCKETRDT_H
