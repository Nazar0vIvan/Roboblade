#include "socketmodbustcp.h"

SocketModbusTCP::SocketModbusTCP(const QString& name, QObject* parent) : Socket(name, parent)
{
  m_protocol = "Modbus TCP";
  m_id = 3;

  setLocalAddress(QHostAddress(LOCAL_ADDRESS));
  setLocalPort(VFDA65_LOCAL_PORT);
  setPeerAddress(QHostAddress(VFDA65_PEER_ADDRESS));
  setPeerPort(VFDA65_PEER_PORT);

  setOpenMode(QIODeviceBase::ReadWrite);
}
