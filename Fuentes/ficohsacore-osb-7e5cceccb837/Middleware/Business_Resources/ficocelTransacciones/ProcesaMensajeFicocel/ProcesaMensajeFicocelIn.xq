(:: pragma bea:global-element-parameter parameter="$procesaMensajeFicocel" element="ns1:procesaMensajeFicocel" location="procesaMensajeFicocelTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:FicocelTransaccionesService" location="../Resources/XMLSchema_770518505.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeFicocelTypes";
declare namespace ns0 = "http://hn.com.ficohsa.ficoceltransacciones.service/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelTransacciones/ProcesaMensajeFicocel/ProcesaMensajeFicocelIn/";

declare function xf:ProcesaMensajeFicocelIn($procesaMensajeFicocel as element(ns1:procesaMensajeFicocel))
    as element(ns0:FicocelTransaccionesService) {
        <ns0:FicocelTransaccionesService>
            <ns0:Request>
                <NumeroTelefono>{ data($procesaMensajeFicocel/MOBILE_NUMBER) }</NumeroTelefono>
                <PalabraCorta>{ data($procesaMensajeFicocel/KEYWORD) }</PalabraCorta>
                {
                    for $PIN_NUMBER in $procesaMensajeFicocel/PIN_NUMBER
                    return
                        <Pin>{ data($PIN_NUMBER) }</Pin>
                }
                {
                    for $PRODUCT_ALIAS in $procesaMensajeFicocel/PRODUCT_ALIAS
                    return
                        <Alias>{ data($PRODUCT_ALIAS) }</Alias>
                }
                {
                    for $PRIMARY_KEY in $procesaMensajeFicocel/PRIMARY_KEY
                    return
                        <ClavePrimaria>{ data($PRIMARY_KEY) }</ClavePrimaria>
                }
                {
                    for $AMOUNT in $procesaMensajeFicocel/AMOUNT
                    return
                        <Monto>{ data($AMOUNT) }</Monto>
                }
            </ns0:Request>
        </ns0:FicocelTransaccionesService>
};

declare variable $procesaMensajeFicocel as element(ns1:procesaMensajeFicocel) external;

xf:ProcesaMensajeFicocelIn($procesaMensajeFicocel)