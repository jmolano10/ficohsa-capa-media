(:: pragma bea:global-element-parameter parameter="$consultaRemesasResponse1" element="ns1:consultaRemesasResponse" location="../xsd/consultaRemesasCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/LimitesTransaccionalesTNG/limiteTrxregistrar/xsd/limiteTrxRegistrar_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasCBTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/limiteTrxRegistrar";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesasCB/xq/limiteTransacionalRegistrarIn/";

declare function xf:limiteTransacionalRegistrarIn($consultaRemesasResponse1 as element(ns1:consultaRemesasResponse),
    $IdCliente as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID_CLIENTE>{ $IdCliente }</ns0:PV_ID_CLIENTE>
            {
                for $REMITTANCE_AMOUNT in $consultaRemesasResponse1/ns1:consultaRemesasResponseType/ns1:consultaRemesasResponseRecordType[1]/REMITTANCE_AMOUNT
                return
                    <ns0:PV_MONTO_FLOTANTE>{ data($REMITTANCE_AMOUNT) }</ns0:PV_MONTO_FLOTANTE>
            }
            {
                for $EXCHANGE_RATE in $consultaRemesasResponse1/ns1:consultaRemesasResponseType/ns1:consultaRemesasResponseRecordType[1]/EXCHANGE_RATE
                return
                    <ns0:PV_TASA_CAMBIO>{ data($EXCHANGE_RATE) }</ns0:PV_TASA_CAMBIO>
            }
        </ns0:InputParameters>
};

declare variable $consultaRemesasResponse1 as element(ns1:consultaRemesasResponse) external;
declare variable $IdCliente as xs:string external;

xf:limiteTransacionalRegistrarIn($consultaRemesasResponse1,
    $IdCliente)
