#include "socket.h"

Socket::Socket(const QString& hostName, QObject *parent) : QUdpSocket(parent), m_hostName(hostName)
{
  m_parmsModel = new ParametersTableModel();

  setLocalAddress(QHostAddress(LOCAL_ADDRESS));

  connect(this, &Socket::stateChanged, this, &Socket::stateChangeToMessage);
  connect(this, &Socket::errorOccurred, this, &Socket::errorOccurrenceToMessage);

  connect(this, &Socket::stateChangedMessage, Logger::instance(), &Logger::push);
  connect(this, &Socket::errorOccuredMessage, Logger::instance(), &Logger::push);
}

QString Socket::openModeToString(OpenMode openMode)
{
  switch(openMode){
    case QIODevice::NotOpen:  { return "Not Open";  }
    case QIODevice::ReadOnly: { return "ReadOnly";  }
    case QIODevice::WriteOnly:{ return "WriteOnly"; }
    case QIODevice::ReadWrite:{ return "ReadWrite"; }
  }
  return "ReadWrite";
}

QString Socket::stateToString()
{
  switch (state()) {
    case QAbstractSocket::UnconnectedState:{ return QString("UnconnectedState"); }
    case QAbstractSocket::HostLookupState: { return QString("HostLookupState");  }
    case QAbstractSocket::ConnectingState: { return QString("ConnectingState");  }
    case QAbstractSocket::ConnectedState:  { return QString("ConnectedState");   }
    case QAbstractSocket::BoundState:      { return QString("BoundState");       }
    case QAbstractSocket::ClosingState:    { return QString("ClosingState");      }
    case QAbstractSocket::ListeningState:  { return QString("ListeningState");   }
    }
}

void Socket::stateChangeToMessage(QAbstractSocket::SocketState socketState)
{
  QString message;
  message.append(QDateTime::currentDateTime().toString("[yyyy-MM-dd hh:mm:ss] "));
  message.append(m_hostName + ": ");
  switch(socketState){
    /*0*/case QAbstractSocket::UnconnectedState: { message.append("socket is unconnected"); break;}
    /*1*/case QAbstractSocket::HostLookupState:  { message.append("socket is looking up for a host"); break;}
    /*2*/case QAbstractSocket::ConnectingState:  { message.append("socket has started establishing a connection"); break;}
    /*3*/case QAbstractSocket::ConnectedState:   { message.append("socket has established connection"); break;}
    /*4*/case QAbstractSocket::BoundState:       { message.append("socket is bound to port " + QString::number(localPort())); break;}
    /*5*/case QAbstractSocket::ClosingState:     { message.append("The socket is about to close"); break;}
    /*6*/case QAbstractSocket::ListeningState:   { message.append("socket is opened | Mode: " + openModeToString(openMode())); break;}
  }
  qDebug() << state();

  emit stateChangedMessage(message);
}
void Socket::errorOccurrenceToMessage(QAbstractSocket::SocketError socketError)
{
  QString message;
  switch(socketError){
    case QAbstractSocket::ConnectionRefusedError:{ break; }
    case QAbstractSocket::RemoteHostClosedError:{ break; }
    case QAbstractSocket::HostNotFoundError:{ break; }
    case QAbstractSocket::SocketAccessError:{ break; }
    case QAbstractSocket::SocketResourceError:{ break; }
    case QAbstractSocket::SocketTimeoutError:{ break; }
    case QAbstractSocket::DatagramTooLargeError:{ break; }
    case QAbstractSocket::NetworkError:{ break; }
    case QAbstractSocket::AddressInUseError:{ break; }
    case QAbstractSocket::SocketAddressNotAvailableError:{ break; }
    case QAbstractSocket::UnsupportedSocketOperationError:{ break; }
    case QAbstractSocket::ProxyAuthenticationRequiredError:{ break; }
    case QAbstractSocket::SslHandshakeFailedError:{ break; }
    case QAbstractSocket::UnfinishedSocketOperationError:{ break; }
    case QAbstractSocket::ProxyConnectionRefusedError:{ break; }
    case QAbstractSocket::ProxyConnectionClosedError:{ break; }
    case QAbstractSocket::ProxyConnectionTimeoutError:{ break; }
    case QAbstractSocket::ProxyNotFoundError:{ break; }
    case QAbstractSocket::ProxyProtocolError:{ break; }
    case QAbstractSocket::OperationError:{ break; }
    case QAbstractSocket::SslInternalError:{ break; }
    case QAbstractSocket::SslInvalidUserDataError:{ break; }
    case QAbstractSocket::TemporaryError:{ break; }
    case QAbstractSocket::UnknownSocketError:{ break; }
  }
  emit errorOccuredMessage(message);
}

void Socket::slotBindAndOpenPort()
{
  if(bind(localPort())){
    if(open(openMode())){
      setSocketState(QAbstractSocket::ListeningState);
      emit stateChanged(QAbstractSocket::ListeningState);
    }
    else{
      // Logger
    }
  }
  else{
    // Logger
  }
}

// SLOTS

void Socket::slotRequestSocketInfo()
{
  emit sendSocketInfo(m_id, m_hostName, localAddress().toString(), localPort(), peerAddress().toString(), peerPort(), protocolName(), isOpen(), openMode());
}

