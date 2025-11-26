(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TENGO/ActualizarDatosCuponATM/xsd/actualizarTrxCuponCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarTrxCuponCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConCupon/xq/actualizarInfoCuponDBIn/";

declare function xf:actualizarInfoCuponDBIn($reftengo as xs:string,
    $cuponID as xs:string,
    $ATMdate as xs:string,
    $retrievalref as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_CUPON>{ $cuponID }</ns0:PV_NUMERO_CUPON>
            <ns0:PV_REFERENCIA_TENGO>{ $reftengo }</ns0:PV_REFERENCIA_TENGO>
            <ns0:PV_ATM_DATE>{ $ATMdate }</ns0:PV_ATM_DATE>
            <ns0:PV_RETRIEVAL_REF>{ $retrievalref }</ns0:PV_RETRIEVAL_REF>
        </ns0:InputParameters>
};

declare variable $reftengo as xs:string external;
declare variable $cuponID as xs:string external;
declare variable $ATMdate as xs:string external;
declare variable $retrievalref as xs:string external;

xf:actualizarInfoCuponDBIn($reftengo,
    $cuponID,
    $ATMdate,
    $retrievalref)
