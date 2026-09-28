(:: pragma bea:global-element-return element="ns0:depositoVirtualChequesResponse" location="../../DepositoVirtualCheques/xsd/depositoVirtualChequesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoVirtualChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoChequeVirtualPropio/xq/depositoChequeVirtualPropioOut/";

declare function xf:depositoChequeVirtualPropioOut($chequeType as xs:string,
    $idRecordRef as xs:string)
    as element(ns0:depositoVirtualChequesResponse) {
        <ns0:depositoVirtualChequesResponse>
            <CHEQUE_TYPE>{ data($chequeType) }</CHEQUE_TYPE>
            <ID_RECORD_REF>{ data($idRecordRef) }</ID_RECORD_REF>
        </ns0:depositoVirtualChequesResponse>
};

declare variable $chequeType as xs:string external;
declare variable $idRecordRef as xs:string external;

xf:depositoChequeVirtualPropioOut($chequeType,
    $idRecordRef)