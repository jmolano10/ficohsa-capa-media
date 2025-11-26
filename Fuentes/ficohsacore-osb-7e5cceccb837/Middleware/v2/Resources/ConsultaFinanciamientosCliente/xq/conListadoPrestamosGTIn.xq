(:: pragma bea:global-element-parameter parameter="$consultaFinanciamientosCliente1" element="ns0:consultaFinanciamientosCliente" location="../xsd/consultaFinanciamientosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataGT/conListadoPrestamos/xsd/conListadoPrestamos_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientosCliente/xq/conListadoPrestamosGTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conListadoPrestamos";

declare function xf:conListadoPrestamosGTIn($consultaFinanciamientosCliente1 as element(ns0:consultaFinanciamientosCliente),
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        <ns1:Pais>{ $pais }</ns1:Pais>
            <ns1:NumeroB>{ data($consultaFinanciamientosCliente1/SEARCH_VALUE) }</ns1:NumeroB>
            {
                for $LOGO in $consultaFinanciamientosCliente1/LOGO
                return
                	<ns1:Logo>{data($LOGO)}</ns1:Logo>
            }
            <ns1:Tipo>
            { 
                let $search_criterial := upper-case(string($consultaFinanciamientosCliente1/SEARCH_CRITERIA/text()))
                return
                   if($search_criterial = "CUSTOMER_ID")then (
                    
                       2
                       
                     )elseif($search_criterial = "CARD_NUMBER")then (
                    
                      1
                      
                     )else()
             }
            </ns1:Tipo>
        </ns1:InputParameters>
};

declare variable $consultaFinanciamientosCliente1 as element(ns0:consultaFinanciamientosCliente) external;
declare variable $pais as xs:string external;

xf:conListadoPrestamosGTIn($consultaFinanciamientosCliente1,
    $pais)