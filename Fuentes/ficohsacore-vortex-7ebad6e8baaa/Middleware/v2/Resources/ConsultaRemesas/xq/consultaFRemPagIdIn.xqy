xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns0:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/consultarRemFRemXPagador/xsd/consultarRemFRemXPagador_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemFRemXPagador";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/consultaFRemPagIdIn/";

declare function xf:consultaFRemPagIdIn($consultaRemesas1 as element(ns0:consultaRemesas),
    $payer as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $REMITTANCE_ID in $consultaRemesas1/REMITTANCE_ID
                return
                    <ns1:PV_REMESA>{ data($REMITTANCE_ID) }</ns1:PV_REMESA>
            }
            <ns1:PV_PAGADOR_DEST>{ $payer }</ns1:PV_PAGADOR_DEST>
        </ns1:InputParameters>
};

declare variable $consultaRemesas1 as element(ns0:consultaRemesas) external;
declare variable $payer as xs:string external;

xf:consultaFRemPagIdIn($consultaRemesas1,
    $payer)