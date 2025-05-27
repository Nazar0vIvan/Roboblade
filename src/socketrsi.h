#ifndef SOCKETRSI_H
#define SOCKETRSI_H

#include <QUdpSocket>
#include <QNetworkDatagram>
#include <QVector>
#include <QByteArray>
#include <QTimer>
#include <QFile>
#include <QDebug>
#include <QXmlStreamReader>
#include <QDomDocument>
#include <QNetworkDatagram>
#include <QDebug>
#include <QRegularExpression>
#include <QUrl>


#include "socket.h"

#define RSI_PEER_ADDRESS "192.168.1.2"

/*
  LOCAL ADDRESS: 192.168.1.1            // from file
  LOCAL PORT:    49152                  // from file
  PEER ADDRESS:  192.168.1.2            // can't be set
  PEER PORT:     FROM RECEVIED DATAGRAM // from file
*/

class SocketRSI : public Socket
{
  Q_OBJECT

public:
  explicit SocketRSI(const QString& name, QObject* parent = nullptr);

private:
  std::map<QString,QVector<QVariant>> m_data; // xml data representation, parmName -> {value0, value1, ... }

  QByteArray moveCommand{ "<Sen Type=\"ImFree\"><AKorr A1=\"0.01\" A2=\"0.0\" A3=\"0.0\" A4=\"0.0\" A5=\"0.0\" A6=\"0.0\" /><IPOC>00000000</IPOC></Sen>" };
  QByteArray defaultCommand{ "<Sen Type=\"ImFree\"><AKorr A1=\"0.0\" A2=\"0.0\" A3=\"0.0\" A4=\"0.0\" A5=\"0.0\" A6=\"0.0\" /><IPOC>00000000</IPOC></Sen>" };

signals:
  void configFileOpenError(const QString& error);
  void configFileFormatError(const QString& errorMsg, int errorLine, int errorColumn);
  void portOrAddressFormatError(int port, const QString& ipAddress);
  void onlySendFormatError(const QString& error);

  void configFileParsingFinished(const QString& port, const QString& ipAddress, const QString& openMode, const QString& filePath);

public slots:
  void slotParseConfigFile(const QUrl& url);
};

#endif // SOCKETRSI_H
