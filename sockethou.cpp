#include "sockethou.h"

SocketHou::SocketHou(const QString& name, QObject *parent) : Socket(name, parent)
{ 
  setID(3);
  setProtocolName("UDP/IP");

  setLocalAddress(QHostAddress::LocalHost);
  setLocalPort(HOU_LOCAL_PORT);
  setPeerAddress(QHostAddress::LocalHost);
  setPeerPort(HOU_PEER_PORT);

  setOpenMode(QIODeviceBase::ReadWrite);

  parmsModel()->setID("hou");
}
