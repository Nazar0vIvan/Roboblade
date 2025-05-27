#include "socketrsi.h"

SocketRSI::SocketRSI(const QString &name, QObject *parent) : Socket(name, parent)
{
  setID(1);
  setProtocolName("RSI");

  setPeerAddress(QHostAddress(RSI_PEER_ADDRESS));

  parmsModel()->setID("rsi");
  for(int i=0; i < 5; ++i){
    parmsModel()->appendParameter(QString::number(i), "int", "ct");
  }
}

void SocketRSI::slotParseConfigFile(const QUrl& url)
{
  QString filePath = url.toLocalFile();
  QFile configFile(filePath);

  if(!configFile.open(QIODevice::ReadOnly)){
    emit configFileOpenError(configFile.errorString());
    return;
  }

  QDomDocument dom;
  QString errorMsg; int errorLine; int errorColumn;
  if(!dom.setContent(&configFile, true, &errorMsg, &errorLine, &errorColumn)){
    emit configFileFormatError(errorMsg, errorLine, errorColumn);
    return;
  }

  QDomElement configElements = dom.documentElement().firstChildElement("CONFIG");
  QString rsiLocalAddress = configElements.namedItem("IP_NUMBER").toElement().text();
  int rsiLocalPort = configElements.namedItem("PORT").toElement().text().toInt();

  QString rsiOpenModeText = configElements.namedItem("ONLYSEND").toElement().text();
  QIODeviceBase::OpenModeFlag rsiOpenMode = rsiOpenModeText == "TRUE" ? QIODeviceBase::ReadOnly : "FALSE" ? QIODeviceBase::ReadWrite : QIODeviceBase::NotOpen;

  QString pattern("[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}");
  QRegularExpression re(pattern);
  QRegularExpressionMatch match = re.match(rsiLocalAddress);

  if(!rsiLocalPort || !match.hasMatch()){
    emit portOrAddressFormatError(rsiLocalPort, rsiLocalAddress);
    return;
  }

  if(!rsiOpenMode){
    emit onlySendFormatError(rsiOpenModeText);
    return;
  }

  setLocalAddress(QHostAddress(rsiLocalAddress));
  setLocalPort(rsiLocalPort);
  setOpenMode(rsiOpenMode);

  emit sendSocketInfo(id(), hostName(), localAddress().toString(), localPort(), peerAddress().toString(), 0, protocolName(), isOpen(), openMode());
}
