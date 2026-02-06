xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorCliente" element="ns1:consultaTarjetasCreditoPorCliente" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conDatoTarjetasActivasCliente_v2/xsd/conDatoTarjetasActivasCliente_V2_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaTarjetasCreditoPorCliente/xq/conDatosTarjetasActivasClienteIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetasActivasCliente_V2";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";

declare function xf:conDatosTarjetasActivasClienteIn($codigoPais as xs:string,
$consultaTarjetasCreditoPorCliente as element(ns1:consultaTarjetasCreditoPorCliente))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>        
            <ns0:NumCliente>{ data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_VALUE) }</ns0:NumCliente>
            <ns0:Tipo>
                {
                    let $customerIdType  := (data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_TYPE))  
                    return
                        if ($customerIdType = "CUSTOMER_ID") then
                            (1)
                        else 
                            if ($customerIdType = "LEGAL_ID") then
                                (2)
                            else 
                                ()
                }
			</ns0:Tipo>
        </ns0:InputParameters>
};

declare variable $consultaTarjetasCreditoPorCliente as element(ns1:consultaTarjetasCreditoPorCliente) external;
declare variable $codigoPais as xs:string external;

xf:conDatosTarjetasActivasClienteIn($codigoPais, $consultaTarjetasCreditoPorCliente)