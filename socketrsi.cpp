#include "socketrsi.h"

SocketRSI::SocketRSI(const QString &name, OpenMode openMode, QObject *parent)  : Socket(name, openMode, parent)
{
  QList<Parameter> parms;

  for(int i=0; i < 3; ++i){
    parms.append( {QString::number(i),"int","ct"} );
  }

  m_parmsTableModel->setParameters(parms);
}

void SocketRSI::parseConfigFile(const QUrl& url)
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
  QString sIPAddress = configElements.namedItem("IP_NUMBER").toElement().text();
  QString sPort = configElements.namedItem("PORT").toElement().text();
  QString sOnlySend = configElements.namedItem("ONLYSEND").toElement().text();

  QString pattern("[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}");
  QRegularExpression re(pattern);
  QRegularExpressionMatch match = re.match(sIPAddress);

  if(!sPort.toInt() || !match.hasMatch()){
    emit portOrIPAddressFormatError(sPort, sIPAddress);
    return;
  }

  if (sOnlySend == "FALSE"){
    setOpenMode(QAbstractSocket::ReadWrite);
  }
  else if (sOnlySend == "TRUE"){
    setOpenMode(QAbstractSocket::ReadOnly);
  }
  else{
    emit onlySendFormatError(sOnlySend);
    return;
  }

  emit socketDataChanged(sPort, sIPAddress, sOnlySend, filePath);
}
