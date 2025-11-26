(:: pragma bea:global-element-parameter parameter="$depositoChequeCertificado" element="ns1:depositoChequeCertificado" location="../../xsds/DepositoChequeCertificado/DepositoChequeCertificado.xsd" ::)
(:: pragma bea:global-element-return element="ns0:DepositoChequeCertificadoLCY" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeCertificado";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCertificado/depositoChequeCertificado1In/";

declare function xf:depositoChequeCertificado1In($userName as xs:string,
    $password as xs:string,
    $uuid as xs:string,
    $depositoChequeCertificado as element(ns1:depositoChequeCertificado))
    as element(ns0:DepositoChequeCertificadoLCY) {
        <ns0:DepositoChequeCertificadoLCY>
            <WebRequestCommon>
                <userName>{ $userName }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFICOCERTIFIEDCHEQUEDEPType>
                <DepositAccount>{ data($depositoChequeCertificado/DEPOSIT_ACCOUNT) }</DepositAccount>
                <gNARRATIVE2>
                    {
                        for $DESCRIPTION  in ($depositoChequeCertificado/DESCRIPTION)  
                        return
                            (<Narrative>{ data($DESCRIPTION) }</Narrative>)
                    }
				</gNARRATIVE2>
                {
                    for $DEPOSITOR_ID in $depositoChequeCertificado/DEPOSITOR_ID
                    return
                        <LRBENID>{ data($DEPOSITOR_ID) }</LRBENID>
                }
                {
                    for $DEPOSITOR_NAME in $depositoChequeCertificado/DEPOSITOR_NAME
                    return
                        <LRBENNAME>{ data($DEPOSITOR_NAME) }</LRBENNAME>
                }
                <LRCERTCHQNUM>{ data($depositoChequeCertificado/CHEQUE_NUMBER) }</LRCERTCHQNUM>
                <LRCERTCHQISS>{ data($depositoChequeCertificado/CHEQUE_ACCOUNT) }</LRCERTCHQISS>
                {
                    for $CHANNEL in $depositoChequeCertificado/CHANNEL
                    return
                        <LRCHANNELID>{ data($CHANNEL) }</LRCHANNELID>
                }
            </TELLERFICOCERTIFIEDCHEQUEDEPType>
        </ns0:DepositoChequeCertificadoLCY>
};

declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;
declare variable $depositoChequeCertificado as element(ns1:depositoChequeCertificado) external;

xf:depositoChequeCertificado1In($userName,
    $password,
    $uuid,
    $depositoChequeCertificado)