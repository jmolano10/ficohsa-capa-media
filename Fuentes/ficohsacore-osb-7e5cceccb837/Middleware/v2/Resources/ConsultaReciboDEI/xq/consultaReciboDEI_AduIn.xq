(:: pragma bea:global-element-parameter parameter="$consultaRecibo" element="ns1:consultaRecibo" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/consultaReciboADU/xsd/ConsultaReciboAdu_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaReciboAdu";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEI_AduIn/";

declare function xf:consultaReciboDEI_AduIn($consultaRecibo as element(ns1:consultaRecibo),
    $numeroContraro as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CONTRATO>{ $numeroContraro }</ns0:PV_CONTRATO>
            <ns0:PV_CODIGOTRANSACCION>{ data($consultaRecibo/BILL_NUMBER) }</ns0:PV_CODIGOTRANSACCION>
            {
                for $USER_ID in $consultaRecibo/USER_ID
                return
                    <ns0:PV_CODIGODEUDOR>{ data($USER_ID) }</ns0:PV_CODIGODEUDOR>
            }
        </ns0:InputParameters>
};

declare variable $consultaRecibo as element(ns1:consultaRecibo) external;
declare variable $numeroContraro as xs:string external;

xf:consultaReciboDEI_AduIn($consultaRecibo,
    $numeroContraro)