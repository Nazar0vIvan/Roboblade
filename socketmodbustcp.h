#ifndef SOCKETMODBUSTCP_H
#define SOCKETMODBUSTCP_H

#include "socket.h"

class SocketModbusTCP : public Socket
{
  Q_OBJECT
public:
  explicit SocketModbusTCP(QObject *parent = nullptr);
};

#endif // SOCKETMODBUSTCP_H
