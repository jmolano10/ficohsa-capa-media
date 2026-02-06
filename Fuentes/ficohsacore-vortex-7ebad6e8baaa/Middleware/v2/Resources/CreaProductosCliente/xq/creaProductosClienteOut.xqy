xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$aperturaCuentasClienteResponse" element="ns0:AperturaCuentasClienteResponse" location="../../../BusinessServices/T24/aperturaCuenta/xsd/XMLSchema_379817454.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaProductosClienteResponse" location="../xsd/creaProductosClienteTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaProductosClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaProductosCliente/xq/creaProductosClienteOut/";

declare function xf:creaProductosClienteOut($aperturaCuentasClienteResponse as element(ns0:AperturaCuentasClienteResponse))
    as element(ns1:creaProductosClienteResponse) {
        <ns1:creaProductosClienteResponse>
            <ACCOUNT_DETAIL>
                {
                    for $FIELDS51 in $aperturaCuentasClienteResponse/FICOBULKAPPRCLNTType/FIELDS51
                    return
                        let $__nullable := ( data($FIELDS51) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <ACCOUNT_NUMBER>{ $__nullable }</ACCOUNT_NUMBER>
                            else
                                ()
                }
            </ACCOUNT_DETAIL>
        </ns1:creaProductosClienteResponse>
};

declare variable $aperturaCuentasClienteResponse as element(ns0:AperturaCuentasClienteResponse) external;

xf:creaProductosClienteOut($aperturaCuentasClienteResponse)