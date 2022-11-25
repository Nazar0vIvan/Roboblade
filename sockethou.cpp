#include "sockethou.h"

SocketHou::SocketHou(const QString &name, QObject *parent) : Socket(name, parent)
{
  setLocalPort(HOU_LOCAL_PORT);
  setPeerPort(HOU_PEER_PORT);
}
