#ifndef SOCKETRSI_H
#define SOCKETRSI_H

#include <QUdpSocket>
#include <QNetworkDatagram>
#include <QVector>
#include <QByteArray>
#include <QTimer>
#include <QFile>
#include <QFileDialog>
#include <QDebug>
#include <QXmlStreamReader>
#include <QDomDocument>
#include <QNetworkDatagram>
#include <QDebug>
#include <QRegularExpression>

#include "socket.h"

/*
  LOCAL PORT:    49152
  PEER PORT:     FROM RECEVIED DATAGRAM
  LOCAL ADDRESS: 192.168.1.1
  PEER ADDRESS:  192.168.1.2
*/

class SocketRSI : public Socket
{

  Q_OBJECT
  Q_PROPERTY(QHostAddress peerAddress MEMBER m_peerAddress NOTIFY peerAddressChanged)

public:
  explicit SocketRSI(const QString& name, QAbstractSocket::OpenMode openMode = QAbstractSocket::ReadWrite, QObject* parent = nullptr);

private:
  QHostAddress m_localAddress;
  QHostAddress m_peerAddress;
  std::map<QString,QVector<QVariant>> m_data; // xml data representation, parmName -> {value0, value1, ... }

  QByteArray moveCommand{"<Sen Type=\"ImFree\"><AKorr A1=\"0.01\" A2=\"0.0\" A3=\"0.0\" A4=\"0.0\" A5=\"0.0\" A6=\"0.0\" /><IPOC>00000000</IPOC></Sen>"};
  QByteArray defaultCommand{"<Sen Type=\"ImFree\"><AKorr A1=\"0.0\" A2=\"0.0\" A3=\"0.0\" A4=\"0.0\" A5=\"0.0\" A6=\"0.0\" /><IPOC>00000000</IPOC></Sen>"};

signals:
  void configFileOpenError(const QString& error);
  void configFileFormatError(const QString& errorMsg, int errorLine, int errorColumn);
  void portOrIPAddressFormatError(const QString& port, const QString& ipAddress);
  void onlySendFormatError(const QString& error);

  void socketDataChanged(const QString& port, const QString& ipAddress, const QString& openMode, const QString& filePath);
  void peerAddressChanged();

public slots:
  void parseConfigFile(const QUrl& url);
};

#endif // SOCKETRSI_H
