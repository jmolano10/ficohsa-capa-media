xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$evaluaCuentaAbanksTypeResponse1" element="ns1:EvaluaCuentaAbanksTypeResponse" location="../../../../v2/BusinessServices/EvaluaCuentaAbanks/xsd/EvaluaCuentaAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/ABKPA/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetallesCuenta";
declare namespace ns1 = "EvaluaCuentaAbanks";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuenta/xq/consultaDetalleCuentaPAIn/";

declare function xf:consultaDetalleCuentaPAIn($evaluaCuentaAbanksTypeResponse1 as element(ns1:EvaluaCuentaAbanksTypeResponse),
    $index as xs:int)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                let $ACCOUNT_ID := $evaluaCuentaAbanksTypeResponse1/ns1:EvaluaCuentaAbanksTypeResponse[$index]/ns1:ACCOUNT_ID
                return
                    <ns0:ACCOUNT_NUMBER>{ data($ACCOUNT_ID) }</ns0:ACCOUNT_NUMBER>
            }
        </ns0:InputParameters>
};

declare variable $evaluaCuentaAbanksTypeResponse1 as element(ns1:EvaluaCuentaAbanksTypeResponse) external;
declare variable $index as xs:int external;

xf:consultaDetalleCuentaPAIn($evaluaCuentaAbanksTypeResponse1,
    $index)