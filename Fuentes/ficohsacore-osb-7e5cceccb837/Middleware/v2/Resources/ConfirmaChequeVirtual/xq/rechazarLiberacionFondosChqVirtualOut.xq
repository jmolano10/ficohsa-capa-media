(:: pragma bea:global-element-parameter parameter="$confirmaChequeVirtualResponse" element="ns0:ConfirmaChequeVirtualResponse" location="../../../../Business_Resources/compensacion/RechazaChequeVirtual/RechazaChequeVirtualTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:confirmaChequeVirtualResponse" location="../xsd/confirmaChequeVirtualTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/confirmaChequeVirtualTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmaChequeVirtual/xq/rechazarLiberacionFondosChqVirtualOut/";

declare function xf:rechazarLiberacionFondosChqVirtualOut($confirmaChequeVirtualResponse as element(ns0:ConfirmaChequeVirtualResponse))
    as element(ns1:confirmaChequeVirtualResponse) {
        <ns1:confirmaChequeVirtualResponse>
            {
                for $ESTADODEPOSITO in $confirmaChequeVirtualResponse/FICOHCHEQUEVIRTUALType/ESTADODEPOSITO
                return
                    <DEPOSIT_STATUS>{ data($ESTADODEPOSITO) }</DEPOSIT_STATUS>
            }
        </ns1:confirmaChequeVirtualResponse>
};

declare variable $confirmaChequeVirtualResponse as element(ns0:ConfirmaChequeVirtualResponse) external;

xf:rechazarLiberacionFondosChqVirtualOut($confirmaChequeVirtualResponse)
