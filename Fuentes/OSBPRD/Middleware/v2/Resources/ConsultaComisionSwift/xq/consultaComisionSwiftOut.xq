(:: pragma bea:global-element-parameter parameter="$transferenciaInternacional_ValidateResponse" element="ns1:TransferenciaInternacional_ValidateResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisionSwiftResponse" location="../xsd/consultaComisionSwiftTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaComisionSWIFT/consultaComisionSwiftOut/";

declare function xf:consultaComisionSwiftOut($transferenciaInternacional_ValidateResponse as element(ns1:TransferenciaInternacional_ValidateResponse))
    as element(ns0:consultaComisionSwiftResponse) {
        <ns0:consultaComisionSwiftResponse>
            <CHARGE_CURRENCY>{ substring(data($transferenciaInternacional_ValidateResponse/FUNDSTRANSFERType/gCOMMISSIONTYPE/mCOMMISSIONTYPE[1]/COMMISSIONAMT), 1, 3) }</CHARGE_CURRENCY>
            <CHARGE_AMOUNT>{ substring( data($transferenciaInternacional_ValidateResponse/FUNDSTRANSFERType/gCOMMISSIONTYPE/mCOMMISSIONTYPE[1]/COMMISSIONAMT), 4) }</CHARGE_AMOUNT>
        </ns0:consultaComisionSwiftResponse>
};

declare variable $transferenciaInternacional_ValidateResponse as element(ns1:TransferenciaInternacional_ValidateResponse) external;

xf:consultaComisionSwiftOut($transferenciaInternacional_ValidateResponse)