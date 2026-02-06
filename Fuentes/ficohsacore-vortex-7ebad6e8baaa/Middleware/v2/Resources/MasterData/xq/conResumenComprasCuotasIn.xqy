xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conResumenComprasCuotas/xsd/conResumenComprasCuotas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conResumenComprasCuotas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterData/xq/conResumenComprasCuotasIn/";

declare function xf:conResumenComprasCuotasIn($pais as xs:string,
    $numCuenta as xs:string,
    $tipo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $pais }</ns0:Pais>
            <ns0:Org></ns0:Org>
            <ns0:NumCuenta>{ fn-bea:pad-left($numCuenta, 19, '0') }</ns0:NumCuenta>
            <ns0:Tipo>
                {
                    if ($tipo = 'CARD_NUMBER') then
                        (1)
                    else 
                        0
                }
</ns0:Tipo>
        </ns0:InputParameters>
};

declare variable $pais as xs:string external;
declare variable $numCuenta as xs:string external;
declare variable $tipo as xs:string external;

xf:conResumenComprasCuotasIn($pais,
    $numCuenta,
    $tipo)