(:: pragma bea:global-element-parameter parameter="$confirmarLiberacionFondosChqVirtResponse" element="ns0:ConfirmarLiberacionFondosChqVirtResponse" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:confirmaChequeVirtualResponse" location="../xsd/confirmaChequeVirtualTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/confirmaChequeVirtualTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmaChequeVirtual/xq/confirmarLiberacionFondosChqVirtOut/";

declare function xf:confirmarLiberacionFondosChqVirtOut($confirmarLiberacionFondosChqVirtResponse as element(ns0:ConfirmarLiberacionFondosChqVirtResponse))
    as element(ns1:confirmaChequeVirtualResponse) {
        <ns1:confirmaChequeVirtualResponse>
            {
                for $ESTADODEPOSITO in $confirmarLiberacionFondosChqVirtResponse/FICOHCHEQUEVIRTUALType/ESTADODEPOSITO
                return
                    <DEPOSIT_STATUS>{ data($ESTADODEPOSITO) }</DEPOSIT_STATUS>
            }
        </ns1:confirmaChequeVirtualResponse>
};

declare variable $confirmarLiberacionFondosChqVirtResponse as element(ns0:ConfirmarLiberacionFondosChqVirtResponse) external;

xf:confirmarLiberacionFondosChqVirtOut($confirmarLiberacionFondosChqVirtResponse)