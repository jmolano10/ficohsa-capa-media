(:: pragma bea:global-element-parameter parameter="$depositoChequeCertificado1" element="ns1:depositoChequeCertificado" location="../../xsds/DepositoChequeCertificado/DepositoChequeCertificado.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Depositodechequecertificado" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeCertificado";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCertificado/depositoChequeCertificadoIn/";

declare function xf:depositoChequeCertificadoIn(   $username as xs:string,
    $password as xs:string,
    $depositoChequeCertificado1 as element(ns1:depositoChequeCertificado),
    $uuid as xs:string)
    as element(ns0:Depositodechequecertificado) {
        <ns0:Depositodechequecertificado>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFICOCERTIFIEDCHEQUEDEPType>
                <DepositAccount>{ data($depositoChequeCertificado1/DEPOSIT_ACCOUNT) }</DepositAccount>
                <gNARRATIVE2>
                    {
                        for $DESCRIPTION in $depositoChequeCertificado1/DESCRIPTION
                        return
                            <Narrative>{ data($DESCRIPTION) }</Narrative>
                    }
                </gNARRATIVE2>
                <LRCERTCHQNUM>{ data($depositoChequeCertificado1/CHEQUE_NUMBER) }</LRCERTCHQNUM>
                <LRCERTCHQISS>{ data($depositoChequeCertificado1/CHEQUE_ACCOUNT) }</LRCERTCHQISS>
            </TELLERFICOCERTIFIEDCHEQUEDEPType>
        </ns0:Depositodechequecertificado>
};

declare variable $depositoChequeCertificado1 as element(ns1:depositoChequeCertificado) external;
declare variable $uuid as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:depositoChequeCertificadoIn(    $username,
    $password,
    $depositoChequeCertificado1,
    $uuid)