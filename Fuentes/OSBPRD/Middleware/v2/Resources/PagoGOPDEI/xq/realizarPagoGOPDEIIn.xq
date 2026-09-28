(:: pragma bea:global-element-parameter parameter="$pagoGOP" element="ns0:pagoGOP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/pagoGOP/validarPagoGOP/xsd/validarPagoGOP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/DEI/pagoGOP/realizarPagoGOP/xsd/realizarPagoGOP_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/realizarPagoGOP";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarPagoGOP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoGOPDEI/xq/realizarPagoGOPDEIIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:realizarPagoGOPDEIIn($pagoGOP as element(ns0:pagoGOP),
    $requestHeader as element(ns3:RequestHeader),
    $outputParameters as element(ns1:OutputParameters),
    $TRANSACCIONID as xs:string,
    $fechaRegistro as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PT_AUDITORIAINFO>
                <ns2:RTN>{ data($pagoGOP/RTN) }</ns2:RTN>
                <ns2:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns2:USUARIO_SERVICIO>
            </ns2:PT_AUDITORIAINFO>
            <ns2:PV_CODIGOCLIENTEBANCO>{ data($pagoGOP/CUSTOMER_ID) }</ns2:PV_CODIGOCLIENTEBANCO>
            <ns2:PV_CODIGOGUIAPAGO>{ data($pagoGOP/GOP_CODE) }</ns2:PV_CODIGOGUIAPAGO>
            {
                for $CONTRACT_NUMBER in $pagoGOP/CONTRACT_NUMBER
                return
                    <ns2:PV_NUMEROCONTRATO>{ data($CONTRACT_NUMBER) }</ns2:PV_NUMEROCONTRATO>
            }
            <ns2:PV_CODIGOMONEDA>{ data($pagoGOP/CURRENCY) }</ns2:PV_CODIGOMONEDA>
            <ns2:PV_PERIODO>{ data($pagoGOP/PERIOD) }</ns2:PV_PERIODO>
            <ns2:PN_TOTALPAGO>{ data($pagoGOP/TOTAL_PAYMENT) }</ns2:PN_TOTALPAGO>
            <ns2:PV_TRANSACCIONID>{ $TRANSACCIONID }</ns2:PV_TRANSACCIONID>
            {
                for $PV_CONTRATOT24 in $outputParameters/ns1:PV_CONTRATOT24
                return
                    <ns2:PV_CONTRATOT24>{ data($PV_CONTRATOT24) }</ns2:PV_CONTRATOT24>
            }
            <ns2:PD_FECHAREGISTRO>{ fn-bea:dateTime-from-string-with-format("yyyyMMddHHmm", $fechaRegistro)}</ns2:PD_FECHAREGISTRO>
            <ns2:PV_IDUSUARIO>{ data($pagoGOP/USER_ID) }</ns2:PV_IDUSUARIO>
        </ns2:InputParameters>
};

declare variable $pagoGOP as element(ns0:pagoGOP) external;
declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $TRANSACCIONID as xs:string external;
declare variable $fechaRegistro as xs:string external;

xf:realizarPagoGOPDEIIn($pagoGOP,
    $requestHeader,
    $outputParameters,
    $TRANSACCIONID,
    $fechaRegistro)