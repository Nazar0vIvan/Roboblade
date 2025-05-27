#ifndef SOCKETMODBUSTCP_H
#define SOCKETMODBUSTCP_H

#include "socket.h"

#define VFDA65_LOCAL_PORT 1470
#define VFDA65_PEER_ADDRESS "192.168.1.4"
#define VFDA65_PEER_PORT 9630

/*
  LOCAL ADDRESS: 192.168.1.1 // must be set
  LOCAL PORT:    1470        // must be set
  PEER ADDRESS:  192.168.1.4 // must be set
  PEER PORT:     9630        // must be set
*/

class SocketModbusTCP : public Socket
{
  Q_OBJECT
public:
  explicit SocketModbusTCP(const QString& name, QObject* parent = nullptr);
};

#endif // SOCKETMODBUSTCP_H
