#ifndef SOCKETHOU_H
#define SOCKETHOU_H

#include <QUdpSocket>
#include <QNetworkDatagram>
#include <QDebug>

#include "socket.h"

#define HOU_LOCAL_PORT 1111
#define HOU_PEER_PORT 2222

/*
  LOCAL ADDRESS: LOCALHOST // can't be set
  LOCAL PORT:    1111      // must be set
  PEER ADDRESS:  LOCALHOST // can't be set
  PEER PORT:     2222      // must be set
*/

class SocketHou : public Socket
{
  Q_OBJECT

public:
  SocketHou(const QString& name, QObject* parent = nullptr);
};

#endif // SOCKETHOU_H
