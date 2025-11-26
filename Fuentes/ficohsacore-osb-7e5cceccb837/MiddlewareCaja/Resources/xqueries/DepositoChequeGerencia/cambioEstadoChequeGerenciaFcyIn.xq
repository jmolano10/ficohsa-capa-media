(:: pragma bea:global-element-parameter parameter="$depositoChequeGerencia1" element="ns1:depositoChequeGerencia" location="../../xsds/DepositoChequeGerencia/DepositoChequeGerencia.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CambioestadochqgerenciaFCY" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeGerencia";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/cambioEstadoChequeGerenciaFcyIn/";

declare function xf:cambioEstadoChequeGerenciaFcyIn( $username as xs:string,
    $password as xs:string,
    $depositoChequeGerencia1 as element(ns1:depositoChequeGerencia),
    $nostroAccount as xs:string,
    $currentDate as xs:string)
    as element(ns0:CambioestadochqgerenciaFCY) {
        <ns0:CambioestadochqgerenciaFCY>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <FICOFCYDRAFTDETAILSFICOHNINPUTWSType id = "{ concat($nostroAccount , ".", $depositoChequeGerencia1/CHEQUE_NUMBER) }">
                <ChequeStatus>LOCALLY.PAID</ChequeStatus>
                <StatusUpdateDate>{ $currentDate }</StatusUpdateDate>
            </FICOFCYDRAFTDETAILSFICOHNINPUTWSType>
        </ns0:CambioestadochqgerenciaFCY>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $depositoChequeGerencia1 as element(ns1:depositoChequeGerencia) external;
declare variable $nostroAccount as xs:string external;
declare variable $currentDate as xs:string external;

xf:cambioEstadoChequeGerenciaFcyIn(   $username,
    $password,
    $depositoChequeGerencia1,
    $nostroAccount,
    $currentDate)