#include "socket.h"

void Socket::stateChangeToMessage(QAbstractSocket::SocketState socketState)
{
  QString message;
  message.append(QDateTime::currentDateTime().toString("[yyyy-MM-dd hh:mm:ss] "));
  message.append(m_name + ": ");
  switch(socketState){
    /*0*/case QAbstractSocket::UnconnectedState: { message.append("socket is unconnected"); break;}
    /*1*/case QAbstractSocket::HostLookupState:  { message.append("socket is looking up for a host"); break;}
    /*2*/case QAbstractSocket::ConnectingState:  { message.append("socket has started establishing a connection"); break;}
    /*3*/case QAbstractSocket::ConnectedState:   { message.append("socket has established connection"); break;}
    /*4*/case QAbstractSocket::BoundState:       { message.append("socket is bound to port " + QString::number(m_localPort)); break;}
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
  if(bind(m_localPort)){
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
