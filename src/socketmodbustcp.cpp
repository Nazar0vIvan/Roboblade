#include "socketmodbustcp.h"

SocketModbusTCP::SocketModbusTCP(const QString& name, QObject* parent) : Socket(name, parent)
{
  setID(4);
  setProtocolName("Modbus TCP");

  setLocalAddress(QHostAddress(LOCAL_ADDRESS));
  setLocalPort(VFDA65_LOCAL_PORT);
  setPeerAddress(QHostAddress(VFDA65_PEER_ADDRESS));
  setPeerPort(VFDA65_PEER_PORT);

  setOpenMode(QIODeviceBase::ReadWrite);

  parmsModel()->setID("vfdA65");
  for(int i= 0; i < 5; ++i){
    parmsModel()->appendParameter(QString::number(i), "int", "ct");
  }
}
