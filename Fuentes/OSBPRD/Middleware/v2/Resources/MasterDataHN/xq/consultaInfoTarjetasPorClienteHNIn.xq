(:: pragma bea:global-element-parameter parameter="$consultaInfoTarjetasPorCliente" element="ns0:consultaInfoTarjetasPorCliente" location="../../ConsultaInfoTarjetasPorCliente/xsd/consultaInfoTarjetasPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataHN/consultaInfoTarjetasPorCliente/xsd/consultaInfoTarjetasPorCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInfoTarjetasPorClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInfoTarjetasPorCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/consultaInfoTarjetasClienteHNIn/";

declare function xf:consultaInfoTarjetasPorClienteHNIn($consultaInfoTarjetasPorCliente as element(ns0:consultaInfoTarjetasPorCliente),
    $SourceBank as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $SourceBank }</ns1:Pais>
            {
                for $CUSTOMER_ID_VALUE in $consultaInfoTarjetasPorCliente/CUSTOMER_ID_VALUE
                return
                    <ns1:NumCliente>{ data($CUSTOMER_ID_VALUE) }</ns1:NumCliente>
            }
        </ns1:InputParameters>
};

declare variable $consultaInfoTarjetasPorCliente as element(ns0:consultaInfoTarjetasPorCliente) external;
declare variable $SourceBank as xs:string external;

xf:consultaInfoTarjetasPorClienteHNIn($consultaInfoTarjetasPorCliente,
    $SourceBank)