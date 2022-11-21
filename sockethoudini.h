#ifndef SOCKETHOUDINI_H
#define SOCKETHOUDINI_H

#include <QUdpSocket>
#include <QNetworkDatagram>
#include <QDebug>

#include "socket.h"

/*
  LOCAL PORT:    1111
  LOCAL ADDRESS: 192.168.1.1
  PEER PORT:     2222
  PEER ADDRESS:  LOCALHOST
*/

class SocketHoudini : public Socket
{
  Q_OBJECT
  Q_PROPERTY(int peerPort  MEMBER m_peerPort NOTIFY peerPortChanged)

public:
  SocketHoudini(const QString& name, QAbstractSocket::OpenMode openMode, QObject* parent = nullptr) : Socket(name, openMode, parent){}

private:
  int m_peerPort;

signals:
  void peerPortChanged(int port);
};

#endif // SOCKETHOUDINI_H
